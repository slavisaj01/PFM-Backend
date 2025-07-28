let categories = [];
let selectedTransactionId = null;
let currentPage = 1;
let totalPages = 1;

const transactionKinds = [
  { value: "dep", label: "Deposit" },
  { value: "wdw", label: "Withdrawal" },
  { value: "pmt", label: "Payment" },
  { value: "fee", label: "Fee" },
  { value: "inc", label: "Interest credit" },
  { value: "rev", label: "Reversal" },
  { value: "adj", label: "Adjustment" },
  { value: "lnd", label: "Loan disbursement" },
  { value: "lnr", label: "Loan repayment" },
  { value: "fcx", label: "Foreign currency exchange" },
  { value: "aop", label: "Account openning" },
  { value: "acl", label: "Account closing" },
  { value: "spl", label: "Split payment" },
  { value: "sal", label: "Salary" },
];

function populateKindFilter() {
  const select = document.getElementById("filter-kind");
  select.innerHTML = '<option value="">All</option>';
  transactionKinds.forEach(({ value, label }) => {
    const opt = document.createElement("option");
    opt.value = value;
    opt.textContent = label;
    select.appendChild(opt);
  });
}

function getKindLabel(value) {
  const found = transactionKinds.find(k => k.value === value);
  return found ? found.label : value;
}

function getDirectionIcon(direction) {
  return direction === "c" || direction === "u"
    ? '<span class="direction-up">&#8593;</span>'
    : '<span class="direction-down">&#8595;</span>';
}

function formatDate(dateStr) {
  if (!dateStr) return "";
  const d = new Date(dateStr);
  return d.toLocaleDateString();
}

async function fetchCategories() {
  try {
    const res = await fetch("https://localhost:7138/categories");
    const data = await res.json();
    categories = data.items || [];
  } catch {
    categories = [];
  }
}

async function fetchTransactions(page = 1, pageSize = 10) {
  try {
    const kind = document.getElementById("filter-kind")?.value;
    const start = document.getElementById("filter-start")?.value;
    const end = document.getElementById("filter-end")?.value;

    const query = new URLSearchParams({ "page-number": page, "page-size": pageSize });
    if (kind) query.append("transaction-kind", kind);
    if (start) query.append("start-date", start);
    if (end) query.append("end-date", end);

    const response = await fetch(`https://localhost:7138/transactions?${query.toString()}`);
    const data = await response.json();

    currentPage = data.page || 1;
    totalPages = data["total-pages"] || 1;
    renderTable(data.items || []);
    renderPagination(currentPage, totalPages);
  } catch (err) {
    document.getElementById("transaction-table-body").innerHTML =
      `<tr><td colspan="7" class="text-danger">${err.message}</td></tr>`;
    renderPagination(1, 1);
  }
}

function renderTable(transactions) {
  const tbody = document.getElementById("transaction-table-body");
  if (!transactions.length) {
    tbody.innerHTML = `<tr><td colspan="7" class="text-center">No transactions found.</td></tr>`;
    return;
  }

 tbody.innerHTML = transactions
  .map(tx => {
    const cat = categories.find(c => c.code === tx["cat-code"]);
    const catName = cat?.name || null;
    const catBtn = catName
      ? `<button class="btn btn-split assigned btn-sm" onclick='openCategoryModal("${tx.id}", "${tx["cat-code"]}")'>${catName}</button>`
      : `<button class="btn btn-split add-category btn-sm" onclick='openCategoryModal("${tx.id}", null)'>Add category</button>`;

      return `
        <tr>
          <td>
            <div>${tx["beneficiary-name"] || ""}</div>
            <div style="font-size: 0.75em; color: #aaa">${tx.id || ""}</div>
          </td>
          <td>${formatDate(tx.date)}</td>
          <td>${getDirectionIcon(tx.direction)}</td>
          <td>${tx.amount != null ? tx.amount : ""}</td>
          <td>${tx.currency || ""}</td>
          <td>${getKindLabel(tx.kind)}</td>
          <td>${catBtn}</td>
        </tr>`;
    })
    .join("");
}

function renderPagination(page, total) {
  const nav = document.getElementById("pagination-nav");
  if (!nav) return;

  const createPageItem = (p, isActive, isDisabled, label = null) =>
    `<li class="page-item ${isActive ? "active" : ""} ${isDisabled ? "disabled" : ""}">
       <a class="page-link pagination-btn" href="#" data-page="${p}">${label || p}</a>
     </li>`;

  let html = `<ul class="pagination justify-content-center mb-0">`;
  html += createPageItem(page - 1, false, page === 1, "Previous");

  const range = [];
  if (total <= 5) {
    for (let i = 1; i <= total; i++) range.push(i);
  } else if (page <= 3) {
    range.push(1, 2, 3, 4, "...", total);
  } else if (page >= total - 2) {
    range.push(1, "...", total - 3, total - 2, total - 1, total);
  } else {
    range.push(1, "...", page - 1, page, page + 1, "...", total);
  }

  for (const p of range) {
    html += p === "..." ? `<li class="page-item disabled"><span class="page-link">...</span></li>` : createPageItem(p, p === page);
  }

  html += createPageItem(page + 1, false, page === total, "Next") + "</ul>";
  nav.innerHTML = html;

  nav.querySelectorAll(".pagination-btn").forEach(btn => {
    btn.onclick = (e) => {
      e.preventDefault();
      const p = parseInt(btn.dataset.page);
      if (!isNaN(p) && p !== page && p >= 1 && p <= total) fetchTransactions(p);
    };
  });
}

function openCategoryModal(transactionId, current_cat_code) {
  selectedTransactionId = transactionId;
  
  console.log("=== DEBUGGING ===");
  console.log("current_cat_code:", current_cat_code);
  
  const categorySelect = document.getElementById("categorySelect");
  const subcategorySelect = document.getElementById("subcategorySelect");
  
  categorySelect.innerHTML = "";
  subcategorySelect.innerHTML = "";

  // ▪️ Parent kategorije (one sa praznim parent-code)
  const parentCategories = categories.filter(cat => !cat['parent-code'] || cat['parent-code'] === "");
  
  console.log("parentCategories:", parentCategories);
  
  parentCategories.forEach(cat => {
    const option = document.createElement("option");
    option.value = cat.code;
    option.textContent = cat.name;
    categorySelect.appendChild(option);
  });

  // ▪️ Ako transakcija već ima kategoriju
  if (current_cat_code) {
    const selectedCat = categories.find(cat => cat.code === current_cat_code);
    console.log("selectedCat:", selectedCat);
    
    if (selectedCat) {
      if (selectedCat['parent-code'] && selectedCat['parent-code'] !== "") {
        console.log("PODKATEGORIJA - selectedCat ima parent-code:", selectedCat['parent-code']);
        
        // Podkategorija - prvo setuj parent, zatim popuni i setuj subcategory
        const parent = categories.find(cat => cat.code === selectedCat['parent-code']);
        console.log("parent kategorija:", parent);
        
        if (parent) {
          console.log("Setujem categorySelect.value na:", parent.code);
          categorySelect.value = parent.code;
          
          console.log("Pozivam populateSubcategories sa:", parent.code);
          populateSubcategories(parent.code);
          
          // Sačekaj da se subcategories popune, zatim setuj vrednost
          setTimeout(() => {
            console.log("Setujem subcategorySelect.value na:", selectedCat.code);
            subcategorySelect.value = selectedCat.code;
            console.log("Finalna vrednost subcategorySelect:", subcategorySelect.value);
          }, 10);
        }
      } else {
        console.log("GLAVNA KATEGORIJA - nema parent-code ili je prazan");
        
        // Glavna kategorija - setuj glavnu i popuni subcategories (ali ostavi prazno)
        console.log("Setujem categorySelect.value na:", selectedCat.code);
        categorySelect.value = selectedCat.code;
        
        console.log("Pozivam populateSubcategories sa:", selectedCat.code);
        populateSubcategories(selectedCat.code);
      }
    }
  }

  // 🔁 Onchange za punjenje podkategorija
  categorySelect.onchange = function () {
    console.log("Category changed to:", this.value);
    populateSubcategories(this.value);
  };

  const modal = new bootstrap.Modal(document.getElementById("categoryModal"));
  modal.show();
}

function populateSubcategories(parentCode) {
  console.log("populateSubcategories pozvana sa:", parentCode);
  
  const subcategorySelect = document.getElementById("subcategorySelect");
  subcategorySelect.innerHTML = "";

  // Traži sve kategorije čiji je parent-code jednak parentCode
  const subcategories = categories.filter(cat => cat['parent-code'] === parentCode);
  console.log("Pronađene subcategories:", subcategories);

  const placeholder = document.createElement("option");
  placeholder.value = "";
  placeholder.textContent = "Select subcategory (optional)";
  subcategorySelect.appendChild(placeholder);

  subcategories.forEach(cat => {
    const option = document.createElement("option");
    option.value = cat.code;
    option.textContent = cat.name;
    subcategorySelect.appendChild(option);
    console.log("Dodao subcategory option:", cat.code, cat.name);
  });
  
  console.log("subcategorySelect opcije nakon populacije:", subcategorySelect.innerHTML);
}



document.getElementById("saveCategoryBtn").onclick = async () => {
  const catCode = 
    document.getElementById("subcategorySelect").value ||
    document.getElementById("categorySelect").value;
    
  if (!catCode || !selectedTransactionId) return;

  await fetch(`https://localhost:7138/transactions/${selectedTransactionId}/categorize`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ "cat-code": catCode }),
  });

  fetchTransactions(currentPage);
  bootstrap.Modal.getInstance(document.getElementById("categoryModal")).hide();
};

document.querySelector(".filters-btn").onclick = () => {
  document.getElementById("filters-panel").classList.toggle("d-none");
};
document.getElementById("apply-filters").onclick = () => fetchTransactions(1);
document.getElementById("reset-filters").onclick = () => {
  document.getElementById("filter-kind").value = "";
  document.getElementById("filter-start").value = "";
  document.getElementById("filter-end").value = "";
  fetchTransactions(1);
};

window.addEventListener("DOMContentLoaded", async () => {
  populateKindFilter();
  await fetchCategories();
  await fetchTransactions(1);
});

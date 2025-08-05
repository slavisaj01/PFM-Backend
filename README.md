# PFM Backend

**PFM (Personal Finance Management)** is a backend microservice built with **.NET 8**, following **CQRS** and **Clean Architecture** principles.  
It provides APIs for importing, categorizing, splitting, and analyzing personal finance transactions, with full validation support and Dockerized deployment.

---

## 🔹 Key Features

### **Transactions**
- **Import from CSV** (`POST /transactions/import`)
  - Accepts CSV formatted as `bank_transactions.csv`
  - Validates input according to **OAS3 spec**
  - Persists to PostgreSQL database
- **List with filters & pagination** (`GET /transactions`)
  - Filter by **date range** and **transaction kinds**
  - Supports pagination
  - Returns transaction splits if exist
- **Split transactions** (`POST /transactions/{id}/split`)
  - Split a transaction into multiple categories/subcategories
  - Replaces old splits if they exist
- **Manual categorization** (`POST /transactions/{id}/categorize`)
  - Validate that both transaction and category exist
  - Persist category assignment

### **Categories**
- **Import from CSV** (`POST /categories/import`)
  - Accepts `categories.csv` with hierarchical structure (parent-child)
  - Updates existing categories if code already exists
  - Links transactions via `catcode` foreign key

### **Analytics**
- **Spending analytics** (`GET /spending-analytics`)
  - Aggregates spendings by categories and subcategories
  - Filters by **category**, **date range**, and **direction** (credit/debit)

### **Automation**
- **Auto-categorization** (`POST /transactions/auto-categorize`)
  - Assigns categories based on **configurable JSON rules**
  - Does not overwrite manually assigned categories
  - Example:
    ```yaml
    rule-1:
      title: When beneficiary name contains "shell"
      catcode: 4
      predicate: beneficiary-name LIKE '%shell%'
    ```

---

## 🏗️ Architecture

This project follows **Clean Architecture** and **CQRS** principles for maintainability and testability.

**Layers:**
```
PFM.Backend/
│
├── src/
│   ├── PFM.Domain/          # Entities, Enums, Domain Interfaces
│   ├── PFM.Application/     # CQRS (Commands & Queries), DTOs, Validation
│   ├── PFM.Infrastructure/  # EF Core, Repositories, CSV Parser, Data Access
│   └── PFM.API/             # Controllers, Middleware, Swagger
│
├── tests/
│   └── PFM.ApiTests/        # Postman collections & Newman test reports
│
└── docker/                  # Dockerfile & docker-compose
```

**Key Patterns & Tools:**
- **CQRS + MediatR** – separation of read/write flows
- **Entity Framework Core** – PostgreSQL persistence
- **FluentValidation** – request validation
- **AutoMapper** – DTO ↔ Entity mapping
- **CsvHelper** – parsing CSV files
- **Custom Middleware** – handling validation & business exceptions
- **Dockerized Deployment** – ready for Rancher Desktop

---

## 🐳 Run with Docker

1️⃣ Clone the repository:
```bash
git clone https://github.com/slavisaj01/PFM.Backend.git
cd PFM.Backend
```

2️⃣ Build and start the containers:
```bash
docker-compose up --build
```

---

## 📊 API Endpoints Overview

| Feature                  | Endpoint                              | Method |
|--------------------------|---------------------------------------|--------|
| Import Transactions      | `/transactions/import`                 | POST   |
| List Transactions        | `/transactions`                        | GET    |
| Import Categories        | `/categories/import`                   | POST   |
| Categorize Transaction   | `/transactions/{id}/categorize`        | POST   |
| Spending Analytics       | `/spending-analytics`                  | GET    |
| Split Transaction        | `/transactions/{id}/split`             | POST   |
| Auto Categorize          | `/transactions/auto-categorize`        | POST   |

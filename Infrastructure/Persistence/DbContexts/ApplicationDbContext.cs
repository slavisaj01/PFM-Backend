using Microsoft.EntityFrameworkCore;
using PFM.Domain.Entities;
using PFM.Infrastructure.Persistence.Configurations;

namespace PFM.Infrastructure.Persistence.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        
    public DbSet<Transaction> Transactions { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfiguration(new TransactionEntityTypeConfiguration());
        base.OnModelCreating(modelBuilder);
    }
}


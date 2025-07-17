using Microsoft.EntityFrameworkCore;
using PFM.Domain.Entities;
using PFM.Infrastructure.Persistence.Configurations;
using PFM.Infrastructure.Persistence.EntityTypeConfigurations;

namespace PFM.Infrastructure.Persistence.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        
    public DbSet<Transaction> Transactions { get; set; }

    public DbSet<Category> Categories { get; set; }

    public DbSet<TransactionSplit> TransactionSplits { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfiguration(new CategoryEntityTypeConfiguration());
        modelBuilder.ApplyConfiguration(new TransactionEntityTypeConfiguration());
        modelBuilder.ApplyConfiguration(new TransactionSplitEntityTypeConfiguration());
        base.OnModelCreating(modelBuilder);
    }
}


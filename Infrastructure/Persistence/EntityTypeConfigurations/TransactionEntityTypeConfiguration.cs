using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PFM.Domain.Entities;

namespace PFM.Infrastructure.Persistence.Configurations;

public class TransactionEntityTypeConfiguration : IEntityTypeConfiguration<Transaction>
{
    public void Configure(EntityTypeBuilder<Transaction> builder)
    {
        builder.ToTable("Transactions");

        builder.HasKey(t => t.Id);
            
        builder.Property(t => t.Id)
            .HasMaxLength(50)
            .IsRequired();

        builder.Property(t => t.BeneficiaryName)
            .HasMaxLength(200);

        builder.Property(t => t.Date)
            .IsRequired();

        builder.Property(t => t.Direction)
            .HasConversion<string>()
            .IsRequired();

        builder.Property(t => t.Amount)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        builder.Property(t => t.Description)
            .HasMaxLength(500);

        builder.Property(t => t.Currency)
            .HasMaxLength(3)
            .IsRequired();

        builder.Property(t => t.Mcc);

        builder.Property(t => t.Kind)
            .HasConversion<string>()
            .IsRequired();

        builder.Property(t => t.CatCode)
            .HasColumnName("catcode")
            .HasMaxLength(50);

        builder.HasOne(t => t.Category)
            .WithMany(c => c.Transactions)
            .HasForeignKey(t => t.CatCode)
            .HasPrincipalKey(c => c.Code)
            .OnDelete(DeleteBehavior.SetNull);
        
    }


}


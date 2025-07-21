using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PFM.Domain.Entities;

namespace PFM.Infrastructure.Persistence.EntityTypeConfigurations;

public class TransactionSplitEntityTypeConfiguration : IEntityTypeConfiguration<TransactionSplit>
{
    public void Configure(EntityTypeBuilder<TransactionSplit> builder)
    {
        builder.HasKey(x => x.Id);

        builder.Property(x => x.Id)
               .IsRequired();

        builder.Property(x => x.TransactionId)
               .IsRequired();

        builder.Property(x => x.CategoryCode)
                .IsRequired()
                .HasMaxLength(50);

        builder.Property(x => x.Amount)
                .IsRequired()
                .HasPrecision(18, 2);

        builder.Property(x => x.CreatedAt)
                .HasColumnType("timestamp with time zone")
               .IsRequired();

        builder.HasOne(x => x.Transaction)
               .WithMany(t => t.Splits)
               .HasForeignKey(x => x.TransactionId)
               .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(x => x.Category)
               .WithMany()
               .HasForeignKey(x => x.CategoryCode)
               .OnDelete(DeleteBehavior.Restrict);
    }
}

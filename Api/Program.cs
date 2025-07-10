using Microsoft.EntityFrameworkCore;
using PFM.Api.Middleware;
using PFM.Application;
using PFM.Application.UseCases.Transactions.Commands;
using PFM.Infrastructure.DependecyInjection;
using PFM.Infrastructure.Persistence.Data;
using Serilog;
using System.Reflection;
namespace Api
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddControllers();

            builder.Services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

            builder.Services.AddMediatR(cfg => 
                cfg.RegisterServicesFromAssembly(typeof(PFM.Domain.AssemblyMarker).Assembly));

            builder.Services.AddInfrastructureServices();
            builder.Services.AddApplicationServices();
            builder.Services.AddSwaggerGen();

            Log.Logger = new LoggerConfiguration()
                .ReadFrom.Configuration(builder.Configuration)
                .CreateLogger();
            builder.Host.UseSerilog();


            var app = builder.Build();

            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }


            app.UseHttpsRedirection();

            app.UseMiddleware<ExceptionMiddleware>();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}

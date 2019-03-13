using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Authentication.Service.Extensions
{
    public static class StartupExtensions
    {
        public static IServiceCollection AddIdentityServer4(this IServiceCollection services, IConfiguration configuration)
        {
            string connStr = @"User ID=sa;Password=Password1!;Initial Catalog=AuthDB;Server=auth.database";

            services.AddIdentityServer()
                .AddConfigurationStore(options =>
                {
                    options.ConfigureDbContext = builder =>
                        builder.UseSqlServer(connStr);
                })
                .AddOperationalStore(options =>
                {
                    options.ConfigureDbContext = builder =>
                        builder.UseSqlServer(connStr);
                    options.EnableTokenCleanup = true;
                })
                .AddDeveloperSigningCredential()
                .AddTestUsers(Config.Trash.Config.GetUsers());

            return services;
        }
    }
}

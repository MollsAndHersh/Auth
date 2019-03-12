using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static IdentityModel.OidcConstants;

namespace Authentication.Service.Extensions
{
    public static class StartupExtensions
    {
        public static IServiceCollection AddIdentityServer4(this IServiceCollection services, IConfiguration configuration)
        {
            string connStr = @"User ID=sa;Password=Password1!;Initial Catalog=AuthDB;Server=auth.database";

            services.AddIdentityServer()
                //.AddConfigurationStore(options =>
                //{
                //    options.ConfigureDbContext = builder =>
                //        builder.UseSqlServer(connStr);
                //})
                //.AddOperationalStore(options =>
                //{
                //    options.ConfigureDbContext = builder =>
                //        builder.UseSqlServer(connStr);
                //    options.EnableTokenCleanup = true;
                //})
                .AddInMemoryApiResources(Config.Trash.Config.GetApiResources())
                .AddInMemoryClients(Config.Trash.Config.GetClients())
                .AddDeveloperSigningCredential()
                .AddTestUsers(Config.Trash.Config.GetUsers());

            return services;
        }
    }
}

using Authentication.Service.IdentityServer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Authentication.Service.Extensions.DependencyInjection
{
    public static class StartupExtensions
    {
        public static IServiceCollection AddIdentityServer4(this IServiceCollection services, IConfiguration configuration)
        {
            string connStr = @"User ID=sa;Password=Password1!;Initial Catalog=AuthDB;Server=WikittyBoom\SQL2017";

            services.AddIdentityServer(options =>
            {
                options.MutualTls.Enabled = true;
                options.MutualTls.ClientCertificateAuthenticationScheme = "x509";
            })
#if InMemory
                .AddTestUsers(Config.Trash.Config.GetUsers())
                .AddInMemoryApiResources(Config.Trash.Config.GetApiResources())
                .AddInMemoryClients(Config.Trash.Config.GetClients())
#else
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
                .AddResourceOwnerValidator<MyResourceOwnerPasswordValidator>()
                .AddProfileService<MyProfileService>()
#endif
                .AddMutualTlsSecretValidators()
                .AddDeveloperSigningCredential();

            return services;
        }
    }
}

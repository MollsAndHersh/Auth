using IdentityServer4.Models;
using IdentityServer4.Validation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Authentication.Service.IdentityServer
{
    public class MyResourceOwnerPasswordValidator : IResourceOwnerPasswordValidator
    {
        /// <summary>
        /// First Stop in user validation process.
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task ValidateAsync(ResourceOwnerPasswordValidationContext context)
        {
            if (context.UserName == "alice" && context.Password == "password")
            {
                context.Result = new GrantValidationResult(
                    subject: context.UserName,
                    authenticationMethod: "",
                    claims: null,
                    identityProvider: "local",
                    customResponse: null
                    );
            }
            else
            {
                context.Result = new GrantValidationResult(
                    error: TokenRequestErrors.InvalidRequest,
                    customResponse: null
                    );
            }
        }
    }
}

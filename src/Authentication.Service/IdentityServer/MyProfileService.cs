using IdentityServer4.Models;
using IdentityServer4.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Authentication.Service.IdentityServer
{
    public class MyProfileService : IProfileService
    {
        /// <summary>
        /// Final step in user validation process
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task GetProfileDataAsync(ProfileDataRequestContext context)
        {
            var test = context.RequestedClaimTypes;
        }

        /// <summary>
        /// Second step in user validation process
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public async Task IsActiveAsync(IsActiveContext context)
        {
            //TODO: 1 - Implement Some Logic here  to determine if user is active or not.
            context.IsActive = true;
        }
    }
}

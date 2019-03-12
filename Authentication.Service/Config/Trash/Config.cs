﻿using IdentityServer4.Models;
using IdentityServer4.Test;
using System.Collections.Generic;
using static IdentityServer4.IdentityServerConstants;

namespace Authentication.Service.Config.Trash
{
    public class Config
    {
        public static List<TestUser> GetUsers()
        {
            return new List<TestUser>
            {
                new TestUser
                {
                    SubjectId = "1",
                    Username = "alice",
                    Password = "password"
                },
                new TestUser
                {
                    SubjectId = "2",
                    Username = "bob",
                    Password = "password"
                }
            };
        }

        public static IEnumerable<Client> GetClients()
        {
            return new List<Client>
            {
                // other clients omitted...

                // resource owner password grant client
                new Client
                {
                    ClientId = "ro.client",
                    AllowedGrantTypes = GrantTypes.ResourceOwnerPassword,
                    RequireClientSecret = false,
                    //ClientSecrets =
                    //{
                    //    new Secret("secret".Sha256())
                    //},
                    AllowedScopes = { "api1" }
                }
            };
        }

        public static IEnumerable<ApiResource> GetApiResources()
        {
            return new List<ApiResource>
            {
                new ApiResource("api1", "My API")
            };
        }
    }
}

using IdentityModel;
using IdentityModel.Client;
using System;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace Authentication.Client.Mtls
{
    class Program
    {
        static void Main(string[] args)
        {
            var response = Task.Run(() => RequestTokenAsync()).Result;
        }

        static async Task<TokenResponse> RequestTokenAsync()
        {
            var handler = new HttpClientHandler();
            var cert = X509.LocalMachine.My.Thumbprint.Find("5af01afff10404da133926b27784df2c16b4cec1").Single();
            handler.ClientCertificates.Add(cert);

            var client = new HttpClient(handler);

            var disco = await client.GetDiscoveryDocumentAsync("https://kleptek.com/authentication.service");
            if (disco.IsError) 
                throw new Exception(disco.Error);

            var response = await client.RequestClientCredentialsTokenAsync(new ClientCredentialsTokenRequest
            {
                Address = disco
                                .TryGetValue(OidcConstants.Discovery.MtlsEndpointAliases)
                                .Value<string>(OidcConstants.Discovery.TokenEndpoint)
                                .ToString(),

                ClientId = "mtls.client2"
                
                //Scope = "api2"
            });

            if (response.IsError) throw new Exception(response.Error);

            //TODO: COnfigure IIS to Accept Client Certificates.

            return response;
        }
    }
}

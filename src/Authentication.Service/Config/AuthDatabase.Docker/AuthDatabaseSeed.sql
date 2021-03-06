﻿-------- Add Common Elements --------

-------- Add 'api1' Api Resources --------
IF NOT EXISTS(SELECT 1 FROM dbo.ApiResources WHERE Name = 'api1')
	BEGIN
		INSERT INTO [dbo].[ApiResources]
				   ([Created]
				   ,[Description]
				   ,[DisplayName]
				   ,[Enabled]
				   ,[LastAccessed]
				   ,[Name]
				   ,[NonEditable]
				   ,[Updated])
			 VALUES
				   (GETDATE()
				   ,NULL
				   ,'My API'
				   ,1
				   ,GETDATE()
				   ,'api1'
				   ,0
				   ,GETDATE())
	END
GO

-------- Add 'openid' Api Resources --------
IF NOT EXISTS(SELECT 1 FROM dbo.ApiResources WHERE Name = 'openid')
	BEGIN
		INSERT INTO [dbo].[ApiResources]
				   ([Created]
				   ,[Description]
				   ,[DisplayName]
				   ,[Enabled]
				   ,[LastAccessed]
				   ,[Name]
				   ,[NonEditable]
				   ,[Updated])
			 VALUES
				   (GETDATE()
				   ,NULL
				   ,'OpenId'
				   ,1
				   ,GETDATE()
				   ,'openid'
				   ,0
				   ,GETDATE())
	END
GO

-------- Add 'api1' Api Scope --------
DECLARE
	@apiResourceName nvarchar(200) = 'api1',
	@apiResourceId int

SELECT 
	@apiResourceId = Id
FROM 
	dbo.ApiResources
WHERE
	Name = @apiResourceName

IF NOT EXISTS(SELECT 1 FROM dbo.ApiScopes WHERE Name = @apiResourceName)
	BEGIN
		INSERT INTO [dbo].[ApiScopes]
				   ([ApiResourceId]
				   ,[Description]
				   ,[DisplayName]
				   ,[Emphasize]
				   ,[Name]
				   ,[Required]
				   ,[ShowInDiscoveryDocument])
			 VALUES
				   (@apiResourceId
				   ,NULL
				   ,'My API'
				   ,0
				   ,@apiResourceName
				   ,0
				   ,1)
		END
GO

-------- Add 'openid' Api Scope --------
DECLARE
	@apiResourceName nvarchar(200) = 'openid',
	@apiResourceId int

SELECT 
	@apiResourceId = Id
FROM 
	dbo.ApiResources
WHERE
	Name = @apiResourceName

IF NOT EXISTS(SELECT 1 FROM dbo.ApiScopes WHERE Name = @apiResourceName)
	BEGIN
		INSERT INTO [dbo].[ApiScopes]
				   ([ApiResourceId]
				   ,[Description]
				   ,[DisplayName]
				   ,[Emphasize]
				   ,[Name]
				   ,[Required]
				   ,[ShowInDiscoveryDocument])
			 VALUES
				   (@apiResourceId
				   ,NULL
				   ,'OpenId'
				   ,0
				   ,@apiResourceName
				   ,0
				   ,1)
		END
GO




-------- Add client demo.client and configure --------

-- Add Client demo.client
IF NOT EXISTS(SELECT 1 FROM dbo.Clients WHERE ClientId = 'demo.client')
	BEGIN
		PRINT 'Add Demo Client'

		INSERT INTO [dbo].[Clients]
				   ([AbsoluteRefreshTokenLifetime]
				   ,[AccessTokenLifetime]
				   ,[AccessTokenType]
				   ,[AllowAccessTokensViaBrowser]
				   ,[AllowOfflineAccess]
				   ,[AllowPlainTextPkce]
				   ,[AllowRememberConsent]
				   ,[AlwaysIncludeUserClaimsInIdToken]
				   ,[AlwaysSendClientClaims]
				   ,[AuthorizationCodeLifetime]
				   ,[BackChannelLogoutSessionRequired]
				   ,[BackChannelLogoutUri]
				   ,[ClientClaimsPrefix]
				   ,[ClientId]
				   ,[ClientName]
				   ,[ClientUri]
				   ,[ConsentLifetime]
				   ,[Created]
				   ,[Description]
				   ,[DeviceCodeLifetime]
				   ,[EnableLocalLogin]
				   ,[Enabled]
				   ,[FrontChannelLogoutSessionRequired]
				   ,[FrontChannelLogoutUri]
				   ,[IdentityTokenLifetime]
				   ,[IncludeJwtId]
				   ,[LastAccessed]
				   ,[LogoUri]
				   ,[NonEditable]
				   ,[RequireClientSecret]
				   ,[RequireConsent]
				   ,[RequirePkce]
				   ,[PairWiseSubjectSalt]
				   ,[ProtocolType]
				   ,[RefreshTokenExpiration]
				   ,[RefreshTokenUsage]
				   ,[SlidingRefreshTokenLifetime]
				   ,[UpdateAccessTokenClaimsOnRefresh]
				   ,[Updated]
				   ,[UserCodeType]
				   ,[UserSsoLifetime])
			 VALUES
				   (2592000
				   ,3600
				   ,0
				   ,0
				   ,0
				   ,0
				   ,1
				   ,0
				   ,0
				   ,300
				   ,1
				   ,NULL
				   ,'client_'
				   ,'demo.client'
				   ,NULL
				   ,NULL
				   ,NULL
				   ,GETDATE()
				   ,NULL
				   ,300
				   ,1
				   ,1
				   ,1
				   ,300
				   ,300
				   ,0
				   ,GETDATE()
				   ,NULL
				   ,0
				   ,0
				   ,1
				   ,0
				   ,NULL
				   ,'oidc'
				   ,1
				   ,1
				   ,1296000
				   ,0
				   ,GETDATE()
				   ,NULL
				   ,NULL)
	END
GO

-------- Add 'api1' Client Scope --------
DECLARE
	@apiResourceName nvarchar(200) = 'api1',
	@clientId int

SELECT 
	@clientId = Id
FROM 
	dbo.Clients
WHERE
	ClientId = 'demo.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientScopes WHERE ClientId = @clientId AND Scope = @apiResourceName)
	BEGIN
		INSERT INTO [dbo].[ClientScopes]
				   ([ClientId]
				   ,[Scope])
			 VALUES
				   (@clientId
				   ,@apiResourceName)
		END
GO

-------- Add 'openid' Client Scope --------
DECLARE
	@apiResourceName nvarchar(200) = 'openid',
	@clientId int

SELECT 
	@clientId = Id
FROM 
	dbo.Clients
WHERE
	ClientId = 'demo.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientScopes WHERE ClientId = @clientId AND Scope = @apiResourceName)
	BEGIN
		INSERT INTO [dbo].[ClientScopes]
				   ([ClientId]
				   ,[Scope])
			 VALUES
				   (@clientId
				   ,@apiResourceName)
		END
GO

-------- Add ClientGrantTypes record to associate 'demo.client' with Password GrantType --------
DECLARE
	@clientId int

SELECT 
	@clientId = Id
FROM
	dbo.Clients
WHERE
	ClientId = 'demo.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientGrantTypes WHERE clientId = @clientId AND GrantType = 'password')
	BEGIN
		PRINT 'Add ClientGrantTypes'

		INSERT INTO [dbo].[ClientGrantTypes]
           ([GrantType]
           ,[ClientId])
			 VALUES
				   ('password'
				   ,@clientId)
	END
GO



-------- Add client for service to service communication configure --------
IF NOT EXISTS(SELECT 1 FROM dbo.Clients WHERE ClientId = 'service.client')
	BEGIN
		PRINT 'Add Service Client'

		INSERT INTO [dbo].[Clients]
				   ([AbsoluteRefreshTokenLifetime]
				   ,[AccessTokenLifetime]
				   ,[AccessTokenType]
				   ,[AllowAccessTokensViaBrowser]
				   ,[AllowOfflineAccess]
				   ,[AllowPlainTextPkce]
				   ,[AllowRememberConsent]
				   ,[AlwaysIncludeUserClaimsInIdToken]
				   ,[AlwaysSendClientClaims]
				   ,[AuthorizationCodeLifetime]
				   ,[BackChannelLogoutSessionRequired]
				   ,[BackChannelLogoutUri]
				   ,[ClientClaimsPrefix]
				   ,[ClientId]
				   ,[ClientName]
				   ,[ClientUri]
				   ,[ConsentLifetime]
				   ,[Created]
				   ,[Description]
				   ,[DeviceCodeLifetime]
				   ,[EnableLocalLogin]
				   ,[Enabled]
				   ,[FrontChannelLogoutSessionRequired]
				   ,[FrontChannelLogoutUri]
				   ,[IdentityTokenLifetime]
				   ,[IncludeJwtId]
				   ,[LastAccessed]
				   ,[LogoUri]
				   ,[NonEditable]
				   ,[RequireClientSecret]
				   ,[RequireConsent]
				   ,[RequirePkce]
				   ,[PairWiseSubjectSalt]
				   ,[ProtocolType]
				   ,[RefreshTokenExpiration]
				   ,[RefreshTokenUsage]
				   ,[SlidingRefreshTokenLifetime]
				   ,[UpdateAccessTokenClaimsOnRefresh]
				   ,[Updated]
				   ,[UserCodeType]
				   ,[UserSsoLifetime])
			 VALUES
				   (2592000
				   ,3600
				   ,0
				   ,0
				   ,0
				   ,0
				   ,1
				   ,0
				   ,0
				   ,300
				   ,1
				   ,NULL
				   ,'client_'
				   ,'service.client'
				   ,NULL
				   ,NULL
				   ,NULL
				   ,GETDATE()
				   ,'Client for service to service communication'
				   ,300
				   ,1
				   ,1
				   ,1
				   ,NULL
				   ,300
				   ,0
				   ,GETDATE()
				   ,NULL
				   ,0
				   ,1
				   ,1
				   ,0
				   ,NULL
				   ,'oidc'
				   ,1
				   ,1
				   ,1296000
				   ,0
				   ,GETDATE()
				   ,NULL
				   ,NULL)
	END
GO

-------- Add 'api1' Client Scope --------
DECLARE
	@apiResourceName nvarchar(200) = 'api1',
	@clientId int

SELECT 
	@clientId = Id
FROM 
	dbo.Clients
WHERE
	ClientId = 'service.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientScopes WHERE ClientId = @clientId AND Scope = @apiResourceName)
	BEGIN
		INSERT INTO [dbo].[ClientScopes]
				   ([ClientId]
				   ,[Scope])
			 VALUES
				   (@clientId
				   ,@apiResourceName)
		END
GO

-------- Add ClientGrantTypes record to associate 'demo.client' with Password GrantType --------
DECLARE
	@clientId int

SELECT 
	@clientId = Id
FROM
	dbo.Clients
WHERE
	ClientId = 'service.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientGrantTypes WHERE clientId = @clientId AND GrantType = 'client_credentials')
	BEGIN
		PRINT 'Add ClientGrantTypes'

		INSERT INTO [dbo].[ClientGrantTypes]
           ([GrantType]
           ,[ClientId])
			 VALUES
				   ('client_credentials'
				   ,@clientId)
	END
GO

-------- Add ClientSecret record for Service.Client --------

DECLARE
	@clientId int

SELECT 
	@clientId = Id
FROM
	dbo.Clients
WHERE
	ClientId = 'service.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientSecrets WHERE clientId = @clientId)
	BEGIN
		INSERT INTO [dbo].[ClientSecrets]
				   ([ClientId]
				   ,[Created]
				   ,[Description]
				   ,[Expiration]
				   ,[Type]
				   ,[Value])
			 VALUES
				   (@clientId
				   ,GetDate()
				   ,'The value of the shared secret is secret'
				   ,NULL
				   ,'SharedSecret'
				   ,'K7gNU3sdo+OL0wNhqoVWhr3g6s1xYv72ol/pe/Unols=')
	END
GO





-------- Add client mtls.client and configure --------

-- Add Client demo.client
IF NOT EXISTS(SELECT 1 FROM dbo.Clients WHERE ClientId = 'mtls.client')
	BEGIN
		PRINT 'Add MTLS Client'

		INSERT INTO [dbo].[Clients]
				   ([AbsoluteRefreshTokenLifetime]
				   ,[AccessTokenLifetime]
				   ,[AccessTokenType]
				   ,[AllowAccessTokensViaBrowser]
				   ,[AllowOfflineAccess]
				   ,[AllowPlainTextPkce]
				   ,[AllowRememberConsent]
				   ,[AlwaysIncludeUserClaimsInIdToken]
				   ,[AlwaysSendClientClaims]
				   ,[AuthorizationCodeLifetime]
				   ,[BackChannelLogoutSessionRequired]
				   ,[BackChannelLogoutUri]
				   ,[ClientClaimsPrefix]
				   ,[ClientId]
				   ,[ClientName]
				   ,[ClientUri]
				   ,[ConsentLifetime]
				   ,[Created]
				   ,[Description]
				   ,[DeviceCodeLifetime]
				   ,[EnableLocalLogin]
				   ,[Enabled]
				   ,[FrontChannelLogoutSessionRequired]
				   ,[FrontChannelLogoutUri]
				   ,[IdentityTokenLifetime]
				   ,[IncludeJwtId]
				   ,[LastAccessed]
				   ,[LogoUri]
				   ,[NonEditable]
				   ,[RequireClientSecret]
				   ,[RequireConsent]
				   ,[RequirePkce]
				   ,[PairWiseSubjectSalt]
				   ,[ProtocolType]
				   ,[RefreshTokenExpiration]
				   ,[RefreshTokenUsage]
				   ,[SlidingRefreshTokenLifetime]
				   ,[UpdateAccessTokenClaimsOnRefresh]
				   ,[Updated]
				   ,[UserCodeType]
				   ,[UserSsoLifetime])
			 VALUES
				   (2592000
				   ,3600
				   ,0
				   ,0
				   ,0
				   ,0
				   ,1
				   ,0
				   ,0
				   ,300
				   ,1
				   ,NULL
				   ,'client_'
				   ,'mtls.client'
				   ,NULL
				   ,NULL
				   ,NULL
				   ,GETDATE()
				   ,'Client for MTLS communication'
				   ,300
				   ,1
				   ,1
				   ,1
				   ,300
				   ,300
				   ,0
				   ,GETDATE()
				   ,NULL
				   ,0
				   ,0
				   ,1
				   ,0
				   ,NULL
				   ,'oidc'
				   ,1
				   ,1
				   ,1296000
				   ,0
				   ,GETDATE()
				   ,NULL
				   ,NULL)
	END
GO

-------- Add 'api1' Client Scope --------
DECLARE
	@apiResourceName nvarchar(200) = 'api1',
	@clientId int

SELECT 
	@clientId = Id
FROM 
	dbo.Clients
WHERE
	ClientId = 'mtls.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientScopes WHERE ClientId = @clientId AND Scope = @apiResourceName)
	BEGIN
		INSERT INTO [dbo].[ClientScopes]
				   ([ClientId]
				   ,[Scope])
			 VALUES
				   (@clientId
				   ,@apiResourceName)
		END
GO

-------- Add ClientGrantTypes record to associate 'mtls.client' with Password GrantType --------
DECLARE
	@clientId int

SELECT 
	@clientId = Id
FROM
	dbo.Clients
WHERE
	ClientId = 'mtls.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientGrantTypes WHERE clientId = @clientId AND GrantType = 'client_credentials')
	BEGIN
		PRINT 'Add ClientGrantTypes'

		INSERT INTO [dbo].[ClientGrantTypes]
           ([GrantType]
           ,[ClientId])
			 VALUES
				   ('client_credentials'
				   ,@clientId)
	END
GO

-------- Add ClientSecret record for Service.Client --------

DECLARE
	@clientId int

SELECT 
	@clientId = Id
FROM
	dbo.Clients
WHERE
	ClientId = 'mtls.client'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientSecrets WHERE clientId = @clientId)
	BEGIN
		INSERT INTO [dbo].[ClientSecrets]
				   ([ClientId]
				   ,[Created]
				   ,[Description]
				   ,[Expiration]
				   ,[Type]
				   ,[Value])
			 VALUES
				   (@clientId
				   ,GetDate()
				   ,'The value of the MTLS Thumbprint'
				   ,NULL
				   ,'X509Thumbprint'
				   ,'bd63b996824714d80a343ea0c794ccc558e0eeb9')
	END
GO





-------- Add client mtls.client2 and configure --------

-- Add Client demo.client
IF NOT EXISTS(SELECT 1 FROM dbo.Clients WHERE ClientId = 'mtls.client2')
	BEGIN
		PRINT 'Add MTLS Client 2'

		INSERT INTO [dbo].[Clients]
				   ([AbsoluteRefreshTokenLifetime]
				   ,[AccessTokenLifetime]
				   ,[AccessTokenType]
				   ,[AllowAccessTokensViaBrowser]
				   ,[AllowOfflineAccess]
				   ,[AllowPlainTextPkce]
				   ,[AllowRememberConsent]
				   ,[AlwaysIncludeUserClaimsInIdToken]
				   ,[AlwaysSendClientClaims]
				   ,[AuthorizationCodeLifetime]
				   ,[BackChannelLogoutSessionRequired]
				   ,[BackChannelLogoutUri]
				   ,[ClientClaimsPrefix]
				   ,[ClientId]
				   ,[ClientName]
				   ,[ClientUri]
				   ,[ConsentLifetime]
				   ,[Created]
				   ,[Description]
				   ,[DeviceCodeLifetime]
				   ,[EnableLocalLogin]
				   ,[Enabled]
				   ,[FrontChannelLogoutSessionRequired]
				   ,[FrontChannelLogoutUri]
				   ,[IdentityTokenLifetime]
				   ,[IncludeJwtId]
				   ,[LastAccessed]
				   ,[LogoUri]
				   ,[NonEditable]
				   ,[RequireClientSecret]
				   ,[RequireConsent]
				   ,[RequirePkce]
				   ,[PairWiseSubjectSalt]
				   ,[ProtocolType]
				   ,[RefreshTokenExpiration]
				   ,[RefreshTokenUsage]
				   ,[SlidingRefreshTokenLifetime]
				   ,[UpdateAccessTokenClaimsOnRefresh]
				   ,[Updated]
				   ,[UserCodeType]
				   ,[UserSsoLifetime])
			 VALUES
				   (2592000
				   ,3600
				   ,0
				   ,0
				   ,0
				   ,0
				   ,1
				   ,0
				   ,0
				   ,300
				   ,1
				   ,NULL
				   ,'client_'
				   ,'mtls.client2'
				   ,NULL
				   ,NULL
				   ,NULL
				   ,GETDATE()
				   ,'Second Client for MTLS communication'
				   ,300
				   ,1
				   ,1
				   ,1
				   ,300
				   ,300
				   ,0
				   ,GETDATE()
				   ,NULL
				   ,0
				   ,0
				   ,1
				   ,0
				   ,NULL
				   ,'oidc'
				   ,1
				   ,1
				   ,1296000
				   ,0
				   ,GETDATE()
				   ,NULL
				   ,NULL)
	END
GO

-------- Add 'api1' Client Scope --------
DECLARE
	@apiResourceName nvarchar(200) = 'api1',
	@clientId int

SELECT 
	@clientId = Id
FROM 
	dbo.Clients
WHERE
	ClientId = 'mtls.client2'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientScopes WHERE ClientId = @clientId AND Scope = @apiResourceName)
	BEGIN
		INSERT INTO [dbo].[ClientScopes]
				   ([ClientId]
				   ,[Scope])
			 VALUES
				   (@clientId
				   ,@apiResourceName)
		END
GO

-------- Add ClientGrantTypes record to associate 'mtls.client2' with Password GrantType --------
DECLARE
	@clientId int

SELECT 
	@clientId = Id
FROM
	dbo.Clients
WHERE
	ClientId = 'mtls.client2'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientGrantTypes WHERE clientId = @clientId AND GrantType = 'client_credentials')
	BEGIN
		PRINT 'Add ClientGrantTypes'

		INSERT INTO [dbo].[ClientGrantTypes]
           ([GrantType]
           ,[ClientId])
			 VALUES
				   ('client_credentials'
				   ,@clientId)
	END
GO

-------- Add ClientSecret record for Service.Client --------

DECLARE
	@clientId int

SELECT 
	@clientId = Id
FROM
	dbo.Clients
WHERE
	ClientId = 'mtls.client2'

IF NOT EXISTS(SELECT 1 FROM dbo.ClientSecrets WHERE clientId = @clientId)
	BEGIN
		INSERT INTO [dbo].[ClientSecrets]
				   ([ClientId]
				   ,[Created]
				   ,[Description]
				   ,[Expiration]
				   ,[Type]
				   ,[Value])
			 VALUES
				   (@clientId
				   ,GetDate()
				   ,'The value of the MTLS Thumbprint (Client2)'
				   ,NULL
				   ,'X509Thumbprint'
				   ,'d1eb23a46d17d68fd92564c2f1f1601764d8e349')
	END
GO

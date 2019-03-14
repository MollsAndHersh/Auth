-------- Add Client 'DemoApp' --------

--If database does not exist, create database.
IF NOT EXISTS(SELECT 1 FROM dbo.Clients WHERE ClientId = 'demo.client')
	BEGIN
		PRINT 'Add DemoApp Client'

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
USE [AuthDB]
GO

-------- Add Client 'DemoApp' --------

--If database does not exist, create database.
IF NOT EXISTS(SELECT 1 FROM dbo.Clients WHERE ClientId = 'DemoApp')
	BEGIN
		PRINT 'Add DemoApp Client'

		INSERT INTO [dbo].[Clients]
				   ([Enabled]
				   ,[ClientId]
				   ,[ProtocolType]
				   ,[RequireClientSecret]
				   ,[ClientName]
				   ,[Description]
				   ,[ClientUri]
				   ,[LogoUri]
				   ,[RequireConsent]
				   ,[AllowRememberConsent]
				   ,[AlwaysIncludeUserClaimsInIdToken]
				   ,[RequirePkce]
				   ,[AllowPlainTextPkce]
				   ,[AllowAccessTokensViaBrowser]
				   ,[FrontChannelLogoutUri]
				   ,[FrontChannelLogoutSessionRequired]
				   ,[BackChannelLogoutUri]
				   ,[BackChannelLogoutSessionRequired]
				   ,[AllowOfflineAccess]
				   ,[IdentityTokenLifetime]
				   ,[AccessTokenLifetime]
				   ,[AuthorizationCodeLifetime]
				   ,[ConsentLifetime]
				   ,[AbsoluteRefreshTokenLifetime]
				   ,[SlidingRefreshTokenLifetime]
				   ,[RefreshTokenUsage]
				   ,[UpdateAccessTokenClaimsOnRefresh]
				   ,[RefreshTokenExpiration]
				   ,[AccessTokenType]
				   ,[EnableLocalLogin]
				   ,[IncludeJwtId]
				   ,[AlwaysSendClientClaims]
				   ,[ClientClaimsPrefix]
				   ,[PairWiseSubjectSalt]
				   ,[Created]
				   ,[Updated]
				   ,[LastAccessed]
				   ,[UserSsoLifetime]
				   ,[UserCodeType]
				   ,[DeviceCodeLifetime]
				   ,[NonEditable])
			 VALUES
				   (1
				   ,'DemoApp'
				   ,'oidc'
				   ,0
				   ,'Demo Application'
				   ,'This client for authenticating using a Username and Password'
				   ,NULL
				   ,NULL
				   ,0
				   ,0
				   ,0
				   ,0
				   ,0
				   ,1
				   ,NULL
				   ,1
				   ,NULL
				   ,1
				   ,0
				   ,300
				   ,3600
				   ,300
				   ,NULL
				   ,2592000
				   ,1296000
				   ,0
				   ,1
				   ,0
				   ,0
				   ,0
				   ,0
				   ,1
				   ,NULL
				   ,NULL
				   ,GETDATE()
				   ,NULL
				   ,NULL
				   ,NULL
				   ,NULL
				   ,300
				   ,0)
	END
GO
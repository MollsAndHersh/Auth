﻿--If database does not exist, create database.
IF NOT EXISTS(SELECT 1 FROM sys.Databases WHERE name = 'AuthDB')
	BEGIN
		PRINT 'Begin Create Database: AuthDB' 

		CREATE DATABASE AuthDB 
		ON
		( NAME = Auth_Dat,  
			FILENAME = '/var/lib/db/AuthDat.mdf',
			SIZE = 10MB,
			MAXSIZE = 50MB,
			FILEGROWTH = 5MB )  
		LOG ON
		( NAME = Auth_log,  
			FILENAME = '/var/lib/db/Authlog.ldf',
			SIZE = 5MB,
			MAXSIZE = 25MB,
			FILEGROWTH = 5MB );
		
		PRINT 'Database Created' 
	END
GO

USE AuthDB;
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ApiResources')
	BEGIN
		CREATE TABLE [ApiResources] (
			[Created] datetime2 NOT NULL,
			[Description] nvarchar(1000) NULL,
			[DisplayName] nvarchar(200) NULL,
			[Enabled] bit NOT NULL,
			[Id] int NOT NULL IDENTITY,
			[LastAccessed] datetime2 NULL,
			[Name] nvarchar(200) NOT NULL,
			[NonEditable] bit NOT NULL,
			[Updated] datetime2 NULL,
			CONSTRAINT [PK_ApiResources] PRIMARY KEY ([Id])
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'Clients')
	BEGIN
		CREATE TABLE [Clients] (
			[Id] int NOT NULL IDENTITY,
			[AbsoluteRefreshTokenLifetime] int NOT NULL,
			[AccessTokenLifetime] int NOT NULL,
			[AccessTokenType] int NOT NULL,
			[AllowAccessTokensViaBrowser] bit NOT NULL,
			[AllowOfflineAccess] bit NOT NULL,
			[AllowPlainTextPkce] bit NOT NULL,
			[AllowRememberConsent] bit NOT NULL,
			[AlwaysIncludeUserClaimsInIdToken] bit NOT NULL,
			[AlwaysSendClientClaims] bit NOT NULL,
			[AuthorizationCodeLifetime] int NOT NULL,
			[BackChannelLogoutSessionRequired] bit NOT NULL,
			[BackChannelLogoutUri] nvarchar(2000) NULL,
			[ClientClaimsPrefix] nvarchar(200) NULL,
			[ClientId] nvarchar(200) NOT NULL,
			[ClientName] nvarchar(200) NULL,
			[ClientUri] nvarchar(2000) NULL,
			[ConsentLifetime] int NULL,
			[Created] datetime2 NOT NULL,
			[Description] nvarchar(1000) NULL,
			[DeviceCodeLifetime] int NOT NULL,
			[EnableLocalLogin] bit NOT NULL,
			[Enabled] bit NOT NULL,
			[FrontChannelLogoutSessionRequired] bit NOT NULL,
			[FrontChannelLogoutUri] nvarchar(2000) NULL,
			[IdentityTokenLifetime] int NOT NULL,
			[IncludeJwtId] bit NOT NULL,
			[LastAccessed] datetime2 NULL,
			[LogoUri] nvarchar(2000) NULL,
			[NonEditable] bit NOT NULL,
			[RequireClientSecret] bit NOT NULL,
			[RequireConsent] bit NOT NULL,
			[RequirePkce] bit NOT NULL,
			[PairWiseSubjectSalt] nvarchar(200) NULL,
			[ProtocolType] nvarchar(200) NOT NULL,
			[RefreshTokenExpiration] int NOT NULL,
			[RefreshTokenUsage] int NOT NULL,
			[SlidingRefreshTokenLifetime] int NOT NULL,
			[UpdateAccessTokenClaimsOnRefresh] bit NOT NULL,
			[Updated] datetime2 NULL,
			[UserCodeType] nvarchar(100) NULL,
			[UserSsoLifetime] int NULL,
			CONSTRAINT [PK_Clients] PRIMARY KEY ([Id])
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'IdentityResources')
	BEGIN
		CREATE TABLE [IdentityResources] (
			[Id] int NOT NULL IDENTITY,
			[Created] datetime2 NOT NULL,
			[Description] nvarchar(1000) NULL,
			[DisplayName] nvarchar(200) NULL,
			[Emphasize] bit NOT NULL,
			[Enabled] bit NOT NULL,
			[Name] nvarchar(200) NOT NULL,
			[NonEditable] bit NOT NULL,
			[Required] bit NOT NULL,
			[ShowInDiscoveryDocument] bit NOT NULL,
			[Updated] datetime2 NULL,
			CONSTRAINT [PK_IdentityResources] PRIMARY KEY ([Id])
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ApiClaims')
	BEGIN
		CREATE TABLE [ApiClaims] (
			[Id] int NOT NULL IDENTITY,
			[ApiResourceId] int NOT NULL,
			[Type] nvarchar(200) NOT NULL,
			CONSTRAINT [PK_ApiClaims] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ApiClaims_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ApiProperties')
	BEGIN
		CREATE TABLE [ApiProperties] (
			[Id] int NOT NULL IDENTITY,
			[ApiResourceId] int NOT NULL,
			[Key] nvarchar(250) NOT NULL,
			[Value] nvarchar(2000) NOT NULL,
			CONSTRAINT [PK_ApiProperties] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ApiProperties_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ApiScopes')
	BEGIN
		CREATE TABLE [ApiScopes] (
			[Id] int NOT NULL IDENTITY,
			[ApiResourceId] int NOT NULL,
			[Description] nvarchar(1000) NULL,
			[DisplayName] nvarchar(200) NULL,
			[Emphasize] bit NOT NULL,
			[Name] nvarchar(200) NOT NULL,	
			[Required] bit NOT NULL,
			[ShowInDiscoveryDocument] bit NOT NULL,
			CONSTRAINT [PK_ApiScopes] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ApiScopes_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ApiSecrets')
	BEGIN
		CREATE TABLE [ApiSecrets] (
			[Id] int NOT NULL IDENTITY,
			[ApiResourceId] int NOT NULL,
			[Created] datetime2 NOT NULL,
			[Description] nvarchar(1000) NULL,
			[Expiration] datetime2 NULL,
			[Type] nvarchar(250) NOT NULL,
			[Value] nvarchar(4000) NOT NULL,
			CONSTRAINT [PK_ApiSecrets] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ApiSecrets_ApiResources_ApiResourceId] FOREIGN KEY ([ApiResourceId]) REFERENCES [ApiResources] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientClaims')
	BEGIN
		CREATE TABLE [ClientClaims] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[Type] nvarchar(250) NOT NULL,
			[Value] nvarchar(250) NOT NULL,			
			CONSTRAINT [PK_ClientClaims] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientClaims_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientCorsOrigins')
	BEGIN
		CREATE TABLE [ClientCorsOrigins] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[Origin] nvarchar(150) NOT NULL,
			CONSTRAINT [PK_ClientCorsOrigins] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientCorsOrigins_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientGrantTypes')
	BEGIN
		CREATE TABLE [ClientGrantTypes] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[GrantType] nvarchar(250) NOT NULL,
			CONSTRAINT [PK_ClientGrantTypes] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientGrantTypes_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientIdPRestrictions')
	BEGIN
		CREATE TABLE [ClientIdPRestrictions] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[Provider] nvarchar(200) NOT NULL,
			CONSTRAINT [PK_ClientIdPRestrictions] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientIdPRestrictions_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientPostLogoutRedirectUris')
	BEGIN
		CREATE TABLE [ClientPostLogoutRedirectUris] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[PostLogoutRedirectUri] nvarchar(2000) NOT NULL,
			CONSTRAINT [PK_ClientPostLogoutRedirectUris] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientPostLogoutRedirectUris_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientProperties')
	BEGIN
		CREATE TABLE [ClientProperties] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[Key] nvarchar(250) NOT NULL,
			[Value] nvarchar(2000) NOT NULL,
			CONSTRAINT [PK_ClientProperties] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientProperties_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientRedirectUris')
	BEGIN
		CREATE TABLE [ClientRedirectUris] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[RedirectUri] nvarchar(2000) NOT NULL,
			CONSTRAINT [PK_ClientRedirectUris] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientRedirectUris_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientScopes')
	BEGIN
		CREATE TABLE [ClientScopes] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[Scope] nvarchar(200) NOT NULL,
			CONSTRAINT [PK_ClientScopes] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientScopes_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ClientSecrets')
	BEGIN
		CREATE TABLE [ClientSecrets] (
			[Id] int NOT NULL IDENTITY,
			[ClientId] int NOT NULL,
			[Created] datetime2 NOT NULL,
			[Description] nvarchar(2000) NULL,
			[Expiration] datetime2 NULL,
			[Type] nvarchar(250) NOT NULL,
			[Value] nvarchar(4000) NOT NULL,
			CONSTRAINT [PK_ClientSecrets] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ClientSecrets_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'IdentityClaims')
	BEGIN
		CREATE TABLE [IdentityClaims] (
			[Id] int NOT NULL IDENTITY,
			[IdentityResourceId] int NOT NULL,
			[Type] nvarchar(200) NOT NULL,			
			CONSTRAINT [PK_IdentityClaims] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_IdentityClaims_IdentityResources_IdentityResourceId] FOREIGN KEY ([IdentityResourceId]) REFERENCES [IdentityResources] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'IdentityProperties')
	BEGIN
		CREATE TABLE [IdentityProperties] (
			[Id] int NOT NULL IDENTITY,
			[IdentityResourceId] int NOT NULL,
			[Key] nvarchar(250) NOT NULL,
			[Value] nvarchar(2000) NOT NULL,			
			CONSTRAINT [PK_IdentityProperties] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_IdentityProperties_IdentityResources_IdentityResourceId] FOREIGN KEY ([IdentityResourceId]) REFERENCES [IdentityResources] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'ApiScopeClaims')
	BEGIN
		CREATE TABLE [ApiScopeClaims] (
			[Id] int NOT NULL IDENTITY,
			[ApiScopeId] int NOT NULL,
			[Type] nvarchar(200) NOT NULL,			
			CONSTRAINT [PK_ApiScopeClaims] PRIMARY KEY ([Id]),
			CONSTRAINT [FK_ApiScopeClaims_ApiScopes_ApiScopeId] FOREIGN KEY ([ApiScopeId]) REFERENCES [ApiScopes] ([Id]) ON DELETE CASCADE
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'DeviceCodes')
	BEGIN
		CREATE TABLE [DeviceCodes] (
			[ClientId] nvarchar(200) NOT NULL,
			[CreationTime] datetime2 NOT NULL,
			[Data] nvarchar(max) NOT NULL,
			[DeviceCode] nvarchar(200) NOT NULL,
			[Expiration] datetime2 NOT NULL,
			[SubjectId] nvarchar(200) NULL,
			[UserCode] nvarchar(200) NOT NULL,			
			CONSTRAINT [PK_DeviceCodes] PRIMARY KEY ([UserCode])
		);
	END
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES
           WHERE TABLE_NAME = N'PersistedGrants')
	BEGIN
		CREATE TABLE [PersistedGrants] (
			[ClientId] nvarchar(200) NOT NULL,
			[CreationTime] datetime2 NOT NULL,
			[Data] nvarchar(max) NOT NULL,
			[Expiration] datetime2 NULL,
			[Key] nvarchar(200) NOT NULL,
			[SubjectId] nvarchar(200) NULL,
			[Type] nvarchar(50) NOT NULL,
			CONSTRAINT [PK_PersistedGrants] PRIMARY KEY ([Key])
		);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ApiClaims_ApiResourceId' 
    AND object_id = OBJECT_ID('[dbo].[ApiClaims]'))
	BEGIN
		CREATE INDEX [IX_ApiClaims_ApiResourceId] ON [ApiClaims] ([ApiResourceId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ApiProperties_ApiResourceId' 
    AND object_id = OBJECT_ID('[dbo].[ApiProperties]'))
	BEGIN
		CREATE INDEX [IX_ApiProperties_ApiResourceId] ON [ApiProperties] ([ApiResourceId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ApiResources_Name' 
    AND object_id = OBJECT_ID('[dbo].[ApiResources]'))
	BEGIN
		CREATE UNIQUE INDEX [IX_ApiResources_Name] ON [ApiResources] ([Name]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ApiScopeClaims_ApiScopeId' 
    AND object_id = OBJECT_ID('[dbo].[ApiScopeClaims]'))
	BEGIN
		CREATE INDEX [IX_ApiScopeClaims_ApiScopeId] ON [ApiScopeClaims] ([ApiScopeId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ApiScopes_ApiResourceId' 
    AND object_id = OBJECT_ID('[dbo].[ApiScopes]'))
	BEGIN
		CREATE INDEX [IX_ApiScopes_ApiResourceId] ON [ApiScopes] ([ApiResourceId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ApiScopes_Name' 
    AND object_id = OBJECT_ID('[dbo].[ApiScopes]'))
	BEGIN
		CREATE UNIQUE INDEX [IX_ApiScopes_Name] ON [ApiScopes] ([Name]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ApiSecrets_ApiResourceId' 
    AND object_id = OBJECT_ID('[dbo].[ApiSecrets]'))
	BEGIN
		CREATE INDEX [IX_ApiSecrets_ApiResourceId] ON [ApiSecrets] ([ApiResourceId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientClaims_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientClaims]'))
	BEGIN
		CREATE INDEX [IX_ClientClaims_ClientId] ON [ClientClaims] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientCorsOrigins_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientCorsOrigins]'))
	BEGIN
		CREATE INDEX [IX_ClientCorsOrigins_ClientId] ON [ClientCorsOrigins] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientGrantTypes_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientGrantTypes]'))
	BEGIN
		CREATE INDEX [IX_ClientGrantTypes_ClientId] ON [ClientGrantTypes] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientIdPRestrictions_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientIdPRestrictions]'))
	BEGIN
		CREATE INDEX [IX_ClientIdPRestrictions_ClientId] ON [ClientIdPRestrictions] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientPostLogoutRedirectUris_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientPostLogoutRedirectUris]'))
	BEGIN
		CREATE INDEX [IX_ClientPostLogoutRedirectUris_ClientId] ON [ClientPostLogoutRedirectUris] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientProperties_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientProperties]'))
	BEGIN
		CREATE INDEX [IX_ClientProperties_ClientId] ON [ClientProperties] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientRedirectUris_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientRedirectUris]'))
	BEGIN
		CREATE INDEX [IX_ClientRedirectUris_ClientId] ON [ClientRedirectUris] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_Clients_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[Clients]'))
	BEGIN
		CREATE UNIQUE INDEX [IX_Clients_ClientId] ON [Clients] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientScopes_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientScopes]'))
	BEGIN
		CREATE INDEX [IX_ClientScopes_ClientId] ON [ClientScopes] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_ClientSecrets_ClientId' 
    AND object_id = OBJECT_ID('[dbo].[ClientSecrets]'))
	BEGIN
		CREATE INDEX [IX_ClientSecrets_ClientId] ON [ClientSecrets] ([ClientId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_IdentityClaims_IdentityResourceId' 
    AND object_id = OBJECT_ID('[dbo].[IdentityClaims]'))
	BEGIN
		CREATE INDEX [IX_IdentityClaims_IdentityResourceId] ON [IdentityClaims] ([IdentityResourceId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_IdentityProperties_IdentityResourceId' 
    AND object_id = OBJECT_ID('[dbo].[IdentityProperties]'))
	BEGIN
		CREATE INDEX [IX_IdentityProperties_IdentityResourceId] ON [IdentityProperties] ([IdentityResourceId]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_IdentityResources_Name' 
    AND object_id = OBJECT_ID('[dbo].[IdentityResources]'))
	BEGIN
		CREATE UNIQUE INDEX [IX_IdentityResources_Name] ON [IdentityResources] ([Name]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_DeviceCodes_DeviceCode' 
    AND object_id = OBJECT_ID('[dbo].[DeviceCodes]'))
	BEGIN
		CREATE UNIQUE INDEX [IX_DeviceCodes_DeviceCode] ON [DeviceCodes] ([DeviceCode]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_DeviceCodes_UserCode' 
    AND object_id = OBJECT_ID('[dbo].[DeviceCodes]'))
	BEGIN
		CREATE UNIQUE INDEX [IX_DeviceCodes_UserCode] ON [DeviceCodes] ([UserCode]);
	END
GO

IF NOT EXISTS (SELECT *  FROM sys.indexes  WHERE name='IX_PersistedGrants_SubjectId_ClientId_Type' 
    AND object_id = OBJECT_ID('[dbo].[PersistedGrants]'))
	BEGIN
		CREATE INDEX [IX_PersistedGrants_SubjectId_ClientId_Type] ON [PersistedGrants] ([SubjectId], [ClientId], [Type]);
	END
GO

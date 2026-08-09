USE [PrecipitationDB]
GO

/****** Objet : Table [dbo].[Precipitation2025] Date de script : 2026-08-01 13:03:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Precipitation2025]') AND type in (N'U'))
DROP TABLE [dbo].[Precipitation2025]
GO

/****** Objet : Table [dbo].[Precipitation2025] Date de script : 2026-08-01 13:03:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Precipitation2025](
	[Preci2025ID] [int] IDENTITY(1,1) NOT NULL,
	[Provinces] [varchar](50) NULL,
	[PrecipitationMean] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[Preci2025ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



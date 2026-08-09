USE [PrecipitationDB]
GO

/****** Objet : Table [dbo].[Precipitation2024] Date de script : 2026-08-01 13:02:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Precipitation2024]') AND type in (N'U'))
DROP TABLE [dbo].[Precipitation2024]
GO

/****** Objet : Table [dbo].[Precipitation2024] Date de script : 2026-08-01 13:02:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Precipitation2024](
	[Preci2024ID] [int] IDENTITY(1,1) NOT NULL,
	[Provinces] [varchar](50) NULL,
	[PrecipitationMean] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[Preci2024ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



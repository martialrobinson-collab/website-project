USE [PollutionDB]
GO

/****** Objet : Table [dbo].[Pollution2025] Date de script : 2026-08-01 13:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pollution2025]') AND type in (N'U'))
DROP TABLE [dbo].[Pollution2025]
GO

/****** Objet : Table [dbo].[Pollution2025] Date de script : 2026-08-01 13:00:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pollution2025](
	[Pollu2025ID] [int] IDENTITY(1,1) NOT NULL,
	[Provinces] [varchar](50) NULL,
	[PollutionMean] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[Pollu2025ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



USE [PollutionDB]
GO

/****** Objet : Table [dbo].[Pollution2023] Date de script : 2026-08-01 12:58:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pollution2023]') AND type in (N'U'))
DROP TABLE [dbo].[Pollution2023]
GO

/****** Objet : Table [dbo].[Pollution2023] Date de script : 2026-08-01 12:58:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pollution2023](
	[Pollu2023ID] [int] IDENTITY(1,1) NOT NULL,
	[Provinces] [varchar](50) NULL,
	[PollutionMean] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[Pollu2023ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



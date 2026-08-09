USE [TemperatureBD]
GO

/****** Objet : Table [dbo].[Temperature2025] Date de script : 2026-08-01 13:04:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temperature2025]') AND type in (N'U'))
DROP TABLE [dbo].[Temperature2025]
GO

/****** Objet : Table [dbo].[Temperature2025] Date de script : 2026-08-01 13:04:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Temperature2025](
	[Temp2025ID] [int] IDENTITY(1,1) NOT NULL,
	[Provinces] [varchar](50) NULL,
	[TemperatureMean] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[Temp2025ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



DROP PROC IF EXISTS spPrecipitation2024;
GO
CREATE PROC spPrecipitation2024
AS

SELECT Provinces AS Provinces, PrecipitationMean AS Pollution  FROM Precipitation2024
DROP PROC IF EXISTS spPrecipitation2025;
GO
CREATE PROC spPrecipitation2025
AS

SELECT Provinces AS Provinces, PrecipitationMean AS Pollution  FROM Precipitation2025
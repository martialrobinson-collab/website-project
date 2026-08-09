DROP PROC IF EXISTS spPrecipitation2023;
GO
CREATE PROC spPrecipitation2023
AS

SELECT Provinces AS Provinces, PrecipitationMean AS Pollution  FROM Precipitation2023
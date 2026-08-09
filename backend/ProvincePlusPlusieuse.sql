USE PrecipitationDB;
DROP PROC IF EXISTS spProvincePlusPlusieuse;
GO
CREATE PROC spProvincePlusPlusieuse 
AS

SELECT TOP 1 ROUND(AVG(PrecipitationMean), 2) AS ProvincePlusPlusieuse, Provinces
FROM (
    SELECT PrecipitationMean, Provinces FROM Precipitation2023
    UNION ALL
    SELECT PrecipitationMean, Provinces FROM Precipitation2024
    UNION ALL
    SELECT PrecipitationMean, Provinces FROM Precipitation2025
) AS T
GROUP BY Provinces
ORDER BY ProvincePlusPlusieuse DESC;


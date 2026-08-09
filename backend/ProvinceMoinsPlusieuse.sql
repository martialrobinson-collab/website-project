USE PrecipitationDB;
DROP PROC IF EXISTS spProvinceMoinsPlusieuse;
GO
CREATE PROC spProvinceMoinsPlusieuse 
AS

SELECT TOP 1 ROUND(AVG(PrecipitationMean), 2) AS ProvinceMoinsPlusieuse, Provinces
FROM (
    SELECT PrecipitationMean, Provinces FROM Precipitation2023
    UNION ALL
    SELECT PrecipitationMean, Provinces FROM Precipitation2024
    UNION ALL
    SELECT PrecipitationMean, Provinces FROM Precipitation2025
) AS T
GROUP BY Provinces
ORDER BY ProvinceMoinsPlusieuse ASC;


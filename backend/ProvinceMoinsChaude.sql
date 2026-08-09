USE TemperatureBD;
DROP PROC IF EXISTS spProvinceMoinsChaude;
GO
CREATE PROC spProvinceMoinsChaude 
AS

SELECT TOP 1 ROUND(AVG(TemperatureMean), 2) AS ProvinceMoinsChaude, Provinces
FROM (
    SELECT TemperatureMean, Provinces FROM Temperature2023
    UNION ALL
    SELECT TemperatureMean, Provinces FROM Temperature2024
    UNION ALL
    SELECT TemperatureMean, Provinces FROM Temperature2025
) AS T
GROUP BY Provinces
ORDER BY ProvinceMoinsChaude ASC;


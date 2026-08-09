USE PrecipitationDB;
DROP PROC IF EXISTS spAnneePlusPluvieuse;
GO
CREATE PROC spAnneePlusPluvieuse 
AS

SELECT TOP 1 ROUND(PrecipitationMoy, 2) AS PlusPluvieuse, AnneePlusPluvieuse FROM (
SELECT AVG(PrecipitationMean) AS PrecipitationMoy, 'Annee 2023' as AnneePlusPluvieuse FROM Precipitation2023
UNION ALL
SELECT AVG(PrecipitationMean) AS PrecipitationMoy, 'Annee 2024' as AnneePlusPluvieuse FROM Precipitation2024
UNION ALL
SELECT AVG(PrecipitationMean) AS PrecipitationMoy, 'Annee 2025' as AnneePlusPluvieuse FROM Precipitation2025) AS T
ORDER BY PrecipitationMoy DESC;
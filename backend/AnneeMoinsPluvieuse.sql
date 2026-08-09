USE PrecipitationDB;
DROP PROC IF EXISTS spAnneeMoinsPluvieuse;
GO
CREATE PROC spAnneeMoinsPluvieuse 
AS

SELECT TOP 1 ROUND(PrecipitationMoy, 2) AS MoinsPluvieuse, AnneeMoinsPluvieuse FROM (
SELECT AVG(PrecipitationMean) AS PrecipitationMoy, 'Annee 2023' as AnneeMoinsPluvieuse FROM Precipitation2023
UNION ALL
SELECT AVG(PrecipitationMean) AS PrecipitationMoy, 'Annee 2024' as AnneeMoinsPluvieuse FROM Precipitation2024
UNION ALL
SELECT AVG(PrecipitationMean) AS PrecipitationMoy, 'Annee 2025' as AnneeMoinsPluvieuse FROM Precipitation2025) AS T
ORDER BY PrecipitationMoy ASC;
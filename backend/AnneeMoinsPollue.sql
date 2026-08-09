USE PollutionDB;
DROP PROC IF EXISTS spAnneeMoinsPollue;
GO
CREATE PROC spAnneeMoinsPollue 
AS

SELECT TOP 1 ROUND(PollutionMoy, 2) AS MoinsPollue, AnneeMoinsPollue FROM (
SELECT AVG(PollutionMean) AS PollutionMoy, 'Annee 2023' as AnneeMoinsPollue FROM Pollution2023
UNION ALL
SELECT AVG(PollutionMean) AS PollutionMoy, 'Annee 2024' as AnneeMoinsPollue FROM Pollution2024
UNION ALL
SELECT AVG(PollutionMean) AS PollutionMoy, 'Annee 2025' as AnneeMoinsPollue FROM Pollution2025) AS T
ORDER BY PollutionMoy ASC;
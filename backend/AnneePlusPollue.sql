USE PollutionDB;
DROP PROC IF EXISTS spAnneePlusPollue;
GO
CREATE PROC spAnneePlusPollue 
AS

SELECT TOP 1 ROUND(PollutionMoy, 2) AS PlusPollue, AnneePlusPollue FROM (
SELECT AVG(PollutionMean) AS PollutionMoy, 'Annee 2023' as AnneePlusPollue FROM Pollution2023
UNION ALL
SELECT AVG(PollutionMean) AS PollutionMoy, 'Annee 2024' as AnneePlusPollue FROM Pollution2024
UNION ALL
SELECT AVG(PollutionMean) AS PollutionMoy, 'Annee 2025' as AnneePlusPollue FROM Pollution2025) AS T
ORDER BY PollutionMoy DESC;
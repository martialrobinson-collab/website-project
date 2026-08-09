USE PollutionDB;
DROP PROC IF EXISTS spProvincePlusPollue;
GO
CREATE PROC spProvincePlusPollue 
AS

SELECT TOP 1 ROUND(AVG(PollutionMean), 2) AS ProvincePlusPollue, Provinces
FROM (
    SELECT PollutionMean, Provinces FROM Pollution2023
    UNION ALL
    SELECT PollutionMean, Provinces FROM Pollution2023
    UNION ALL
    SELECT PollutionMean, Provinces FROM Pollution2023) AS T
GROUP BY Provinces
ORDER BY ProvincePlusPollue DESC;


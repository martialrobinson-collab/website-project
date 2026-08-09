USE PollutionDB;
DROP PROC IF EXISTS spProvinceMoinsPollue;
GO
CREATE PROC spProvinceMoinsPollue 
AS

SELECT TOP 1 ROUND(AVG(PollutionMean), 2) AS ProvinceMoinsPollue, Provinces
FROM (
    SELECT PollutionMean, Provinces FROM Pollution2023
    UNION ALL
    SELECT PollutionMean, Provinces FROM Pollution2023
    UNION ALL
    SELECT PollutionMean, Provinces FROM Pollution2023
) AS T
GROUP BY Provinces
ORDER BY ProvinceMoinsPollue ASC;


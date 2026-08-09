DROP PROC IF EXISTS spPollution2023;
GO
CREATE PROC spPollution2023
AS

SELECT Provinces AS Provinces, PollutionMean AS Pollution  FROM Pollution2023
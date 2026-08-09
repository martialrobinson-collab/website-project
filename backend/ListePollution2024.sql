DROP PROC IF EXISTS spPollution2024;
GO
CREATE PROC spPollution2024
AS

SELECT Provinces AS Provinces, PollutionMean AS Pollution  FROM Pollution2024
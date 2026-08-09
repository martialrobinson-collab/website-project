DROP PROC IF EXISTS spPollution2025;
GO
CREATE PROC spPollution2025
AS

SELECT Provinces AS Provinces, PollutionMean AS Pollution  FROM Pollution2025
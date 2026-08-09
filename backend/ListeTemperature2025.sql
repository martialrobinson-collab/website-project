DROP PROC IF EXISTS spTemperature2025;
GO
CREATE PROC spTemperature2025
AS

SELECT Provinces AS Provinces, temperatureMean AS Temperature  FROM Temperature2025
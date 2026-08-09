DROP PROC IF EXISTS spTemperature2024;
GO
CREATE PROC spTemperature2024
AS

SELECT Provinces AS Provinces, temperatureMean AS Temperature  FROM Temperature2024
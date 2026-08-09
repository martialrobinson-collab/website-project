DROP PROC IF EXISTS spTemperature2023;
GO
CREATE PROC spTemperature2023
AS

SELECT Provinces AS Provinces, temperatureMean AS Temperature  FROM Temperature2023
USE TemperatureBD;
DROP PROC IF EXISTS spAnneeMoinsChaude;
GO
CREATE PROC spAnneeMoinsChaude 
AS

SELECT TOP 1 ROUND(TemperatureMoy, 2) AS TemperatureMoinsChaude, AnneeMoinsChaude FROM (
SELECT AVG(TemperatureMean) AS TemperatureMoy, 'Annee 2023' as AnneeMoinsChaude FROM Temperature2023
UNION ALL
SELECT AVG(TemperatureMean) AS TemperatureMoy, 'Annee 2024' as AnneeMoinsChaude FROM Temperature2024
UNION ALL
SELECT AVG(TemperatureMean) AS TemperatureMoy, 'Annee 2025' as AnneeMoinsChaude FROM Temperature2025) AS T
ORDER BY TemperatureMoy ASC;
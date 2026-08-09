USE TemperatureBD;
DROP PROC IF EXISTS spAnneePlusChaude;
GO
CREATE PROC spAnneePlusChaude 
AS

SELECT TOP 1 ROUND(TemperatureMoy, 2) AS TemperaturePlusChaude, AnneePlusChaude FROM (
SELECT AVG(TemperatureMean) AS TemperatureMoy, 'Annee 2023' as AnneePlusChaude FROM Temperature2023
UNION ALL
SELECT AVG(TemperatureMean) AS TemperatureMoy, 'Annee 2024' as AnneePlusChaude FROM Temperature2024
UNION ALL
SELECT AVG(TemperatureMean) AS TemperatureMoy, 'Annee 2025' as AnneePlusChaude FROM Temperature2025) AS T
ORDER BY TemperatureMoy DESC;
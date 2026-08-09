const express = require('express');
const path = require('path');
const sql = require('mssql');
require('dotenv').config();
 
const app = express();
 
// Middleware pour lire le JSON
app.use(express.json());
 
// Servir les fichiers statiques du frontend situés dans le dossier 'public'
app.use(express.static(path.join(__dirname, 'public')));
 
// Configuration de la base de données Azure SQL via les variables d'environnement
const dbConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER, // Ex: votre-serveur.database.windows.net
  database: process.env.DB_NAME,
  options: {
    encrypt: true,
    trustServerCertificate: false
  }
};
 
// Route exemple de test d'API
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', message: 'Le serveur backend fonctionne correctement.' });
});
 
// Route d'API exemple pour la base de données
app.get('/api/data', async (req, res) => {
  try {
    let pool = await sql.connect(dbConfig);
    let result = await pool.request().query('SELECT TOP 10 * FROM VotreTable');
    res.json(result.recordset);
  } catch (err) {
    console.error('Erreur SQL:', err);
    res.status(500).json({ error: 'Erreur lors de la récupération des données' });
  }
});
 
// Rediriger toutes les requêtes non-API vers le fichier index.html du frontend
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});
 
// Utilisation du port fourni par Render ou 3000 par défaut en local
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Serveur démarré sur le port ${PORT}`);
});
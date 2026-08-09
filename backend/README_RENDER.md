# ClimateVision — déploiement complet sur Render

Ce dossier est prêt pour un seul **Render Web Service** :
- `public/` : frontend
- `server.js` : Node.js/Express + API
- `sql/` : scripts SQL
- `package.json` : dépendances

## Render
Créez un **Web Service** à partir du dépôt GitHub contenant ce dossier.

- Build Command : `npm install`
- Start Command : `npm start`

## Variables d'environnement à ajouter dans Render
- `DB_USER`
- `DB_PASSWORD`
- `DB_SERVER`
- `DB_TEMPERATURE`
- `DB_POLLUTION`
- `DB_PRECIPITATION`

Exemple des valeurs non sensibles :
- `DB_SERVER=coursinf4163.database.windows.net`
- `DB_TEMPERATURE=TemperatureDB`
- `DB_POLLUTION=PollutionDB`
- `DB_PRECIPITATION=PrecipitationDB`

Ne mettez jamais le mot de passe dans GitHub.

## Tests après déploiement
- `/health` doit retourner `ok: true`
- `/api/resultats` doit retourner les résultats des procédures stockées
- `/` doit afficher le site

Le frontend utilise maintenant `fetch("/api/resultats")`, donc il appelle automatiquement le backend du même service Render.

## Azure SQL
Si `/health` fonctionne mais `/api/resultats` échoue, vérifiez le pare-feu Azure SQL et les variables d'environnement Render.

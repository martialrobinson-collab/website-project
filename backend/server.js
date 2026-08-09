const express = require("express");
const sql = require("mssql");
const path = require("path");

const app = express();
app.use(express.json());

// Frontend HTML/CSS/JS/images served by the same Render Web Service.
app.use(express.static(path.join(__dirname, "public")));

const baseConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER || "coursinf4163.database.windows.net",
    options: {
        encrypt: true,
        trustServerCertificate: false
    },
    connectionTimeout: 30000,
    requestTimeout: 30000
};

const configs = {
    temperature: {
        ...baseConfig,
        database: process.env.DB_TEMPERATURE || "TemperatureDB"
    },
    pollution: {
        ...baseConfig,
        database: process.env.DB_POLLUTION || "PollutionDB"
    },
    precipitation: {
        ...baseConfig,
        database: process.env.DB_PRECIPITATION || "PrecipitationDB"
    }
};

const pools = {};

async function getPool(name) {
    if (!process.env.DB_USER) {
        throw new Error("DB_USER n'est pas configuré sur Render.");
    }
    if (!process.env.DB_PASSWORD) {
        throw new Error("DB_PASSWORD n'est pas configuré sur Render.");
    }

    if (!pools[name]) {
        pools[name] = await new sql.ConnectionPool(configs[name]).connect();
        pools[name].on("error", (err) => {
            console.error(`Erreur du pool ${name}:`, err.message);
            pools[name] = null;
        });
    }

    return pools[name];
}

async function runSp(databaseName, spName) {
    try {
        const pool = await getPool(databaseName);
        const result = await pool.request().execute(spName);
        const row = result.recordset?.[0] || null;
        const values = row ? Object.values(row) : [];

        return {
            sp: spName,
            ok: true,
            col1: values[0] ?? null,
            col2: values[1] ?? null
        };
    } catch (err) {
        console.error(`Erreur sur ${spName}:`, err.message);
        return {
            sp: spName,
            ok: false,
            error: err.message
        };
    }
}

app.get("/health", (req, res) => {
    res.json({
        ok: true,
        service: "ClimateVision",
        frontend: true,
        api: true
    });
});

app.get("/api/resultats", async (req, res) => {
    try {
        const results = await Promise.all([
            runSp("temperature", "spAnneeMoinsChaude"),
            runSp("temperature", "spAnneePlusChaude"),
            runSp("temperature", "spProvinceMoinsChaude"),
            runSp("temperature", "spProvincePlusChaude"),

            runSp("pollution", "spAnneeMoinsPollue"),
            runSp("pollution", "spAnneePlusPollue"),
            runSp("pollution", "spProvinceMoinsPollue"),
            runSp("pollution", "spProvincePlusPollue"),

            runSp("precipitation", "spAnneeMoinsPluvieuse"),
            runSp("precipitation", "spAnneePlusPluvieuse"),
            runSp("precipitation", "spProvinceMoinsPlusieuse"),
            runSp("precipitation", "spProvincePlusPlusieuse")
        ]);

        const [
            spAnneeMoinsChaude,
            spAnneePlusChaude,
            spProvinceMoinsChaude,
            spProvincePlusChaude,
            spAnneeMoinsPollue,
            spAnneePlusPollue,
            spProvinceMoinsPollue,
            spProvincePlusPollue,
            spAnneeMoinsPluvieuse,
            spAnneePlusPluvieuse,
            spProvinceMoinsPlusieuse,
            spProvincePlusPlusieuse
        ] = results;

        res.json({
            temperature: {
                spAnneeMoinsChaude,
                spAnneePlusChaude,
                spProvinceMoinsChaude,
                spProvincePlusChaude
            },
            pollution: {
                spAnneeMoinsPollue,
                spAnneePlusPollue,
                spProvinceMoinsPollue,
                spProvincePlusPollue
            },
            precipitation: {
                spAnneeMoinsPluvieuse,
                spAnneePlusPluvieuse,
                spProvinceMoinsPlusieuse,
                spProvincePlusPlusieuse
            }
        });
    } catch (err) {
        console.error("Erreur générale:", err);
        res.status(500).json({
            erreur: "Impossible de se connecter à Azure SQL.",
            detail: err.message
        });
    }
});

// Homepage served explicitly; static middleware handles CSS, images, etc.
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "public", "index.html"));
});

const PORT = process.env.PORT || 10000;
app.listen(PORT, "0.0.0.0", () => {
    console.log(`ClimateVision démarré sur le port ${PORT}`);
});

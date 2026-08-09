const express = require("express");
const sql = require("mssql");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

const baseConfig = {
    user: process.env.DB_USER || "notregroupe",
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER || "coursinf4163.database.windows.net",
    options: {
        encrypt: true,
        trustServerCertificate: false
    },
    connectionTimeout: 30000,
    requestTimeout: 30000
};

const configTemperature = { ...baseConfig, database: process.env.DB_TEMPERATURE || "TemperatureDB" };
const configPollution = { ...baseConfig, database: process.env.DB_POLLUTION || "PollutionDB" };
const configPrecipitation = { ...baseConfig, database: process.env.DB_PRECIPITATION || "PrecipitationDB" };

let poolTemperature;
let poolPollution;
let poolPrecipitation;

async function getPools() {
    if (!process.env.DB_PASSWORD) {
        throw new Error("DB_PASSWORD n'est pas configuré.");
    }

    if (!poolTemperature) {
        poolTemperature = await new sql.ConnectionPool(configTemperature).connect();
    }
    if (!poolPollution) {
        poolPollution = await new sql.ConnectionPool(configPollution).connect();
    }
    if (!poolPrecipitation) {
        poolPrecipitation = await new sql.ConnectionPool(configPrecipitation).connect();
    }

    return { poolTemperature, poolPollution, poolPrecipitation };
}

async function runSp(pool, spName) {
    try {
        const result = await pool.request().execute(spName);
        const row = result.recordset?.[0];
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
    res.json({ ok: true, service: "ClimateVision API" });
});

app.get("/api/resultats", async (req, res) => {
    try {
        const { poolTemperature, poolPollution, poolPrecipitation } = await getPools();

        const results = await Promise.all([
            runSp(poolTemperature, "spAnneeMoinsChaude"),
            runSp(poolTemperature, "spAnneePlusChaude"),
            runSp(poolTemperature, "spProvinceMoinsChaude"),
            runSp(poolTemperature, "spProvincePlusChaude"),

            runSp(poolPollution, "spAnneeMoinsPollue"),
            runSp(poolPollution, "spAnneePlusPollue"),
            runSp(poolPollution, "spProvinceMoinsPollue"),
            runSp(poolPollution, "spProvincePlusPollue"),

            runSp(poolPrecipitation, "spAnneeMoinsPluvieuse"),
            runSp(poolPrecipitation, "spAnneePlusPluvieuse"),
            runSp(poolPrecipitation, "spProvinceMoinsPlusieuse"),
            runSp(poolPrecipitation, "spProvincePlusPlusieuse")
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

const PORT = process.env.PORT || 10000;
app.listen(PORT, "0.0.0.0", () => {
    console.log(`ClimateVision API démarrée sur le port ${PORT}`);
});

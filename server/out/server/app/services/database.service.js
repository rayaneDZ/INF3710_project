"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DatabaseService = void 0;
const inversify_1 = require("inversify");
const pg = require("pg");
require("reflect-metadata");
let DatabaseService = class DatabaseService {
    constructor() {
        this.connectionConfig = {
            user: "postgres",
            database: "TP4",
            password: "rayane02",
            port: 5432,
            host: "127.0.0.1",
            keepAlive: true
        };
        this.pool = new pg.Pool(this.connectionConfig);
    }
    //Affiche tous les champs et toutes les entrees de la table Planrepas.
    getAllPlanrepas() {
        return __awaiter(this, void 0, void 0, function* () {
            const client = yield this.pool.connect();
            const res = yield client.query("SELECT * FROM Planrepas;");
            client.release();
            return res;
        });
    }
    //retourne le nombre de plans de repas
    getNumberofPlans() {
        return __awaiter(this, void 0, void 0, function* () {
            const client = yield this.pool.connect();
            const res = yield client.query("SELECT COUNT(*) FROM Planrepas;");
            client.release();
            return res;
        });
    }
    //Affiche tous les champs et toutes les entrees de la table Planrepas.
    getAllFournisseur() {
        return __awaiter(this, void 0, void 0, function* () {
            const client = yield this.pool.connect();
            const res = yield client.query("SELECT * FROM fournisseur;");
            client.release();
            return res;
        });
    }
    //Ajouter un plan repas
    createPlan(planrepas) {
        return __awaiter(this, void 0, void 0, function* () {
            const client = yield this.pool.connect();
            if (!planrepas.categorie || !planrepas.frequence || !planrepas.nbrpersonnes || !planrepas.nbrcalories || !planrepas.prix || !planrepas.numerofournisseur)
                throw new Error("plan repas values missing");
            const values = [planrepas.categorie, planrepas.frequence, planrepas.nbrpersonnes, planrepas.nbrcalories, planrepas.prix, planrepas.numerofournisseur];
            const queryText = `INSERT INTO Planrepas VALUES(DEFAULT, $1, $2, $3, $4, $5, $6);`;
            const res = yield client.query(queryText, values);
            client.release();
            return res;
        });
    }
    deletePlan(numeroplan) {
        return __awaiter(this, void 0, void 0, function* () {
            const client = yield this.pool.connect();
            const query = `DELETE FROM Planrepas WHERE numeroplan = '${numeroplan}';`;
            const res = yield client.query(query);
            client.release();
            return res;
        });
    }
    updatePlan(newplan) {
        return __awaiter(this, void 0, void 0, function* () {
            const client = yield this.pool.connect();
            let toUpdateValues = [];
            toUpdateValues.push(`categorie = '${newplan.categorie}'`);
            toUpdateValues.push(`frequence = ${newplan.frequence}`);
            toUpdateValues.push(`nbrpersonnes = ${newplan.nbrpersonnes}`);
            toUpdateValues.push(`nbrcalories = ${newplan.nbrcalories}`);
            toUpdateValues.push(`prix = ${newplan.prix}`);
            toUpdateValues.push(`numerofournisseur = ${newplan.numerofournisseur}`);
            const query = `UPDATE Planrepas SET ${toUpdateValues.join(", ")} WHERE numeroplan = ${newplan.numeroplan};`;
            console.log("QUERY = ", query);
            const res = yield client.query(query);
            client.release();
            return res;
        });
    }
};
DatabaseService = __decorate([
    (0, inversify_1.injectable)()
], DatabaseService);
exports.DatabaseService = DatabaseService;
//# sourceMappingURL=database.service.js.map
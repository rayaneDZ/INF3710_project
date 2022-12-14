"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DatabaseController = void 0;
const express_1 = require("express");
const inversify_1 = require("inversify");
const database_service_1 = require("../services/database.service");
const types_1 = require("../types");
let DatabaseController = class DatabaseController {
    constructor(
    // @ts-ignore -- À ENLEVER LORSQUE L'IMPLeMENTATION EST TERMINeE
    databaseService) {
        this.databaseService = databaseService;
    }
    get router() {
        const router = (0, express_1.Router)();
        // GET ALL PLAN REPAS
        router.get("/planrepas", (req, res, _) => {
            this.databaseService
                .getAllPlanrepas()
                .then((result) => {
                const plansrepas = result.rows.map((plan) => ({
                    numeroplan: plan.numeroplan,
                    categorie: plan.categorie,
                    frequence: plan.frequence,
                    nbrpersonnes: plan.nbrpersonnes,
                    nbrcalories: plan.nbrcalories,
                    prix: plan.prix,
                    numerofournisseur: plan.numerofournisseur
                }));
                res.json(plansrepas);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        router.get("/nombredeplans", (req, res, _) => {
            this.databaseService.getNumberofPlans().then((result) => {
                res.json(result.rows[0].count);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        // GET ALL FOURNISSEURS
        router.get("/fournisseurs", (req, res, _) => {
            this.databaseService
                .getAllFournisseur()
                .then((result) => {
                const fournisseurs = result.rows.map((fournisseur) => ({
                    numerofournisseur: fournisseur.numerofournisseur,
                    nomfournisseur: fournisseur.nomfournisseur,
                    adressefournisseur: fournisseur.adressefournisseur
                }));
                res.json(fournisseurs);
            }).catch((e) => {
                console.error(e.stack);
            });
        });
        // CREATE A PLAN REPAS
        router.post("/planrepas/insert", (req, res, _) => {
            const plan = {
                numeroplan: 0,
                categorie: req.body.categorie,
                frequence: req.body.frequence,
                nbrpersonnes: req.body.nbrpersonnes,
                nbrcalories: req.body.nbrcalories,
                prix: req.body.prix,
                numerofournisseur: req.body.numerofournisseur,
            };
            this.databaseService.createPlan(plan).then((result) => {
                res.json(result.rowCount);
            }).catch((e) => {
                console.error(e.stack);
                res.json(-1);
            });
        });
        router.post("/planrepas/supprimer/:numeroplan", (req, res, _) => {
            const numeroplan = parseInt(req.params.numeroplan);
            this.databaseService
                .deletePlan(numeroplan)
                .then((result) => {
                res.json(result.rowCount);
            })
                .catch((e) => {
                console.error(e.stack);
            });
        });
        router.put("/planrepas/modifier", (req, res, _) => {
            const plan = {
                numeroplan: req.body.numeroplan,
                categorie: req.body.categorie,
                frequence: req.body.frequence,
                nbrpersonnes: req.body.nbrpersonnes,
                nbrcalories: req.body.nbrcalories,
                prix: req.body.prix,
                numerofournisseur: req.body.numerofournisseur,
            };
            console.log("server side plan = ", plan);
            this.databaseService
                .updatePlan(plan)
                .then((result) => {
                res.json(result.rowCount);
            })
                .catch((e) => {
                console.error(e.stack);
                res.json(-1);
            });
        });
        return router;
    }
};
DatabaseController = __decorate([
    (0, inversify_1.injectable)(),
    __param(0, (0, inversify_1.inject)(types_1.default.DatabaseService)),
    __metadata("design:paramtypes", [database_service_1.DatabaseService])
], DatabaseController);
exports.DatabaseController = DatabaseController;
//# sourceMappingURL=database.controller.js.map
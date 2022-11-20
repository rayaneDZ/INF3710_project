import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import * as pg from "pg";

import { Planrepas } from "../../../common/tables/Planrepas";
import { Fournisseur } from "../../../common/tables/Fournisseur";

import { DatabaseService } from "../services/database.service";
import Types from "../types";

@injectable()
export class DatabaseController {
  public constructor(
    // @ts-ignore -- À ENLEVER LORSQUE L'IMPLÉMENTATION EST TERMINÉE
    @inject(Types.DatabaseService) private readonly databaseService: DatabaseService
  ) {}

  public get router(): Router {
    const router: Router = Router();

    // GET ALL PLAN REPAS
    router.get(
      "/planrepas",
      (req: Request, res: Response, _: NextFunction) => {
        this.databaseService
          .getAllPlanrepas()
          .then((result: pg.QueryResult) => {
            const plansrepas: Planrepas[] = result.rows.map((plan: Planrepas) => ({
              numéroplan: plan.numéroplan,
              catégorie: plan.catégorie,
              fréquence: plan.fréquence,
              nbrpersonnes: plan.nbrpersonnes,
              nbrcalories: plan.nbrcalories,
              prix: plan.prix,
              numérofournisseur: plan.numérofournisseur
            }));
            
            //GET ALL FOURNISSEURS
            let fournisseurs: Fournisseur[]
            this.databaseService.getAllFournisseur()
            .then((result: pg.QueryResult) => {
              fournisseurs = result.rows.map((fournisseur: Fournisseur) => ({
                numérofournisseur: fournisseur.numérofournisseur,
                nomfournisseur: fournisseur.nomfournisseur,
                adressefournisseur: fournisseur.adressefournisseur
              }));
              res.json([plansrepas, fournisseurs]);
            }).catch((e: Error) => {
              console.error(e.stack);
            });
          })
          .catch((e: Error) => {
            console.error(e.stack);
          });
      }
    );

    // CREATE A PLAN REPAS
    router.post(
      "/planrepas",
      (req: Request, res: Response, _: NextFunction) => {
        const plan: Planrepas = {
          numéroplan: 0,
          catégorie: req.body.catégorie,
          fréquence: req.body.fréquence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbrcalories: req.body.nbrcalories,
          prix: req.body.prix,
          numérofournisseur: req.body.numérofournisseur,
        };

        this.databaseService.createPlan(plan).then((result: pg.QueryResult) => {
          res.json(result.rowCount);
        }).catch((e: Error) => {
          console.error(e.stack);
          res.json(-1);
        });
      }
    );

    return router;
  }
}

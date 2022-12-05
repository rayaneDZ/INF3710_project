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
    // @ts-ignore -- À ENLEVER LORSQUE L'IMPLeMENTATION EST TERMINeE
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
              numeroplan: plan.numeroplan,
              categorie: plan.categorie,
              frequence: plan.frequence,
              nbrpersonnes: plan.nbrpersonnes,
              nbrcalories: plan.nbrcalories,
              prix: plan.prix,
              numerofournisseur: plan.numerofournisseur
            }));
            res.json(plansrepas);
          }).catch((e: Error) => {
            console.error(e.stack);
          });
      }
    );

    router.get(
      "/nombredeplans",
      (req: Request, res: Response, _: NextFunction) => {
        this.databaseService.getNumberofPlans().then((result: pg.QueryResult) => {
          res.json(result.rows[0].count);
        }).catch((e: Error) => {
          console.error(e.stack);
        });
      }
    )
    // GET ALL FOURNISSEURS
    router.get(
      "/fournisseurs",
      (req: Request, res: Response, _: NextFunction) => {
        this.databaseService
        .getAllFournisseur()
        .then((result: pg.QueryResult) => {
          const fournisseurs: Fournisseur[] = result.rows.map((fournisseur: Fournisseur) => ({
            numerofournisseur: fournisseur.numerofournisseur,
            nomfournisseur: fournisseur.nomfournisseur,
            adressefournisseur: fournisseur.adressefournisseur
          }));

          res.json(fournisseurs);

          }).catch((e: Error) => {
            console.error(e.stack);
          });
      }
    );
    // CREATE A PLAN REPAS
    router.post(
      "/planrepas/insert",
      (req: Request, res: Response, _: NextFunction) => {
        const plan: Planrepas = {
          numeroplan: 0,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbrcalories: req.body.nbrcalories,
          prix: req.body.prix,
          numerofournisseur: req.body.numerofournisseur,
        };

        this.databaseService.createPlan(plan).then((result: pg.QueryResult) => {
          res.json(result.rowCount);
        }).catch((e: Error) => {
          console.error(e.stack);
          res.json(-1);
        });
      }
    );

    router.post(
      "/planrepas/supprimer/:numeroplan",
      (req: Request, res: Response, _: NextFunction) => {
        const numeroplan: number = parseInt(req.params.numeroplan);
        this.databaseService
          .deletePlan(numeroplan)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
          });
      }
    );

    router.put(
      "/planrepas/modifier",
      (req: Request, res: Response, _: NextFunction) => {
        const plan: Planrepas = {
          numeroplan: req.body.numeroplan,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbrcalories: req.body.nbrcalories,
          prix: req.body.prix,
          numerofournisseur: req.body.numerofournisseur,
        };
        console.log("server side plan = ", plan)
        this.databaseService
          .updatePlan(plan)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    return router;
  }
}

import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import * as pg from "pg";

import { Planrepas } from "../../../common/tables/Planrepas";

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
            res.json(plansrepas);
          })
          .catch((e: Error) => {
            console.error(e.stack);
          });
      }
    );

    return router;
  }
}

import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";
import { Planrepas } from "../../../common/tables/Planrepas";

@injectable()
export class DatabaseService {
  public connectionConfig: pg.ConnectionConfig = {
    user: "postgres",
    database: "TP4",
    password: "rayane02",
    port: 5432,          // Attention ! Peut aussi être 5433 pour certains utilisateurs
    host: "127.0.0.1",
    keepAlive: true
  };

  public pool: pg.Pool = new pg.Pool(this.connectionConfig);

  //Affiche tous les champs et toutes les entrées de la table Planrepas.
  public async getAllPlanrepas(): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const res = await client.query("SELECT * FROM Planrepas;");
    client.release();
    return res;
  }

  //Ajouter un plan repas
  public async createPlan(planrepas: Planrepas): Promise<pg.QueryResult> {
    const client = await this.pool.connect();

    if (!planrepas.catégorie || !planrepas.fréquence || !planrepas.nbrpersonnes || !planrepas.nbrcalories || !planrepas.prix || !planrepas.numérofournisseur)
      throw new Error("plan repas values missing");

    const values = [planrepas.catégorie, planrepas.fréquence, planrepas.nbrpersonnes, planrepas.nbrcalories, planrepas.prix, planrepas.numérofournisseur];
    const queryText: string = `INSERT INTO Planrepas VALUES(DEFAULT, $1, $2, $3, $4, $5, $6);`;

    const res = await client.query(queryText, values);
    client.release();
    return res;
  }
}

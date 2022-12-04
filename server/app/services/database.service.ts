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

  //Affiche tous les champs et toutes les entrees de la table Planrepas.
  public async getAllPlanrepas(): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const res = await client.query("SELECT * FROM Planrepas;");
    client.release();
    return res;
  }

  //retourne le nombre de plans de repas
  public async getNumberofPlans(): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const res = await client.query("SELECT COUNT(*) FROM Planrepas;");
    client.release();
    return res;
  }

  //Affiche tous les champs et toutes les entrees de la table Planrepas.
  public async getAllFournisseur(): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const res = await client.query("SELECT * FROM fournisseur;");
    client.release();
    return res;
  }

  //Ajouter un plan repas
  public async createPlan(planrepas: Planrepas): Promise<pg.QueryResult> {
    const client = await this.pool.connect();

    if (!planrepas.categorie || !planrepas.frequence || !planrepas.nbrpersonnes || !planrepas.nbrcalories || !planrepas.prix || !planrepas.numerofournisseur)
      throw new Error("plan repas values missing");

    const values = [planrepas.categorie, planrepas.frequence, planrepas.nbrpersonnes, planrepas.nbrcalories, planrepas.prix, planrepas.numerofournisseur];
    const queryText: string = `INSERT INTO Planrepas VALUES(DEFAULT, $1, $2, $3, $4, $5, $6);`;

    const res = await client.query(queryText, values);
    client.release();
    return res;
  }
}

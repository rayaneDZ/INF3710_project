import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";
//import { Planrepas } from "../../../common/tables/Planrepas";

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
}

// À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { of, Observable, Subject } from "rxjs";
import { Planrepas } from "../../../../common/tables/Planrepas";
import { Fournisseur } from "../../../../common/tables/Fournisseur";
import { catchError } from "rxjs/operators";

@Injectable()
export class CommunicationService {
  // À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
  private readonly BASE_URL: string = "http://localhost:3000/database";
  public constructor(private readonly http: HttpClient) {}

  private _listeners: any = new Subject<any>();

  listen(): Observable<any> {
    return this._listeners.asObservable();
  }

  filter(filterBy: string): void {
    this._listeners.next(filterBy);
  }

  public getPlans(): Observable<Planrepas[]> {
    return this.http
      .get<Planrepas[]>(this.BASE_URL + "/planrepas")
      .pipe(catchError(this.handleError<Planrepas[]>("getPlans")));
  }
  public getNombreDePlans(): Observable<any> {
    return this.http
      .get<any>(this.BASE_URL + "/nombredeplans")
      .pipe(catchError(this.handleError<any>("getNombreDePlans")));
  }
  public getFournisseurs(): Observable<Fournisseur[]> {
    return this.http
      .get<Fournisseur[]>(this.BASE_URL + "/fournisseurs")
      .pipe(catchError(this.handleError<Fournisseur[]>("getFournisseurs")));
  }
  public insertPlanrepas(plan: Planrepas): Observable<number> {
    return this.http
      .post<number>(this.BASE_URL + "/planrepas/insert", plan)
      .pipe(catchError(this.handleError<number>("insertPlanrepas")));
  }
  public deletePlan(numeroplan: string): Observable<number> {
    return this.http
      .post<number>(this.BASE_URL + "/planrepas/supprimer/" + numeroplan, {})
      .pipe(catchError(this.handleError<number>("deletePlan")));
  }

  public updatePlan(plan: Planrepas): Observable<number> {
    return this.http
      .put<number>(this.BASE_URL + "/planrepas/modifier", plan)
      .pipe(catchError(this.handleError<number>("updatePlan")));
  }
  // À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
  private handleError<T>(
    request: string,
    result?: T
  ): (error: Error) => Observable<T> {
    return (error: Error): Observable<T> => {
      return of(result as T);
    };
  }
}

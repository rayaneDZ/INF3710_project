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

  public getPlans(): Observable<[Planrepas[], Fournisseur[]]> {
    return this.http
      .get<[Planrepas[], Fournisseur[]]>(this.BASE_URL + "/planrepas")
      .pipe(catchError(this.handleError<[Planrepas[], Fournisseur[]]>("getPlans")));
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

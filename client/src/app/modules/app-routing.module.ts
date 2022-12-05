import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

import { AppComponent } from "../app.component";
import { TousLesPlansComponent } from '../tous-les-plans/tous-les-plans.component';
import { AjouterPlansComponent } from '../ajouter-plans/ajouter-plans.component';
import { SupprimerPlansComponent } from '../supprimer-plans/supprimer-plans.component';
import { ModifierPlansComponent } from '../modifier-plans/modifier-plans.component';

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: "tous", component: TousLesPlansComponent },
  { path: "ajouter", component: AjouterPlansComponent },
  { path: "supprimer", component: SupprimerPlansComponent },
  { path: "modifier", component: ModifierPlansComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }

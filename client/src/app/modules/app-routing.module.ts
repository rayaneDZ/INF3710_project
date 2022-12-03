import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

import { AppComponent } from "../app.component";
import { TousLesPlansComponent } from '../tous-les-plans/tous-les-plans.component';

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: "tous", component: TousLesPlansComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }

import { CommonModule } from "@angular/common";
import { HttpClientModule } from "@angular/common/http";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from "@angular/platform-browser";
import { AppRoutingModule } from "./modules/app-routing.module";
import { AppComponent } from "./app.component";
import { CommunicationService } from "./services/communication.service";
import { AppMaterialModule } from './modules/material.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { TousLesPlansComponent } from './tous-les-plans/tous-les-plans.component';
import { AjouterPlansComponent } from './ajouter-plans/ajouter-plans.component';
import { SupprimerPlansComponent } from './supprimer-plans/supprimer-plans.component';
import { ModifierPlansComponent } from './modifier-plans/modifier-plans.component';

@NgModule({
  declarations: [
    AppComponent,
    TousLesPlansComponent,
    AjouterPlansComponent,
    SupprimerPlansComponent,
    ModifierPlansComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    HttpClientModule,
    FormsModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    ReactiveFormsModule,
    AppMaterialModule
  ],
  providers: [CommunicationService],
  entryComponents: [],
  bootstrap: [AppComponent],
})
export class AppModule { }

import { Component, OnInit, ElementRef, ViewChild } from '@angular/core';
import { CommunicationService } from "../services/communication.service";
import { Fournisseur } from "../../../../common/tables/Fournisseur";
import { Planrepas } from "../../../../common/tables/Planrepas";
import { Router } from "@angular/router";

@Component({
  selector: 'app-ajouter-plans',
  templateUrl: './ajouter-plans.component.html',
  styleUrls: ['./ajouter-plans.component.css']
})
export class AjouterPlansComponent implements OnInit {

  @ViewChild("newPlanCat") newPlanCat: ElementRef;
  @ViewChild("newPlanFreq") newPlanFreq: ElementRef;
  @ViewChild("newPlanNbPersonnes") newPlanNbPersonnes: ElementRef;
  @ViewChild("newPlanNbCalories") newPlanNbCalories: ElementRef;
  @ViewChild("newPlanPrix") newPlanPrix: ElementRef;

  public nombredeplans: any;
  public numeronewplan: number;
  public fournisseurs: Fournisseur[] =  [];
  selectedFournisseur: string;
  constructor(private communicationService: CommunicationService, router: Router) { }

  ngOnInit(): void {
    this.getNombreDePlans();
    this.getFournisseurs();
  }

  public getNombreDePlans(): void{
    this.communicationService.getNombreDePlans().subscribe((nombre: any) => {
      this.nombredeplans = nombre;
      this.numeronewplan = parseInt(this.nombredeplans) + 1;
    });
  }
  public getFournisseurs(): void{
    this.communicationService.getFournisseurs().subscribe((fournisseur: Fournisseur[]) => {
      this.fournisseurs = fournisseur;
    });
  }
  public ajouterPlan(): void{
    const newplan: Planrepas = {
      numeroplan: this.numeronewplan,
      categorie: this.newPlanCat.nativeElement.value,
      frequence: this.newPlanFreq.nativeElement.value,
      nbrpersonnes: this.newPlanNbPersonnes.nativeElement.value,
      nbrcalories: this.newPlanNbCalories.nativeElement.innerText,
      prix: parseInt(this.newPlanPrix.nativeElement.innerText),
      numerofournisseur: parseInt(this.selectedFournisseur)
    }
    this.communicationService.insertPlanrepas(newplan).subscribe((res: number) => {
      console.log("res = ", res);
    });
  }

  public checkNewPlan(): void{
    try{
      parseInt(this.newPlanPrix.nativeElement.innerText);
    }catch(e){
      console.log("please enter a valid price");
    }
    if(parseInt(this.newPlanPrix.nativeElement.innerText) < 0 || parseInt(this.newPlanPrix.nativeElement.innerText) > 9999.99){
      console.log("enter a price >= 0 and <= 9,999.99");
    }else{
      if(this.selectedFournisseur != undefined){
        this.ajouterPlan();
      }else{
        console.log("please select a fournisseur")
      }
    }
  }
}

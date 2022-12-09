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

  public plans: Planrepas[] = [];
  public numeronewplan: number;
  public fournisseurs: Fournisseur[] =  [];
  selectedFournisseur: string;
  public feedback: string;
  constructor(private communicationService: CommunicationService, private router: Router) { }

  ngOnInit(): void {
    this.getNombreDePlans();
    this.getFournisseurs();
  }

  public getPlans(nombre: number): void{
    this.communicationService.getPlans().subscribe((plans: Planrepas[]) => {
      this.plans = plans;
      let highest = 0;
      for(let i = 0; i< nombre; i++){
        if (plans[i].numeroplan > highest){
          highest = plans[i].numeroplan
        }
      }
      this.numeronewplan = highest + 1;
    });
  }

  public getNombreDePlans(): void{
    this.communicationService.getNombreDePlans().subscribe((nombre: any) => {
      this.getPlans(nombre);
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
      nbrcalories: parseInt(this.newPlanNbCalories.nativeElement.innerText),
      prix: parseInt(this.newPlanPrix.nativeElement.innerText),
      numerofournisseur: parseInt(this.selectedFournisseur)
    }
    console.log(newplan)
    this.communicationService.insertPlanrepas(newplan).subscribe((res: number) => {
      console.log("res = ", res);
    });
  }

  public checkNewPlan(): void{

    if(this.newPlanPrix.nativeElement.innerText == "" || parseInt(this.newPlanPrix.nativeElement.innerText) === NaN){
      this.feedback = "please enter a valid price"
    }else if(this.newPlanNbCalories.nativeElement.innerText == "" || parseInt(this.newPlanNbCalories.nativeElement.innerText) === NaN){
      this.feedback = "please enter a valid calories number"
    }else{
      if(parseInt(this.newPlanPrix.nativeElement.innerText) < 0 || parseInt(this.newPlanPrix.nativeElement.innerText) > 9999.99){
        this.feedback = "enter a price >= 0 and <= 9,999.99"
      }else{
        if(this.selectedFournisseur != undefined){
          this.ajouterPlan();
          this.router.navigate(["/tous"])
        }else{
          this.feedback = "please select a fournisseur"
        }
      }
    }
  }
}

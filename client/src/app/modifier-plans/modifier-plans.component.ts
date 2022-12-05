import { Component, OnInit, ElementRef, ViewChild } from '@angular/core';
import { CommunicationService } from "../services/communication.service";
import { Planrepas } from "../../../../common/tables/Planrepas";
import { Fournisseur } from "../../../../common/tables/Fournisseur";

@Component({
  selector: 'app-modifier-plans',
  templateUrl: './modifier-plans.component.html',
  styleUrls: ['./modifier-plans.component.css']
})
export class ModifierPlansComponent implements OnInit {

  @ViewChild("newPlanCat") newPlanCat: ElementRef;
  @ViewChild("newPlanFreq") newPlanFreq: ElementRef;
  @ViewChild("newPlanNbPersonnes") newPlanNbPersonnes: ElementRef;
  @ViewChild("newPlanNbCalories") newPlanNbCalories: ElementRef;
  @ViewChild("newPlanPrix") newPlanPrix: ElementRef;

  public plans: Planrepas[] = [];
  public fournisseurs: Fournisseur[] = [];
  numerodesplans: number[] = [];
  public selectedPlan: Planrepas;
  selectedFournisseur: string;

  constructor(private communicationService: CommunicationService) { }

  ngOnInit(): void {
    this.getPlans();
    this.getFournisseurs();
  }

  public getPlans(): void{
    this.communicationService.getPlans().subscribe((plans: Planrepas[]) => {
      this.plans = plans;
      //this.nombreDePlans = this.plans.length();
      this.plans.forEach((plan: Planrepas) => {
        this.numerodesplans.push(plan.numeroplan)
      });
      this.selectedPlan = plans[0]
      console.log("first selected plan = ", this.selectedPlan.numeroplan)
    });
  }

  public getFournisseurs(): void{
    this.communicationService.getFournisseurs().subscribe((fournisseur: Fournisseur[]) => {
      this.fournisseurs = fournisseur;
    });
  }

  public onChange(numeroplan: string): void{
    this.plans.forEach((plan: Planrepas) => {
      if(plan.numeroplan == parseInt(numeroplan)){
        this.selectedPlan = plan;
      }
    });
    console.log(this.selectedPlan)
  }

  public modifier(): void{
    const newplan: Planrepas = {
      numeroplan: this.selectedPlan.numeroplan,
      categorie: this.newPlanCat.nativeElement.value,
      frequence: this.newPlanFreq.nativeElement.value,
      nbrpersonnes: this.newPlanNbPersonnes.nativeElement.value,
      nbrcalories: this.newPlanNbCalories.nativeElement.innerText,
      prix: parseInt(this.newPlanPrix.nativeElement.innerText),
      numerofournisseur: parseInt(this.selectedFournisseur)
    }
    this.communicationService.updatePlan(newplan).subscribe((res: number) => {
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
        this.modifier();
      }else{
        console.log("please select a fournisseur")
      }
    }
  }
}

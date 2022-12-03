import { Component, OnInit } from '@angular/core';
import { CommunicationService } from "../services/communication.service";
import { Planrepas } from "../../../../common/tables/Planrepas";
import { Fournisseur } from "../../../../common/tables/Fournisseur";

@Component({
  selector: 'app-tous-les-plans',
  templateUrl: './tous-les-plans.component.html',
  styleUrls: ['./tous-les-plans.component.css']
})
export class TousLesPlansComponent implements OnInit {

  // @ViewChild("newPlanNb") newPlanNb: ElementRef;
  // @ViewChild("newPlanCat") newPlanCat: ElementRef;
  // @ViewChild("newPlanFreq") newPlanFreq: ElementRef;
  // @ViewChild("newPlanNbPersonnes") newPlanNbPersonnes: ElementRef;
  // @ViewChild("newPlanNbCalories") newPlanNbCalories: ElementRef;
  // @ViewChild("newPlanPrix") newPlanPrix: ElementRef;
  // @ViewChild("newPlanNumFourn") newPlanNumFourn: ElementRef;
  
  public plans: Planrepas[] = [];
  public fournisseurs: Fournisseur[] = [];
 
  constructor(private communicationService: CommunicationService) { }

  ngOnInit(): void {
    this.getPlans();
  }

  public getPlans(): void{
    this.communicationService.getPlans().subscribe((plans: [Planrepas[], Fournisseur[]]) => {
      this.plans = plans[0];
      this.fournisseurs = plans[1];
    });
  }
}

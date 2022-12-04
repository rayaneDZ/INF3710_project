import { Component, OnInit } from '@angular/core';
import { CommunicationService } from "../services/communication.service";
import { Planrepas } from "../../../../common/tables/Planrepas";

@Component({
  selector: 'app-supprimer-plans',
  templateUrl: './supprimer-plans.component.html',
  styleUrls: ['./supprimer-plans.component.css']
})
export class SupprimerPlansComponent implements OnInit {
  clickedRows: Planrepas;
  displayedColumns: string[] = ['numeroplan', 'categorie', 'frequence', 'nbrpersonnes', 'nbrcalories', 'prix', 'numerofournisseur'];
  public plans: Planrepas[] = [];
 
  constructor(private communicationService: CommunicationService) { }

  ngOnInit(): void {
    this.getPlans();
  }

  public getPlans(): void{
    this.communicationService.getPlans().subscribe((plans: Planrepas[]) => {
      this.plans = plans;
    });
  }

  public clicked(): void{
    let numeroplan = this.clickedRows.numeroplan.toString();
    this.communicationService.deletePlan(numeroplan).subscribe((res: number) => {
      console.log("res = ", res);
      this.getPlans();
    })
  }
}

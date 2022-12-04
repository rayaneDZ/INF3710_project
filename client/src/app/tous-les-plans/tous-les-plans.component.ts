import { Component, OnInit } from '@angular/core';
import { CommunicationService } from "../services/communication.service";
import { Planrepas } from "../../../../common/tables/Planrepas";

@Component({
  selector: 'app-tous-les-plans',
  templateUrl: './tous-les-plans.component.html',
  styleUrls: ['./tous-les-plans.component.css']
})
export class TousLesPlansComponent implements OnInit {
  
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
}

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AjouterPlansComponent } from './ajouter-plans.component';

describe('AjouterPlansComponent', () => {
  let component: AjouterPlansComponent;
  let fixture: ComponentFixture<AjouterPlansComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AjouterPlansComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AjouterPlansComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

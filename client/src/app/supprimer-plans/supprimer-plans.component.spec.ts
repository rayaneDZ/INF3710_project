import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SupprimerPlansComponent } from './supprimer-plans.component';

describe('SupprimerPlansComponent', () => {
  let component: SupprimerPlansComponent;
  let fixture: ComponentFixture<SupprimerPlansComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SupprimerPlansComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(SupprimerPlansComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

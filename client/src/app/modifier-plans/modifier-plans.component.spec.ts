import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModifierPlansComponent } from './modifier-plans.component';

describe('ModifierPlansComponent', () => {
  let component: ModifierPlansComponent;
  let fixture: ComponentFixture<ModifierPlansComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModifierPlansComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModifierPlansComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TousLesPlansComponent } from './tous-les-plans.component';

describe('TousLesPlansComponent', () => {
  let component: TousLesPlansComponent;
  let fixture: ComponentFixture<TousLesPlansComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TousLesPlansComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TousLesPlansComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

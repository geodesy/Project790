program main
  
  use DataInputM
  use Structural2DApplicationM
  use GIDDataOutputM
  use StructuralStrategyM
  use SolvingStrategyM

  implicit none

  type(Structural2DApplicationDT) :: application
  type(StructuralStrategyDT)      :: strategy
  type(SolvingStrategyDT)         :: solvingStrategy

  call initFEM2D(application)
  solvingStrategy = InitSolvingStrategy(strategy, application%model)
  call solvingStrategy%useStrategy()
  call initDataOutput()
  call printResults(resultName = 'Displacement'      &
       , step         = 1                            &
       , graphType    = 'Vector'                     &
       , locationName = 'onNodes'                    &
       , resultNumber = application%model%getnNode()  &
       , nDof         = 2                             &
       , component1   = application%model%dof         )
  
  call printResults(resultName = 'NormalStressOnTriangs'                  &
       , type         = 'Triangle'                                        &
       , step         = 1                                                 &
       , graphType    = 'Vector'                                          &
       , locationName = 'onGaussPoints'                                   &
       , gaussPoints  = application%model%normalStress%triangGPoint       &
       , resultNumber = size(application%model%normalStress%triangElemID) &
       , elemID       = application%model%normalStress%triangElemID       &
       , component1   = application%model%normalStress%triangNS(:,1)       &
       , component2   = application%model%normalStress%triangNS(:,2)       )
  call printResults(resultName = 'NormalStressOnQuads'                   &
       , type         = 'Quadrilateral'                                  &
       , step         = 1                                                &
       , graphType    = 'Vector'                                         &
       , locationName = 'onGaussPoints'                                  &
       , gaussPoints  = application%model%normalStress%quadGPoint        &
       , resultNumber = size(application%model%normalStress%quadElemID)  &
       , elemID       = application%model%normalStress%quadElemID        &
       , component1   = application%model%normalStress%quadNS(:,1)       &
       , component2   = application%model%normalStress%quadNS(:,2)       )

  call printResults(resultName = 'ShearStressOnTriangs'                 &
       , type         = 'Triangle'                                      &
       , step         = 1                                               &
       , graphType    = 'Scalar'                                        &
       , locationName = 'onGaussPoints'                                 &
       , gaussPoints  = application%model%shearStress%triangGPoint       &
       , resultNumber = size(application%model%shearStress%triangElemID) &
       , elemID       = application%model%shearStress%triangElemID       &
       , component1   = application%model%shearStress%triangShS          )
  call printResults(resultName = 'ShearStressOnQuads'                  &
       , type         = 'Quadrilateral'                                &
       , step         = 1                                              &
       , graphType    = 'Scalar'                                       &
       , locationName = 'onGaussPoints'                                &
       , gaussPoints  = application%model%shearStress%quadGPoint        &
       , resultNumber = size(application%model%shearStress%quadElemID)  &
       , elemID       = application%model%shearStress%quadElemID        &
       , component1   = application%model%shearStress%quadShS           )

  call printResults(resultName = 'StrainStressOnTriangs'           &
       , type         = 'Triangle'                                 &
       , step         = 1                                          &
       , graphType    = 'Vector'                                   &
       , locationName = 'onGaussPoints'                            &
       , gaussPoints  = application%model%strain%triangGPoint       &
       , resultNumber = size(application%model%strain%triangElemID) &
       , elemID       = application%model%strain%triangElemID       &
       , component1   = application%model%strain%triangEp(:,1)      &
       , component2   = application%model%strain%triangEp(:,2)      )
  call printResults(resultName = 'StrainStressOnQuads'            &
       , type         = 'Quadrilateral'                           &
       , step         = 1                                         &
       , graphType    = 'Vector'                                  &
       , locationName = 'onGaussPoints'                           &
       , gaussPoints  = application%model%strain%quadGPoint        &
       , resultNumber = size(application%model%strain%quadElemID)  &
       , elemID       = application%model%strain%quadElemID        &
       , component1   = application%model%strain%quadEp(:,1)       &
       , component2   = application%model%strain%quadEp(:,2)       )
 
end program main

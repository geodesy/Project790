module Structural2DApplicationM
  
  use UtilitiesM
  use DebuggerM

  use SourceM
  use NodeM
  
  use StructuralElementM
  use PressureM
  use StructuralMaterialM
  use StructuralModelM

  implicit none

  private
  public :: Structural2DApplicationDT, structural2DApplication

  type :: Structural2DApplicationDT
     type(NodeDT)              , dimension(:), allocatable :: node
     type(StructuralElementDT) , dimension(:), allocatable :: element
     type(PressureDT)          , dimension(:), allocatable :: pressure
     type(SourceDT)            , dimension(:), allocatable :: source
     type(StructuralMaterialDT), dimension(:), allocatable :: material
     type(StructuralModelDT)                               :: model
   contains
     procedure, public :: init
  end type Structural2DApplicationDT

  interface structural2DApplication
     procedure :: constructor
  end interface structural2DApplication

contains

  type(Structural2DApplicationDT) function  &
       constructor(nNode, nElement, nPressure, nSource, nMaterial, nGauss)
    implicit none
    integer(ikind), intent(in) :: nNode
    integer(ikind), intent(in) :: nElement
    integer(ikind), intent(in) :: nPressure
    integer(ikind), intent(in) :: nSource
    integer(ikind), intent(in) :: nMaterial
    integer(ikind), intent(in) :: nGauss
    call constructor%init(nNode, nElement, nPressure, nSource, nMaterial, nGauss)
  end function constructor

  subroutine init(this, nNode, nElement, nPressure, nSource, nMaterial, nGauss)
    implicit none
    class(Structural2DApplicationDT), intent(inout) :: this
    integer(ikind)                  , intent(in)    :: nNode
    integer(ikind)                  , intent(in)    :: nElement
    integer(ikind)                  , intent(in)    :: nPressure
    integer(ikind)                  , intent(in)    :: nSource
    integer(ikind)                  , intent(in)    :: nMaterial
    integer(ikind)                  , intent(in)    :: nGauss
    allocate(this%node(nNode))
    allocate(this%element(nElement))
    allocate(this%pressure(nPressure))
    allocate(this%source(nSource))
    allocate(this%material(nMaterial))
    call initGeometries(nGauss)
    this%model = structuralModel(                 &
           nDof = 2*nNode                         &
         , nnz = nElement*256                     &
         , id = 1                                 &
         , nNode = nNode                          &
         , nElement = nElement                    &
         , nCondition = nPressure                 )
  end subroutine init

end module Structural2DApplicationM

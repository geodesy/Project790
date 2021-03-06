module Thermal2DApplicationM
  
  use UtilitiesM
  use DebuggerM

  use SourceM
  use NodeM
  
  use ThermalElementM
  use ConvectionOnLineM
  use FluxOnLineM
  use ThermalMaterialM
  use ThermalModelM

  implicit none

  private
  public :: Thermal2DApplicationDT, thermal2DApplication

  type :: Thermal2DApplicationDT
     type(NodeDT)            , dimension(:), allocatable :: node
     type(ThermalElementDT)  , dimension(:), allocatable :: element
     type(ConvectionOnLineDT), dimension(:), allocatable :: convectionOL
     type(FluxOnLineDT)      , dimension(:), allocatable :: normalFluxOL
     type(SourceDT)          , dimension(:), allocatable :: source
     type(ThermalMaterialDT) , dimension(:), allocatable :: material
     type(ThermalModelDT)                                :: model
   contains
     procedure, public :: init
     procedure, public :: setTransientValues
  end type Thermal2DApplicationDT

  interface thermal2DApplication
     procedure :: constructor
  end interface thermal2DApplication

contains

  type(Thermal2DApplicationDT) function  &
       constructor(nNode, nElement, nConvection, nNormalFlux, nSource, nMaterial, nGauss)
    implicit none
    integer(ikind), intent(in) :: nNode
    integer(ikind), intent(in) :: nElement
    integer(ikind), intent(in) :: nConvection
    integer(ikind), intent(in) :: nNormalFlux
    integer(ikind), intent(in) :: nSource
    integer(ikind), intent(in) :: nMaterial
    integer(ikind), intent(in) :: nGauss
    call constructor%init(nNode, nElement, nConvection, nNormalFlux, nSource, nMaterial, nGauss)
  end function constructor

  subroutine init(this, nNode, nElement, nConvection, nNormalFlux, nSource, nMaterial, nGauss)
    implicit none
    class(Thermal2DApplicationDT), intent(inout) :: this
    integer(ikind)               , intent(in)    :: nNode
    integer(ikind)               , intent(in)    :: nElement
    integer(ikind)               , intent(in)    :: nConvection
    integer(ikind)               , intent(in)    :: nNormalFlux
    integer(ikind)               , intent(in)    :: nSource
    integer(ikind)               , intent(in)    :: nMaterial
    integer(ikind)               , intent(in)    :: nGauss
    allocate(this%node(nNode))
    allocate(this%element(nElement))
    allocate(this%convectionOL(nConvection))
    allocate(this%normalFluxOL(nNormalFlux))
    allocate(this%source(nSource))
    allocate(this%material(nMaterial))
    call initGeometries(nGauss)
    this%model = thermalModel(                    &
           nDof = nNode                           &
         , nnz = nElement*64                      &
         , id = 1                                 &
         , nNode = nNode                          &
         , nElement = nElement                    &
         , nCondition = nConvection + nNormalFlux )
  end subroutine init

  subroutine setTransientValues(this, printStep, t0, errorTol)
    implicit none
    class(Thermal2DApplicationDT), intent(inout) :: this
    integer(ikind)               , intent(in)    :: printStep
    real(rkind)                  , intent(in)    :: t0
    real(rkind)                  , intent(in)    :: errorTol
    call this%model%setTransientValues(printStep, t0, errorTol)
  end subroutine setTransientValues

end module Thermal2DApplicationM

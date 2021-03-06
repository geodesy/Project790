module ElementPtrM
  use UtilitiesM
  use DebuggerM

  use NodeM
  use NodePtrM

  use GeometryM

  use IntegratorPtrM

  use LeftHandSideM

  use ProcessInfoM

  use SourceM
  use SourcePtrM
  
  use ElementM

  implicit none

  private
  public :: ElementPtrDT

  type :: ElementPtrDT
     class(ElementDT), pointer :: ptr
   contains
     procedure, public :: assignGeometry
     procedure, public :: assignNode
     procedure, public :: assignSourceOne
     procedure, public :: assignSourceMulti
     generic           :: assignSource => assignSourceOne, assignSourceMulti

     procedure, public :: getID
     procedure, public :: getnNode
     procedure, public :: getIntegrator
     procedure, public :: getNode
     procedure, public :: getNodeID
     procedure, public :: hasSourceOneSource
     procedure, public :: hasSourceMultiSource
     generic           :: hasSource => hasSourceOneSource, hasSourceMultiSource

     procedure, public :: calculateLocalSystem
     procedure, public :: calculateLHS
     procedure, public :: calculateRHS
     procedure, public :: calculateResults
  end type ElementPtrDT

contains

  subroutine assignGeometry(this, geometry)
    implicit none
    class(ElementPtrDT)      , intent(inout) :: this
    class(GeometryDT), target, intent(in)    :: geometry
    call this%ptr%assignGeometry(geometry)
  end subroutine assignGeometry

  subroutine assignNode(this, index, node)
    implicit none
    class(ElementPtrDT)     , intent(inout) :: this
    integer(ikind)          , intent(in)    :: index
    type(NodeDT)    , target, intent(in)    :: node
    call this%ptr%assignNode(index, node)
  end subroutine assignNode

  subroutine assignSourceOne(this, source)
    implicit none
    class(ElementPtrDT)     , intent(inout) :: this
    class(SourceDT) , target, intent(in)    :: source
    call this%ptr%assignSourceOne(source)
  end subroutine assignSourceOne

  subroutine assignSourceMulti(this, iSource, source)
    implicit none
    class(ElementPtrDT)     , intent(inout) :: this
    integer(ikind)          , intent(in)    :: iSource
    class(SourceDT) , target, intent(in)    :: source
    call this%ptr%assignSourceMulti(iSource, source)
  end subroutine assignSourceMulti

  integer(ikind) pure function getID(this)
    implicit none
    class(ElementPtrDT), intent(in) :: this
    getID = this%ptr%getID()
  end function getID

  integer(ikind) pure function getnNode(this)
    implicit none
    class(ElementPtrDT), intent(in) :: this
    getnNode = this%ptr%getnNode()
  end function getnNode

  type(IntegratorPtrDT) function getIntegrator(this)
    implicit none
    class(ElementPtrDT), intent(inout) :: this
    getIntegrator = this%ptr%getIntegrator()
  end function getIntegrator

  type(NodePtrDT) function getNode(this, iNode)
    implicit none
    class(ElementPtrDT), intent(inout) :: this
    integer(ikind)     , intent(in)    :: iNode
    getNode = this%ptr%getNode(iNode)
  end function getNode

  integer(ikind) pure function getNodeID(this, iNode)
    implicit none
    class(ElementPtrDT), intent(in) :: this
    integer(ikind)     , intent(in) :: iNode
    getNodeID = this%ptr%getNodeID(iNode)
  end function getNodeID

  logical function hasSourceOneSource(this)
    implicit none
    class(ElementPtrDT), intent(inout) :: this
    hasSourceOneSource = this%ptr%hasSourceOneSource()
  end function hasSourceOneSource

  logical function hasSourceMultiSource(this, iSource)
    implicit none
    class(ElementPtrDT), intent(inout) :: this
    integer(ikind)     , intent(in)    :: iSource
    hasSourceMultiSource = this%ptr%hasSourceMultiSource(iSource)
  end function hasSourceMultiSource

  subroutine calculateLocalSystem(this, processInfo, lhs, rhs)
    implicit none
    class(ElementPtrDT)                              , intent(inout) :: this
    type(ProcessInfoDT)                              , intent(inout) :: processInfo
    type(LeftHandSideDT)                             , intent(inout) :: lhs
    real(rkind)         , dimension(:)  , allocatable, intent(inout) :: rhs
    call this%ptr%calculateLocalSystem(processInfo, lhs, rhs)
  end subroutine calculateLocalSystem

  subroutine calculateLHS(this, processInfo, lhs)
    implicit none
    class(ElementPtrDT) , intent(inout) :: this
    type(ProcessInfoDT) , intent(inout) :: processInfo
    type(LeftHandSideDT), intent(inout) :: lhs
    call this%ptr%calculateLHS(processInfo, lhs)
  end subroutine calculateLHS

  subroutine calculateRHS(this, processInfo, rhs)
    implicit none
    class(ElementPtrDT)                           , intent(inout) :: this
    type(ProcessInfoDT)                           , intent(inout) :: processInfo
    real(rkind)        , dimension(:), allocatable, intent(inout) :: rhs
    call this%ptr%calculateRHS(processInfo, rhs)
  end subroutine calculateRHS

  subroutine calculateResults(this, processInfo, resultMat)
    implicit none
    class(ElementPtrDT)                               , intent(inout) :: this
    type(ProcessInfoDT)                               , intent(inout) :: processInfo
    real(rkind)        , dimension(:,:,:), allocatable, intent(inout) :: resultMat
    call this%ptr%calculateResults(processInfo, resultMat)
  end subroutine calculateResults
  
end module ElementPtrM

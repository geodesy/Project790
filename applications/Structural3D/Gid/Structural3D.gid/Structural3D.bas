###########################################################
            PROGRAM STRUCTURAL 3D ANALYSIS
###########################################################

##################### PROBLEM DATA ########################

Problem Name: *gendata(Problem_Name)

###################### Mesh Data ##########################
Elements_Number........................: *nelem
Nodes_Number...........................: *npoin
Are_Elements_Quadratic.................: *isQuadratic
*#---------------------------------------------------------
*set var j=0
*set var k=0
*loop elems
*#ElemsTypeName
*if(strcasecmp(ElemsTypeName(),"Tetrahedra")==0)
*set var j=operation(j+1)
*endif
*if(strcasecmp(ElemsTypeName(),"Hexahedra")==0)
*set var k=operation(k+1)
*endif
*end elems
*#---------------------------------------------------------
Tetrahedral_Elements_Number............: *j
Hexahedral_Elements_Number.............: *k
*#---------------------------------------------------------
Materials_Number.......................: *nmats
Gauss_Order............................: *GenData(Gauss_Order)
*#---------------------------------------------------------
*Set Cond Fix_Displacement_X_On_Line *nodes
*Set var a = condnumentities
*Set Cond Fix_Displacement_X_On_Point *nodes
*Set var b = condnumentities
*Set Cond Fix_Displacement_X_On_Surface *nodes
*Set var c = condnumentities
*Set var d = operation(a+b+c)
*#---------------------------------------------------------
Fix_Displacement_X_Number..............: *d
*#---------------------------------------------------------
*Set Cond Fix_Displacement_Y_On_Line *nodes
*Set var a = condnumentities
*Set Cond Fix_Displacement_Y_On_Point *nodes
*Set var b = condnumentities
*Set Cond Fix_Displacement_Y_On_Surface *nodes
*Set var c = condnumentities
*Set var d = operation(a+b+c)
*#---------------------------------------------------------
Fix_Displacement_Y_Number..............: *d
*#---------------------------------------------------------
*Set Cond Fix_Displacement_Z_On_Line *nodes
*Set var a = condnumentities
*Set Cond Fix_Displacement_Z_On_Point *nodes
*Set var b = condnumentities
*Set Cond Fix_Displacement_Z_On_Surface *nodes
*Set var c = condnumentities
*Set var d = operation(a+b+c)
*#---------------------------------------------------------
Fix_Displacement_Z_Number..............: *d
*#---------------------------------------------------------
*set Cond Pressure_On_Surfaces *elems *canrepeat
Pressure_On_Surfaces_Condition_elements: *condnumentities
*#---------------------------------------------------------
Load_Number_On_Points..................: *Gendata(Load_Number_On_Points,int)
*#---------------------------------------------------------
Load_Number_On_Volumes.................: *Gendata(Load_Number_On_Volumes,int)
*#---------------------------------------------------------
*Set Cond Loads_On_Points *nodes
Points_With_Point_Load.................: *condnumentities
*#---------------------------------------------------------
*Set Cond Loads_On_Volumes *elems
Surfaces_With_Volume_Load..............: *condnumentities
*#---------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Coordinates:

  Node   |     X       |       Y        |       Z        |
----------------------------------------------------------
*set elems(all)
*loop nodes
*format "%5i%10.4e%10.4e%10.4e"
*NodesNum       *NodesCoord(1,real)     *NodesCoord(2,real)     *NodesCoord(3,real)
*end nodes

######################## Materials ########################

Materials List:

Material | Thermal expansion | Young's modulus | Poisson's ratio
----------------------------------------------------------------
*loop materials
*format "%5i%10.4e%10.4e%10.4e"
*matnum          *matprop(Thermal_Expansion)         *matprop(Young_Modulus)       *matprop(Poisson's_Ratio)
*end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Element List:

      Element  |      Type      |  Material  |   Nodes  |      Conectivities
-----------------------------------------------------------------------------------
*Set Cond Loads_On_Volumes *elems
*loop elems
*format "%10i%10i%9i%9i%9i"
*elemsnum         *ElemstypeName  *elemsmat  *ElemsNnode  *elemsconec
*end elems

####################### Loads ############################

Conditions List:

Load   |  Function
----------------------
*Set var j = 0
*Set cond Loads_On_Points *nodes
*for(i=1;i<=Gendata(Load_Number_On_Points,int);i=i+1))
*set var j=operation(j+1)
*loop nodes *OnlyInCond
*if(i==cond(Load_Number_On_Points,real))
*format "%5i%10s%10s%10s"
*j *cond(LoadXOP) *cond(LoadYOP) *cond(LoadZOP)
*break
*endif
*end
*end for
*Set cond Loads_On_Volumes
*for(i=1;i<=Gendata(Load_Number_On_Volumes,int);i=i+1))
*set var j=operation(j+1)
*loop elems
*if(i==cond(Load_Number_On_Volumes,real))
*format "%5i%10s%10s%10s"
*j *cond(LoadXOV) *cond(LoadYOV) *cond(LoadZOV)
*break
*endif
*end
*end for

###################### Point Loads ######################

Conditions List:

  Node   |  Load
--------------------------
*Set Cond Loads_On_Points *nodes
*loop nodes *OnlyInCond
*format "%5i%5i"
*NodesNum      *cond(Load_Number_On_Points) 
*end

###################### Volume Loads #####################

Conditions List:

  Element   |  Load
--------------------------
*Set Cond Loads_On_Volumes *elems
*loop elems *OnlyInCond
*format "%8i%8i"
*elemsnum  *cond(Load_Number_On_Volumes)
*end

####################### Displacements X ######################

Conditions List:

  Node    |    Displacement X
--------------------------------
*Set Cond Fix_Displacement_X_On_Surface *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_X) 
*end
*Set Cond Fix_Displacement_X_On_Line *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_X) 
*end
*Set Cond Fix_Displacement_X_On_Point *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_X) 
*end

####################### Displacements Y ######################

Conditions List:

  Node    |    Displacement Y
--------------------------------
*Set Cond Fix_Displacement_Y_On_Surface *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_Y) 
*end
*Set Cond Fix_Displacement_Y_On_Line *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_Y) 
*end
*Set Cond Fix_Displacement_Y_On_Point *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_Y) 
*end

####################### Displacements Z ######################

Conditions List:

  Node    |    Displacement Z
--------------------------------
*Set Cond Fix_Displacement_Z_On_Surface *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_Z) 
*end
*Set Cond Fix_Displacement_Z_On_Line *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_Z) 
*end
*Set Cond Fix_Displacement_Z_On_Point *nodes
*loop nodes *OnlyInCond
*format "%5i%10.4e"
*NodesNum           *cond(Displacement_Z) 
*end

##################### Pressure On Surfaces ####################

Conditions List:

 Element |       Nodes      |   Pressure
--------------------------------------------
*Set Cond Pressure_On_Surfaces *elems *canrepeat
*loop elems *OnlyInCond
*format "%5i%7i%7i"
*elemsnum  *ElemsNnodeFace *localnodes  *cond(Pressure,real)
*end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

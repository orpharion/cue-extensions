package GsaAPI

import (
	Reflection "microsoft-corporation.com/System.Private.CoreLib/v5.0.0.0/System/Reflection"
	Collections "microsoft-corporation.com/System.Private.CoreLib/v5.0.0.0/System/Collections"
	System "microsoft-corporation.com/System.Private.CoreLib/v5.0.0.0/System"
	)

#ApiExceptionCodeEnum: {
	GS_EX_GENERIC:                        0
	GS_EX_NO_OPENFILE:                    1
	GS_EX_INVALID_FILE_EXTENSION:         2
	GS_EX_UNSUPPORTED_NODE_TYPE:          3
	GS_EX_APPLICATION_AVF_MISSING:        4
	GS_EX_SECTION_DB_MISSING:             5
	GS_EX_UNSUPPORTED_ANALYSIS_TASK_TYPE: 6
	GS_EX_ANALYSIS_TASK_DOESNT_EXIST:     7
	GS_EX_API_EXPIRED:                    8
}
#ApiExceptionCode: or(
			[

		for _, v in #ApiExceptionCodeEnum {
					v
				}])
#GsaApiException: ({
	@dotnet({FullName:GsaAPI.GsaApiException})
	ExtraInformation: string
	Code:             #ApiExceptionCode
	TargetSite:       Reflection.#MethodBase
	StackTrace:       string
	Message:          string
	Data:             Collections.#IDictionary
	InnerException:   System.#Exception
	HelpLink:         string
	Source:           string
	HResult:          int32
} | null)
#StartupController: ({
	@dotnet({FullName:GsaAPI.StartupController})
	Dispose?: {
			$id: "method"
		}} | null)
#Vector3: ({
	@dotnet({FullName:GsaAPI.Vector3})
	Z: float
	Y: float
	X: float
	Dispose?: {
			$id: "method"
		}} | null)
#Double6: ({
	@dotnet({FullName:GsaAPI.Double6})
	ZZ: float
	YY: float
	XX: float
	Z:  float
	Y:  float
	X:  float
} | null)
#Double3: ({
	@dotnet({FullName:GsaAPI.Double3})
	Z: float
	Y: float
	X: float
} | null)
#Bool6: ({
	@dotnet({FullName:GsaAPI.Bool6})
	ZZ: bool
	YY: bool
	XX: bool
	Z:  bool
	Y:  bool
	X:  bool
} | null)
#Tensor2: ({
	@dotnet({FullName:GsaAPI.Tensor2})
	YX: float
	XY: float
	YY: float
	XX: float
} | null)
#Tensor3: ({
	@dotnet({FullName:GsaAPI.Tensor3})
	ZX: float
	YZ: float
	XY: float
	ZZ: float
	YY: float
	XX: float
} | null)
#Vector2: ({
	@dotnet({FullName:GsaAPI.Vector2})
	Y: float
	X: float
} | null)
#Control: ({
	@dotnet({FullName:GsaAPI.Control})
} | null)
#SidAblility: ({
	@dotnet({FullName:GsaAPI.SidAblility})
	Sid: string
	SetSidTag?: {
		$id: "method"
		In: {
				tag:   string
				value: string
			}}} | null)
#GlobalResult: ({
	@dotnet({FullName:GsaAPI.GlobalResult})
	Mode:                    int32
	Frequency:               float
	EffectiveMass:           #Vector3
	EffectiveInertia:        #Vector3
	ModalMass:               float
	ModalStiffness:          float
	ModalGeometricStiffness: float
	LoadFactor:              float
	TotalLoad:               #Double6
	TotalReaction:           #Double6
} | null)
#NodeResult: ({
	@dotnet({FullName:GsaAPI.NodeResult})
	Displacement: #Double6
	Reaction:     #Double6
	Constraint:   #Double6
	SpringForce:  #Double6
} | null)
#Element1DResult: ({
	@dotnet({FullName:GsaAPI.Element1DResult})
	Displacement: [
		...#Double6]
	Force: [
		...#Double6]
	StrainEnergyDensity: [
		...float]
	AverageStrainEnergyDensity: float
} | null)
#Element2DResult: ({
	@dotnet({FullName:GsaAPI.Element2DResult})
	Displacement: [
		...#Double6]
	Force: [
		...#Tensor2]
	Moment: [
		...#Tensor2]
	Shear: [
		...#Vector2]
			Stress: [
				...#Tensor3]} | null)
#Element3DResult: ({
	@dotnet({FullName:GsaAPI.Element3DResult})
	Displacement: [
		...#Double3]
			Stress: [
				...#Tensor3]} | null)
#AnalysisCaseResult: ({
	@dotnet({FullName:GsaAPI.AnalysisCaseResult})
	Global: #GlobalResult
	NodeResults?: {
		$id: "method"
		In: {
			nodeList: string
		}
		Out: [
			..._|_]}
	Element1DResults?: {
		$id: "method"
		In: {
			elementList: string
			positions: [
				...float]}
		Out: [
			..._|_]}
	Element1DResults?: {
		$id: "method"
		In: {
			elementList:   string
			positionCount: int32
		}
		Out: [
			..._|_]}
	Element2DResults?: {
		$id: "method"
		In: {
			elementList: string
			fLayer:      float
		}
		Out: [
			..._|_]}
	Element3DResults?: {
		$id: "method"
		In: {
			elementList: string
		}
		Out: [
			..._|_]}} | null)
#ReturnValueEnum: {
	GS_OK:                             0
	GS_FILE_OPEN_ERROR:                1
	GS_NO_RESULTS:                     2
	GS_NO_DATA_FOUND:                  3
	GS_FILE_SAVE_FAILED:               4
	GS_UNSUPPORTED_FILE_FORMAT:        5
	GS_SECTION_DB_MISSING:             6
	GS_APPLICATION_AVF_MISSING:        7
	GS_UNSUPPORTED_ANALYSIS_TASK_TYPE: 8
	GS_ANALYSIS_TASK_DOESNT_EXIST:     9
}
#ReturnValue: or(
		[

		for _, v in #ReturnValueEnum {
			v
		}])
#DirectionEnum: {
	NONE: 0
	X:    1
	Y:    2
	Z:    3
	XX:   4
	YY:   5
	ZZ:   6
	XY:   7
	YZ:   8
	ZX:   9
	YX:   10
	ZY:   11
	XZ:   12
}
#Direction: or(
		[

		for _, v in #DirectionEnum {
				v
			}])
#AnalysisTask: ({
	@dotnet({FullName:GsaAPI.AnalysisTask})
	Cases: [
		...int32]
	Type: int32
	Name: string
} | null)
#MaterialTypeEnum: {
	UNDEF:     -2
	NONE:      -1
	GENERIC:   0
	STEEL:     1
	FIRST:     1
	CONCRETE:  2
	ALUMINIUM: 3
	GLASS:     4
	FRP:       5
	REBAR:     6
	TIMBER:    7
	FABRIC:    8
	SOIL:      9
	NUM_MT:    10
	COMPOUND:  256
	BAR:       4096
	TENDON:    4352
	FRPBAR:    4608
	CFRP:      4864
	GFRP:      5120
	AFRP:      5376
	ARGFRP:    5632
	BARMAT:    65280
}
#MaterialType: or(
		[

		for _, v in #MaterialTypeEnum {
				v
			}])
#Section: ({
	@dotnet({FullName:GsaAPI.Section})
	SurfaceAreaPerLength:     float
	VolumePerLength:          float
	Kz:                       float
	Ky:                       float
	J:                        float
	Iyz:                      float
	Izz:                      float
	Iyy:                      float
	Area:                     float
	Pool:                     int32
	MaterialAnalysisProperty: int32
	MaterialGradeProperty:    int32
	MaterialType:             #MaterialType
	Profile:                  string
	Colour:                   System.#ValueType
	Name:                     string
	Sid:                      string
	MaterialTypeAsString?: {
		$id: "method"
		Out: string
	}
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#BeamLoadTypeEnum: {
	UNDEF:     0
	POINT:     1
	UNIFORM:   2
	LINEAR:    3
	PATCH:     4
	TRILINEAR: 5
}
#BeamLoadType: or(
		[

		for _, v in #BeamLoadTypeEnum {
				v
			}])
#BeamLoad: ({
	@dotnet({FullName:GsaAPI.BeamLoad})
	Name:         string
	Direction:    #Direction
	IsProjected:  bool
	AxisProperty: int32
	Type:         #BeamLoadType
	Case:         int32
	Elements:     string
	Sid:          string
	Position?: {
		$id: "method"
		In: {
			position: int32
		}
		Out: float
	}
	SetPosition?: {
		$id: "method"
		In: {
			position: int32
			value:    float
		}}
	Value?: {
		$id: "method"
		In: {
			position: int32
		}
		Out: float
	}
	SetValue?: {
		$id: "method"
		In: {
			position: int32
			value:    float
		}}
	TypeAsString?: {
		$id: "method"
		Out: string
	}
	DirectionAsString?: {
		$id: "method"
		Out: string
	}
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
				tag:   string
				value: string
			}}} | null)
#Offset: ({
	@dotnet({FullName:GsaAPI.Offset})
	Z:  float
	Y:  float
	X2: float
	X1: float
} | null)
#ParentMember: ({
	@dotnet({FullName:GsaAPI.ParentMember})
	Replica: int32
	Member:  int32
} | null)
#ElementTypeEnum: {
	NEW:        -1
	UNDEF:      0
	FIRST_TYPE: 1
	BAR:        1
	BEAM:       2
	SPRING:     3
	QUAD4:      5
	QUAD8:      6
	TRI3:       7
	TRI6:       8
	LINK:       9
	CABLE:      10
	TAPER_BEAM: 11
	BRICK8:     12
	WEDGE6:     14
	TETRA4:     16
	SPACER:     19
	STRUT:      20
	TIE:        21
	BEAM3:      22
	ROD:        23
	DAMPER:     24
	PYRAMID5:   26
	LAST_TYPE:  26
	ONE_D:      27
	TWO_D:      28
	THREE_D:    29
	ONE_D_SECT: 30
	TWO_D_FE:   31
	TWO_D_LOAD: 32
}
#ElementType: or(
		[

		for _, v in #ElementTypeEnum {
				v
			}])
#Element: ({
	@dotnet({FullName:GsaAPI.Element})
	ParentMember:     #ParentMember
	IsDummy:          bool
	Offset:           #Offset
	OrientationAngle: float
	OrientationNode:  int32
	Topology: [
		...int32]
	Type:     #ElementType
	Group:    int32
	Property: int32
	Colour:   System.#ValueType
	Name:     string
	Sid:      string
	Release?: {
		$id: "method"
		In: {
			iTopology: int32
		}
		Out: #Bool6
	}
	SetRelease?: {
		$id: "method"
		In: {
			iTopology: int32
			release:   #Bool6
		}}
	TypeAsString?: {
		$id: "method"
		Out: string
	}
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#FaceLoadTypeEnum: {
	UNDEF:    0
	CONSTANT: 1
	GENERAL:  2
	POINT:    3
}
#FaceLoadType: or(
		[

		for _, v in #FaceLoadTypeEnum {
				v
			}])
#FaceLoad: ({
	@dotnet({FullName:GsaAPI.FaceLoad})
	Position:     #Vector2
	Name:         string
	Direction:    #Direction
	IsProjected:  bool
	AxisProperty: int32
	Type:         #FaceLoadType
	Case:         int32
	Elements:     string
	Sid:          string
	Value?: {
		$id: "method"
		In: {
			position: int32
		}
		Out: float
	}
	SetValue?: {
		$id: "method"
		In: {
			position: int32
			value:    float
		}}
	TypeAsString?: {
		$id: "method"
		Out: string
	}
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
				tag:   string
				value: string
			}}} | null)
#GravityLoad: ({
	@dotnet({FullName:GsaAPI.GravityLoad})
	Name:     string
	Factor:   #Vector3
	Case:     int32
	Nodes:    string
	Elements: string
	Sid:      string
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#GridAreaPolyLineTypeEnum: {
	PLANE:   1
	POLYREF: 2
	POLYGON: 3
}
#GridAreaPolyLineType: or(
			[

		for _, v in #GridAreaPolyLineTypeEnum {
				v
			}])
#GridAreaLoad: ({
	@dotnet({FullName:GsaAPI.GridAreaLoad})
	PolyLineDefinition: string
	Name:               string
	Type:               #GridAreaPolyLineType
	Direction:          #Direction
	PolyLineReference:  int32
	GridSurface:        int32
	AxisProperty:       int32
	Case:               int32
	Value:              float
	IsProjected:        bool
	Sid:                string
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#GridLineLoad: {
	#PolyLineTypeEnum: {
		EXPLICIT_POLYLINE:  0
		POLYLINE_REFERENCE: 1
	}}
#GridLineLoad: {
	#PolyLineType: or(
			[

			for _, v in #GridLineLoad.#PolyLineTypeEnum {
				v
			}])
}
#GridLineLoad: ({
	@dotnet({FullName:GsaAPI.GridLineLoad})
	PolyLineDefinition: string
	Name:               string
	Type:               #GridLineLoad.#PolyLineType
	Direction:          #Direction
	PolyLineReference:  int32
	GridSurface:        int32
	AxisProperty:       int32
	Case:               int32
	ValueAtEnd:         float
	ValueAtStart:       float
	IsProjected:        bool
	Sid:                string
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
				tag:   string
				value: string
			}}} | null)
#GridPlane: ({
	@dotnet({FullName:GsaAPI.GridPlane})
	Name:           string
	ToleranceAbove: float
	ToleranceBelow: float
	Elevation:      float
	AxisProperty:   int32
	IsStoreyType:   bool
	Sid:            string
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
				tag:   string
				value: string
			}}} | null)
#GridPointLoad: ({
	@dotnet({FullName:GsaAPI.GridPointLoad})
	Name:         string
	Direction:    #Direction
	GridSurface:  int32
	Case:         int32
	AxisProperty: int32
	Y:            float
	X:            float
	Value:        float
	Sid:          string
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#GridSurfaceExpansionTypeEnum: {
	UNDEF:        -1
	LEGACY:       0
	PLANE_ASPECT: 1
	PLANE_SMOOTH: 2
	PLANE_CORNER: 3
}
#GridSurfaceExpansionType: or(
				[

		for _, v in #GridSurfaceExpansionTypeEnum {
			v
		}])
#GridSurface: {
	#Span_TypeEnum: {
		ONE_WAY:                            0
		TWO_WAY_SIMPLIFIED_TRIBUTARY_AREAS: 1
		TWO_WAY:                            2
	}}
#GridSurface: {
	#Span_Type: or(
			[

			for _, v in #GridSurface.#Span_TypeEnum {
				v
			}])
}
#GridSurface: {
	#Element_TypeEnum: {
		ONE_DIMENSIONAL: 1
		TWO_DIMENSIONAL: 2
	}}
#GridSurface: {
	#Element_Type: or(
			[

			for _, v in #GridSurface.#Element_TypeEnum {
				v
			}])
}
#GridSurface: ({
	@dotnet({FullName:GsaAPI.GridSurface})
	Name:          string
	Elements:      string
	ExpansionType: #GridSurfaceExpansionType
	SpanType:      #GridSurface.#Span_Type
	ElementType:   #GridSurface.#Element_Type
	Tolerance:     float
	Direction:     float
	GridPlane:     int32
	Sid:           string
	ElementTypeAsString?: {
		$id: "method"
		Out: string
	}
	SpanTypeAsString?: {
		$id: "method"
		Out: string
	}
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#AnalysisOrderEnum: {
	LINEAR:          0
	QUADRATIC:       1
	RIGID_DIAPHRAGM: 2
}
#AnalysisOrder: or(
		[

		for _, v in #AnalysisOrderEnum {
			v
		}])
#MemberTypeEnum: {
	UNDEF:          -1
	GENERIC_1D:     0
	GENERIC_2D:     1
	BEAM:           2
	COLUMN:         3
	SLAB:           4
	WALL:           5
	CANTILEVER:     6
	RIBSLAB:        7
	COMPOS:         8
	PILE:           9
	EXPLICIT:       10
	VOID_CUTTER_1D: 11
	VOID_CUTTER_2D: 12
	GENERIC_3D:     13
}
#MemberType: or(
		[

		for _, v in #MemberTypeEnum {
				v
			}])
#Member: ({
	@dotnet({FullName:GsaAPI.Member})
	IsDummy:          bool
	MeshSize:         float
	Type2D:           #AnalysisOrder
	Type1D:           #ElementType
	Offset:           #Offset
	OrientationAngle: float
	OrientationNode:  int32
	Topology:         string
	Type:             #MemberType
	Group:            int32
	Property:         int32
	Colour:           System.#ValueType
	Name:             string
	Sid:              string
	TypeAsString?: {
		$id: "method"
		Out: string
	}
	Type1DAsString?: {
		$id: "method"
		Out: string
	}
	Type2DAsString?: {
		$id: "method"
		Out: string
	}
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#ElementType_duplicateEnum: {
	NEW:        -1
	UNDEF:      0
	FIRST_TYPE: 1
	BAR:        1
	BEAM:       2
	SPRING:     3
	QUAD4:      5
	QUAD8:      6
	TRI3:       7
	TRI6:       8
	LINK:       9
	CABLE:      10
	TAPER_BEAM: 11
	BRICK8:     12
	WEDGE6:     14
	TETRA4:     16
	SPACER:     19
	STRUT:      20
	TIE:        21
	BEAM3:      22
	ROD:        23
	DAMPER:     24
	PYRAMID5:   26
	LAST_TYPE:  26
	ONE_D:      27
	TWO_D:      28
	THREE_D:    29
	ONE_D_SECT: 30
	TWO_D_FE:   31
	TWO_D_LOAD: 32
}
#ElementType_duplicate: or(
			[

		for _, v in #ElementType_duplicateEnum {
					v
				}])
#NodalRestraint: ({
	@dotnet({FullName:GsaAPI.NodalRestraint})
	ZZ: bool
	YY: bool
	XX: bool
	Z:  bool
	Y:  bool
	X:  bool
	Dispose?: {
		$id: "method"
	}} | null)
#Node: ({
	@dotnet({FullName:GsaAPI.Node})
	ConnectedMembers: [
		...int32]
	ConnectedElements: [
		...int32]
	Restraint:      #NodalRestraint
	Colour:         System.#ValueType
	Position:       #Vector3
	DamperProperty: int32
	MassProperty:   int32
	SpringProperty: int32
	AxisProperty:   int32
	Name:           string
	Sid:            string
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
				tag:   string
				value: string
			}}} | null)
#NodeLoad: ({
	@dotnet({FullName:GsaAPI.NodeLoad})
	Name:         string
	Value:        float
	Direction:    #Direction
	AxisProperty: int32
	Case:         int32
	Nodes:        string
	Sid:          string
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#NodeLoadTypeEnum: {
	NODE_LOAD:  0
	APPL_DISP:  1
	SETTLEMENT: 2
	GRAVITY:    3
	NUM_TYPES:  4
}
#NodeLoadType: or(
		[

		for _, v in #NodeLoadTypeEnum {
			v
		}])
#Property2D_TypeEnum: {
	UNDEF:        0
	PL_STRESS:    1
	PL_STRAIN:    2
	AXISYMMETRIC: 3
	FABRIC:       4
	PLATE:        5
	SHELL:        6
	CURVED_SHELL: 7
	TORSION:      8
	WALL:         9
	LOAD:         10
	NUM_TYPE:     11
}
#Property2D_Type: or(
			[

		for _, v in #Property2D_TypeEnum {
				v
			}])
#Prop2D: ({
	@dotnet({FullName:GsaAPI.Prop2D})
	MaterialAnalysisProperty: int32
	MaterialGradeProperty:    int32
	MaterialType:             #MaterialType
	Description:              string
	AxisProperty:             int32
	Type:                     #Property2D_Type
	Colour:                   System.#ValueType
	Name:                     string
	Sid:                      string
	TypeAsString?: {
		$id: "method"
		Out: string
	}
	MaterialTypeAsString?: {
		$id: "method"
		Out: string
	}
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
			tag:   string
			value: string
		}}} | null)
#AxisTypeEnum: {
	OASYS_DATA_AXISTYPE_ENUMS: 0
}
#AxisType: or(
		[

		for _, v in #AxisTypeEnum {
			v
		}])
#Axis: ({
	@dotnet({FullName:GsaAPI.Axis})
	Type:    #AxisType
	XYPlane: #Vector3
	XVector: #Vector3
	Origin:  #Vector3
	Name:    string
	Sid:     string
	TypeAsString?: {
		$id: "method"
		Out: string
	}
	Dispose?: {
		$id: "method"
	}
	SetSidTag?: {
		$id: "method"
		In: {
				tag:   string
				value: string
			}}} | null)
#Titles: ({
	@dotnet({FullName:GsaAPI.Titles})
	Notes:       string
	Calculation: string
	SubTitle:    string
	Title:       string
	Initials:    string
	JobNumber:   string
} | null)
#Model: ({
	@dotnet({FullName:GsaAPI.Model})
	Open?: {
		$id: "method"
		In: {
			fileName: string
		}
		Out: #ReturnValue
	}
	Save?: {
		$id: "method"
		Out: #ReturnValue
	}
	SaveAs?: {
		$id: "method"
		In: {
			fileName: string
		}
		Out: #ReturnValue
	}
	Close?: {
		$id: "method"
		Out: #ReturnValue
	}
	Titles?: {
		$id: "method"
		Out: #Titles
	}
	Axes?: {
		$id: "method"
		Out: [
			..._|_]}
	Nodes?: {
		$id: "method"
		In: {
			nodesList: string
		}
		Out: [
			..._|_]}
	Nodes?: {
		$id: "method"
		Out: [
			..._|_]}
	Elements?: {
		$id: "method"
		In: {
			elementsList: string
		}
		Out: [
			..._|_]}
	Elements?: {
		$id: "method"
		Out: [
			..._|_]}
	Members?: {
		$id: "method"
		In: {
			membersList: string
		}
		Out: [
			..._|_]}
	Members?: {
		$id: "method"
		Out: [
			..._|_]}
	Sections?: {
		$id: "method"
		Out: [
			..._|_]}
	Prop2Ds?: {
		$id: "method"
		Out: [
			..._|_]}
	GridPlanes?: {
		$id: "method"
		Out: [
			..._|_]}
	GridSurfaces?: {
		$id: "method"
		Out: [
			..._|_]}
	Results?: {
		$id: "method"
		Out: [
			..._|_]}
	AnalysisTasks?: {
		$id: "method"
		Out: [
			..._|_]}
	NodeLoads?: {
		$id: "method"
		In: {
			type: #NodeLoadType
		}
		Out: [
			...#NodeLoad]}
	BeamLoads?: {
		$id: "method"
		Out: [
			...#BeamLoad]}
	FaceLoads?: {
		$id: "method"
		Out: [
			...#FaceLoad]}
	GravityLoads?: {
		$id: "method"
		Out: [
			...#GravityLoad]}
	GridPointLoads?: {
		$id: "method"
		Out: [
			...#GridPointLoad]}
	GridLineLoads?: {
		$id: "method"
		Out: [
			...#GridLineLoad]}
	GridAreaLoads?: {
		$id: "method"
		Out: [
			...#GridAreaLoad]}
	AddNode?: {
		$id: "method"
		In: {
			node: #Node
		}
		Out: int32
	}
	AddNodes?: {
		$id: "method"
		In: {
			nodes: [
				...#Node]}}
	DeleteNode?: {
		$id: "method"
		In: {
			nodeID: int32
		}}
	DeleteNodes?: {
		$id: "method"
		In: {
			nodeIDs: [
				...int32]}}
	DeleteNodes?: {
		$id: "method"
		In: {
			nodesList: string
		}}
	SetNode?: {
		$id: "method"
		In: {
			nodeID: int32
			node:   #Node
		}}
	SetNodes?: {
		$id: "method"
		In: {
			nodes: [
				..._|_]}}
	AddElement?: {
		$id: "method"
		In: {
			element: #Element
		}
		Out: int32
	}
	AddElements?: {
		$id: "method"
		In: {
			elements: [
				...#Element]}}
	DeleteElement?: {
		$id: "method"
		In: {
			elementID: int32
		}}
	DeleteElements?: {
		$id: "method"
		In: {
			elementIDs: [
				...int32]}}
	DeleteElements?: {
		$id: "method"
		In: {
			elementsList: string
		}}
	SetElement?: {
		$id: "method"
		In: {
			elementID: int32
			element:   #Element
		}}
	SetElements?: {
		$id: "method"
		In: {
			elements: [
				..._|_]}}
	ElementLength?: {
		$id: "method"
		In: {
			elementID: int32
		}
		Out: float
	}
	ElementArea?: {
		$id: "method"
		In: {
			elementID: int32
		}
		Out: float
	}
	ElementVolume?: {
		$id: "method"
		In: {
			elementID: int32
		}
		Out: float
	}
	ElementDirectionCosine?: {
		$id: "method"
		In: {
			elementID: int32
		}
		Out: [
			...float]}
	AddMember?: {
		$id: "method"
		In: {
			member: #Member
		}
		Out: int32
	}
	AddMembers?: {
		$id: "method"
		In: {
			members: [
				...#Member]}}
	DeleteMember?: {
		$id: "method"
		In: {
			memberID: int32
		}}
	DeleteMembers?: {
		$id: "method"
		In: {
			memberIDs: [
				...int32]}}
	DeleteMembers?: {
		$id: "method"
		In: {
			membersList: string
		}}
	SetMember?: {
		$id: "method"
		In: {
			memberID: int32
			member:   #Member
		}}
	SetMembers?: {
		$id: "method"
		In: {
			members: [
				..._|_]}}
	MemberLength?: {
		$id: "method"
		In: {
			memberID: int32
		}
		Out: float
	}
	MemberArea?: {
		$id: "method"
		In: {
			memberID: int32
		}
		Out: float
	}
	MemberDirectionCosine?: {
		$id: "method"
		In: {
			memberID: int32
		}
		Out: [
			...float]}
	AddSection?: {
		$id: "method"
		In: {
			section: #Section
		}
		Out: int32
	}
	AddSections?: {
		$id: "method"
		In: {
			sections: [
				...#Section]}}
	DeleteSection?: {
		$id: "method"
		In: {
			sectionID: int32
		}}
	DeleteSections?: {
		$id: "method"
		In: {
			sectionIDs: [
				...int32]}}
	DeleteSections?: {
		$id: "method"
		In: {
			sectionID:        int32
			numberOfSections: int32
		}}
	SetSection?: {
		$id: "method"
		In: {
			sectionID: int32
			section:   #Section
		}}
	SetSections?: {
		$id: "method"
		In: {
			sections: [
				..._|_]}}
	AddAxis?: {
		$id: "method"
		In: {
			axis: #Axis
		}
		Out: int32
	}
	AddAxes?: {
		$id: "method"
		In: {
			axes: [
				...#Axis]}}
	DeleteAxis?: {
		$id: "method"
		In: {
			axisID: int32
		}}
	DeleteAxes?: {
		$id: "method"
		In: {
			axisIDs: [
				...int32]}}
	DeleteAxes?: {
		$id: "method"
		In: {
			axisID:       int32
			numberOfAxes: int32
		}}
	SetAxis?: {
		$id: "method"
		In: {
			axisID: int32
			axis:   #Axis
		}}
	SetAxes?: {
		$id: "method"
		In: {
			axes: [
				..._|_]}}
	AddProp2D?: {
		$id: "method"
		In: {
			prop2D: #Prop2D
		}
		Out: int32
	}
	AddProp2Ds?: {
		$id: "method"
		In: {
			prop2Ds: [
				...#Prop2D]}}
	DeleteProp2D?: {
		$id: "method"
		In: {
			prop2DID: int32
		}}
	DeleteProp2Ds?: {
		$id: "method"
		In: {
			prop2DIDs: [
				...int32]}}
	DeleteProp2Ds?: {
		$id: "method"
		In: {
			prop2DID:        int32
			numberOfProp2Ds: int32
		}}
	SetProp2D?: {
		$id: "method"
		In: {
			prop2DID: int32
			prop2D:   #Prop2D
		}}
	SetProp2Ds?: {
		$id: "method"
		In: {
			prop2Ds: [
				..._|_]}}
	AddGridPlane?: {
		$id: "method"
		In: {
			gridPlane: #GridPlane
		}
		Out: int32
	}
	AddGridPlanes?: {
		$id: "method"
		In: {
			gridPlanes: [
				...#GridPlane]}}
	DeleteGridPlane?: {
		$id: "method"
		In: {
			gridPlaneID: int32
		}}
	DeleteGridPlanes?: {
		$id: "method"
		In: {
			gridPlaneIDs: [
				...int32]}}
	DeleteGridPlanes?: {
		$id: "method"
		In: {
			gridPlaneID:        int32
			numberOfGridPlanes: int32
		}}
	SetGridPlane?: {
		$id: "method"
		In: {
			gridPlaneID: int32
			gridPlane:   #GridPlane
		}}
	SetGridPlanes?: {
		$id: "method"
		In: {
			gridPlanes: [
				..._|_]}}
	AddGridSurface?: {
		$id: "method"
		In: {
			gridSurface: #GridSurface
		}
		Out: int32
	}
	AddGridSurfaces?: {
		$id: "method"
		In: {
			gridSurfaces: [
				...#GridSurface]}}
	DeleteGridSurface?: {
		$id: "method"
		In: {
			gridSurfaceID: int32
		}}
	DeleteGridSurfaces?: {
		$id: "method"
		In: {
			gridSurfaceIDs: [
				...int32]}}
	DeleteGridSurfaces?: {
		$id: "method"
		In: {
			gridSurfaceID:        int32
			numberOfGridSurfaces: int32
		}}
	SetGridSurface?: {
		$id: "method"
		In: {
			gridSurfaceID: int32
			gridSurface:   #GridSurface
		}}
	SetGridSurfaces?: {
		$id: "method"
		In: {
			gridSurfaces: [
				..._|_]}}
	AddBeamLoad?: {
		$id: "method"
		In: {
			beamLoad: #BeamLoad
		}
		Out: int32
	}
	AddBeamLoads?: {
		$id: "method"
		In: {
			beamLoads: [
				...#BeamLoad]}}
	DeleteBeamLoad?: {
		$id: "method"
		In: {
			beamLoadID: int32
		}}
	DeleteBeamLoads?: {
		$id: "method"
		In: {
			beamLoadID:        int32
			numberOfBeamLoads: int32
		}}
	SetBeamLoad?: {
		$id: "method"
		In: {
			beamLoadID: int32
			beamLoad:   #BeamLoad
		}}
	AddFaceLoad?: {
		$id: "method"
		In: {
			faceLoad: #FaceLoad
		}
		Out: int32
	}
	AddFaceLoads?: {
		$id: "method"
		In: {
			faceLoads: [
				...#FaceLoad]}}
	DeleteFaceLoad?: {
		$id: "method"
		In: {
			faceLoadID: int32
		}}
	DeleteFaceLoads?: {
		$id: "method"
		In: {
			faceLoadID:        int32
			numberOfFaceLoads: int32
		}}
	SetFaceLoad?: {
		$id: "method"
		In: {
			faceLoadID: int32
			faceLoad:   #FaceLoad
		}}
	AddGravityLoad?: {
		$id: "method"
		In: {
			gravityLoad: #GravityLoad
		}
		Out: int32
	}
	AddGravityLoads?: {
		$id: "method"
		In: {
			gravityLoads: [
				...#GravityLoad]}}
	DeleteGravityLoad?: {
		$id: "method"
		In: {
			gravityLoadID: int32
		}}
	DeleteGravityLoads?: {
		$id: "method"
		In: {
			gravityLoadID:        int32
			numberOfGravityLoads: int32
		}}
	SetGravityLoad?: {
		$id: "method"
		In: {
			gravityLoadID: int32
			gravityLoad:   #GravityLoad
		}}
	AddNodeLoad?: {
		$id: "method"
		In: {
			type:     #NodeLoadType
			nodeLoad: #NodeLoad
		}
		Out: int32
	}
	AddNodeLoads?: {
		$id: "method"
		In: {
			type: #NodeLoadType
			nodeLoads: [
				...#NodeLoad]}}
	DeleteNodeLoad?: {
		$id: "method"
		In: {
			type:       #NodeLoadType
			nodeLoadID: int32
		}}
	DeleteNodeLoads?: {
		$id: "method"
		In: {
			type:              #NodeLoadType
			nodeLoadID:        int32
			numberOfNodeLoads: int32
		}}
	SetNodeLoad?: {
		$id: "method"
		In: {
			type:       #NodeLoadType
			nodeLoadID: int32
			nodeLoad:   #NodeLoad
		}}
	AddGridPointLoad?: {
		$id: "method"
		In: {
			gridPointLoad: #GridPointLoad
		}
		Out: int32
	}
	AddGridPointLoads?: {
		$id: "method"
		In: {
			gridPointLoads: [
				...#GridPointLoad]}}
	DeleteGridPointLoad?: {
		$id: "method"
		In: {
			gridPointLoadID: int32
		}}
	DeleteGridPointLoads?: {
		$id: "method"
		In: {
			gridPointLoadID:        int32
			numberOfGridPointLoads: int32
		}}
	SetGridPointLoad?: {
		$id: "method"
		In: {
			gridPointLoadID: int32
			gridPointLoad:   #GridPointLoad
		}}
	AddGridLineLoad?: {
		$id: "method"
		In: {
			gridLineLoad: #GridLineLoad
		}
		Out: int32
	}
	AddGridLineLoads?: {
		$id: "method"
		In: {
			gridLineLoads: [
				...#GridLineLoad]}}
	DeleteGridLineLoad?: {
		$id: "method"
		In: {
			gridLineLoadID: int32
		}}
	DeleteGridLineLoads?: {
		$id: "method"
		In: {
			gridLineLoadID:        int32
			numberOfGridLineLoads: int32
		}}
	SetGridLineLoad?: {
		$id: "method"
		In: {
			gridLineLoadID: int32
			gridLineLoad:   #GridLineLoad
		}}
	AddGridAreaLoad?: {
		$id: "method"
		In: {
			gridAreaLoad: #GridAreaLoad
		}
		Out: int32
	}
	AddGridAreaLoads?: {
		$id: "method"
		In: {
			gridAreaLoads: [
				...#GridAreaLoad]}}
	DeleteGridAreaLoad?: {
		$id: "method"
		In: {
			gridAreaLoadID: int32
		}}
	DeleteGridAreaLoads?: {
		$id: "method"
		In: {
			gridAreaLoadID:        int32
			numberOfGridAreaLoads: int32
		}}
	SetGridAreaLoad?: {
		$id: "method"
		In: {
			gridAreaLoadID: int32
			gridAreaLoad:   #GridAreaLoad
		}}
	CreateElementsFromMembers?: {
		$id: "method"
	}
	Analyse?: {
		$id: "method"
		In: {
			taskID: int32
		}
		Out: bool
	}
	DeleteResults?: {
		$id: "method"
		In: {
			taskID: int32
		}
		Out: bool
	}
	AnalysisCaseDescription?: {
		$id: "method"
		In: {
			analysisCaseID: int32
		}
		Out: string
	}
	AnalysisCaseName?: {
		$id: "method"
		In: {
			analysisCaseID: int32
		}
		Out: string
	}
	SetAnalysisCaseDescription?: {
		$id: "method"
		In: {
			analysisCaseID: int32
			description:    string
		}
		Out: bool
	}
	AddAnalysisCaseToTask?: {
		$id: "method"
		In: {
			analysisTaskID: int32
			name:           string
			description:    string
		}
		Out: #ReturnValue
	}
	DeleteAnalysisCaseFromTask?: {
		$id: "method"
		In: {
			analysisTaskID: int32
			analyisCaseID:  int32
		}
		Out: #ReturnValue
	}
	Dispose?: {
		$id: "method"
	}} | null)
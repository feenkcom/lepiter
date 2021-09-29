Class {
	#name : 'LeAnnotationParser',
	#superclass : 'SmaCCGLRParser',
	#category : 'Lepiter-Parser'
}

{ #category : 'generated-accessing' }
LeAnnotationParser class >> cacheId [
	^'2020-11-12T14:07:29.400364-06:00'
]

{ #category : 'instance creation' }
LeAnnotationParser class >> createParserOnStream: aStream startingAt: anInteger [
	| parser |
	parser := super createParserOnStream: aStream startingAt: anInteger.
	(anInteger = self startingStateForChangesAnnotation
		or: [ anInteger = self startingStateForPageAnnotation ])
		ifTrue: [ parser scope: #path ].
	^ parser
]

{ #category : 'generated' }
LeAnnotationParser class >> definitionComment [
"%glr;
%prefix Le;
%root AnnotationParse;
%suffix Node;

%hierarchy Argument (
	AlignmentArgument
	CodeExpandedArgument
	DbArgument
	ExpandedArgument
	FullArgument
	HeightArgument
	LabelArgument
	NameArgument
	NoCodeArgument
	PageArgument
	PreviewExpandedArgument
	PreviewHeightArgument
	PreviewShowArgument
	ReturnArgument
	ShowArgument
);
%hierarchy NameArgument (FileNameArgument ClassNameArgument);
%hierarchy ClassNameArgument (MethodNameArgument);

%hierarchy Annotation (
	ClassAnnotation
	ExampleAnnotation
	MethodAnnotation
	ChangesAnnotation
	PageAnnotation
);

%excludes label path uuid;

%start ClassAnnotation ExampleAnnotation MethodAnnotation ChangesAnnotation PageAnnotation;

<className>
	: <isUppercase> ( <isLetter> | _ | <isDigit> ) *
	;
<unarySelector>
	: (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;
<binarySelector>
	: ([\~\-\!\@\%\&\*\+\=\?\/\>\<\,] |(\\ [\~\-\!\@\%\&\*\+\=\\\|\?\/\>\<\,])) +
	;
<keywordSelector>
	: (<unarySelector> \:)+
	;
default path <selector>
	: \#? <unarySelector>
	| \#? <binarySelector>
	| \#? <keywordSelector>
	;
default path <integer>
	: \d+
	;
label <labelText>
	: ([^\|\}\\] | (\\ .))* \\?
	;
<whitespace>
	: \s+
	;
<name>
	: name
	;
default path <eq>
	: \=
	;
default path <label>
	: label
	;
<full>
	: full
	;
default path <expanded>
	: expanded
	;
default path <boolean>
	: true 
	| false
	;
default path <show>
	: show
	;
default path <height>
	: height
	;
default path <bar>
	: \|
	;
<return>
	: return
	;
<alignment>
	: alignment
	;
<previewShow>
	: previewShow
	;
<previewExpanded>
	: previewExpanded
	;
<previewHeight>
	: previewHeight
	;
<noCode>
	: noCode
	;
<gtgt>
	: \>\>
	;
<codeExpanded>
	: codeExpanded
	;
<documentWidth>
	: documentWidth
	;
<fullWidth>
	: fullWidth
	;
<paragraphWidth>
	: paragraphWidth
	;
<class>
	: class
	;
path <path>
	: [^\|\}\=]+
	;
path default <db>
	: db
	;
uuid <uuid>
	: [0-9a-z]{1,25}
	;
ClassAnnotation 
	: ClassAnnotationItems {{}}
	;
ClassAnnotationItems
	: ClassAnnotationItems <bar> 'separator' ClassAnnotationItem 'item'
	| ClassAnnotationItem 'item'
	;
ClassAnnotationItem
	: ClassName
	| Label
	| Full
	| Expanded
	| Show
	| Height
	;
Height
	: <height> 'name' <eq> 'equals' <integer> 'value' {{HeightArgument}}
	;
Show
	: <show> 'name' <eq> 'equals' <selector> 'value' {{ShowArgument}}
	;
Expanded
	: <expanded> 'name' OptionalBooleanValue {{ExpandedArgument}}
	;
Full
	: <full> 'name' OptionalBooleanValue {{FullArgument}}
	;
Label
	: <label> 'name' SwitchToLabel <eq> 'equals' SwitchToDefault <labelText> 'value' {{LabelArgument}}
	;
SwitchToDefault
	: [self scope: #default. nil]
	;
SwitchToLabel
	: [self scope: #label. nil]
	;
ClassName
	: <name> 'name' <eq> 'equals' <className> 'value' <class> 'classToken'? {{ClassNameArgument}}
	| <className> 'value' <class> 'classToken'? {{ClassNameArgument}}
	;
ExampleAnnotation
	: ExampleAnnotationItems {{}}
	;
ExampleAnnotationItems
	: ExampleAnnotationItems <bar> 'separator' ExampleAnnotationItem 'item'
	| ExampleAnnotationItem 'item'
	;
ExampleAnnotationItem
	: MethodName
	| Expanded
	| Label
	| CodeExpanded
	| NoCode
	| PreviewHeight
	| PreviewExpanded
	| PreviewShow
	| Alignment
	| Return
	;
Return
	: <return> 'name' <eq> 'equals' <unarySelector> 'value' {{ReturnArgument}}
	;
Alignment
	: <alignment> 'name' <eq> 'equals' (<documentWidth> 'value' | <fullWidth> 'value' | <paragraphWidth> 'value') {{AlignmentArgument}}
	;
PreviewShow
	: <previewShow> 'name' <eq> 'equals' <selector> 'value' {{PreviewShowArgument}}
	;
PreviewExpanded
	: <previewExpanded> 'name' OptionalBooleanValue {{PreviewExpandedArgument}}
	;
OptionalBooleanValue
	: (<eq> 'equals' <boolean> 'value'?)?
	;
PreviewHeight
	: <previewHeight> 'name' <eq> 'equals' <integer> 'value' {{PreviewHeightArgument}}
	;
NoCode
	: <noCode> 'name' OptionalBooleanValue {{NoCodeArgument}}
	;
CodeExpanded
	: <codeExpanded> 'name' OptionalBooleanValue {{CodeExpandedArgument}}
	;
MethodAnnotation
	: MethodAnnotationItems {{}}
	;
MethodAnnotationItems
	: MethodAnnotationItems <bar> 'separator' MethodAnnotationItem 'item'
	| MethodAnnotationItem 'item'
	;
MethodAnnotationItem
	: MethodName
	| Label
	| Expanded
	| Show
	| Height
	;
MethodName
	: (<name> 'name' <eq> 'equals')? <className> 'value' <class> 'classToken'? <gtgt> 'gtGt' <selector> 'selector' {{MethodNameArgument}}
	;
ChangesAnnotation
	: ChangesAnnotationItems {{}}
	;
ChangesAnnotationItems
	: ChangesAnnotationItems <bar> 'separator' ChangesAnnotationItem 'item'
	| ChangesAnnotationItem 'item'
	;
ChangesAnnotationItem
	: Expanded
	| Show
	| Height
	| Path
	;
Path
	: (<name> 'name' <eq> 'equals')? <path> 'value' {{FileNameArgument}}
	;
PageAnnotation
	: PageAnnotationItems {{}}
	;
PageAnnotationItems
	: PageAnnotationItems <bar> 'separator' PageAnnotationItem 'item'
	| PageAnnotationItem 'item' 
	;
PageAnnotationItem
	: PageLabel
	| Db
	;
Db
	: <db> 'name' SwitchToUuid <eq> 'equals' SwitchToPath <uuid> 'value' {{DbArgument}}
	;
SwitchToUuid
	: [self scope: #uuid. nil]
	;
SwitchToPath
	: [self scope: #path. nil]
	;
PageLabel
	: <path> 'value' {{PageArgument}}
	| <label> 'name' <eq> 'equals' <path> 'value' {{PageArgument}}
	;"
]

{ #category : 'generated' }
LeAnnotationParser class >> reduceTable [
^#(
	#(42 1 #reduceActionForClassName3: 2713603 false ) 
	#(41 0 #reduceActionForSwitchToLabel1: 2666497 true ) 
	#(50 0 #reduceActionForOptionalBooleanValue1: 3678209 false ) 
	#(32 1 #reduceActionForClassAnnotation1: 1942529 false ) 
	#(33 1 #reduceActionForClassAnnotationItems2: 1992706 false ) 
	#(34 1 #liftFirstValue: 2118662 false ) 
	#(34 1 #liftFirstValue: 2118661 false ) 
	#(34 1 #liftFirstValue: 2118660 false ) 
	#(34 1 #liftFirstValue: 2118659 false ) 
	#(34 1 #liftFirstValue: 2118658 false ) 
	#(34 1 #liftFirstValue: 2118657 false ) 
	#(45 1 #liftFirstValue: 3080194 false ) 
	#(45 1 #liftFirstValue: 3080195 false ) 
	#(43 1 #reduceActionForExampleAnnotation1: 2892801 false ) 
	#(44 1 #reduceActionForClassAnnotationItems2: 2946050 false ) 
	#(45 1 #liftFirstValue: 3080202 false ) 
	#(45 1 #liftFirstValue: 3080201 false ) 
	#(45 1 #liftFirstValue: 3080200 false ) 
	#(45 1 #liftFirstValue: 3080199 false ) 
	#(45 1 #liftFirstValue: 3080198 false ) 
	#(45 1 #liftFirstValue: 3080197 false ) 
	#(45 1 #liftFirstValue: 3080196 false ) 
	#(45 1 #liftFirstValue: 3080193 false ) 
	#(56 1 #liftFirstValue: 4187141 false ) 
	#(56 1 #liftFirstValue: 4187140 false ) 
	#(56 1 #liftFirstValue: 4187139 false ) 
	#(56 1 #liftFirstValue: 4187138 false ) 
	#(54 1 #reduceActionForMethodAnnotation1: 4005889 false ) 
	#(55 1 #reduceActionForClassAnnotationItems2: 4057090 false ) 
	#(56 1 #liftFirstValue: 4187137 false ) 
	#(61 1 #reduceActionForPath1: 4670465 false ) 
	#(60 1 #liftFirstValue: 4605955 false ) 
	#(60 1 #liftFirstValue: 4605954 false ) 
	#(60 1 #liftFirstValue: 4605953 false ) 
	#(58 1 #reduceActionForChangesAnnotation1: 4418561 false ) 
	#(59 1 #reduceActionForClassAnnotationItems2: 4471810 false ) 
	#(60 1 #liftFirstValue: 4605956 false ) 
	#(68 1 #reduceActionForPageLabel1: 5145601 false ) 
	#(66 0 #reduceActionForSwitchToUuid1: 5055489 true ) 
	#(62 1 #reduceActionForPageAnnotation1: 4750337 false ) 
	#(63 1 #reduceActionForClassAnnotationItems2: 4797442 false ) 
	#(64 1 #liftFirstValue: 4920322 false ) 
	#(64 1 #liftFirstValue: 4920321 false ) 
	#(42 2 #reduceActionForClassName4: 2713604 false ) 
	#(50 1 #reduceActionForOptionalBooleanValue2: 3678210 false ) 
	#(38 2 #reduceActionForFull1: 2439169 false ) 
	#(37 2 #reduceActionForExpanded1: 2362369 false ) 
	#(49 2 #reduceActionForPreviewExpanded1: 3579905 false ) 
	#(52 2 #reduceActionForNoCode1: 3846145 false ) 
	#(53 2 #reduceActionForCodeExpanded1: 3916801 false ) 
	#(42 3 #reduceActionForClassName1: 2713601 false ) 
	#(40 0 #reduceActionForSwitchToDefault1: 2615297 true ) 
	#(50 2 #reduceActionForOptionalBooleanValue3: 3678211 false ) 
	#(36 3 #reduceActionForShow1: 2285569 false ) 
	#(35 3 #reduceActionForHeight1: 2203649 false ) 
	#(33 3 #reduceActionForClassAnnotationItems1: 1992705 false ) 
	#(57 3 #reduceActionForMethodName1: 4265985 false ) 
	#(46 3 #reduceActionForReturn1: 3244033 false ) 
	#(47 3 #reduceActionForAlignment1: 3332097 false ) 
	#(47 3 #reduceActionForAlignment1: 3332098 false ) 
	#(47 3 #reduceActionForAlignment1: 3332099 false ) 
	#(48 3 #reduceActionForPreviewShow1: 3481601 false ) 
	#(51 3 #reduceActionForPreviewHeight1: 3742721 false ) 
	#(44 3 #reduceActionForClassAnnotationItems1: 2946049 false ) 
	#(55 3 #reduceActionForClassAnnotationItems1: 4057089 false ) 
	#(61 3 #reduceActionForPath2: 4670466 false ) 
	#(59 3 #reduceActionForClassAnnotationItems1: 4471809 false ) 
	#(68 3 #reduceActionForPageLabel2: 5145602 false ) 
	#(67 0 #reduceActionForSwitchToPath1: 5100545 true ) 
	#(63 3 #reduceActionForClassAnnotationItems1: 4797441 false ) 
	#(42 4 #reduceActionForClassName2: 2713602 false ) 
	#(57 4 #reduceActionForMethodName2: 4265986 false ) 
	#(39 5 #reduceActionForLabel1: 2503681 false ) 
	#(57 5 #reduceActionForMethodName3: 4265987 false ) 
	#(65 5 #reduceActionForDb1: 4962305 false ) 
	#(57 6 #reduceActionForMethodName4: 4265988 false )
	).
]

{ #category : 'generated' }
LeAnnotationParser class >> scannerClass [
	^LeAnnotationScanner
]

{ #category : 'generated' }
LeAnnotationParser class >> startingStateForChangesAnnotation [
	^ 4
]

{ #category : 'generated' }
LeAnnotationParser class >> startingStateForClassAnnotation [
	^ 1
]

{ #category : 'generated' }
LeAnnotationParser class >> startingStateForExampleAnnotation [
	^ 2
]

{ #category : 'generated' }
LeAnnotationParser class >> startingStateForMethodAnnotation [
	^ 3
]

{ #category : 'generated' }
LeAnnotationParser class >> startingStateForPageAnnotation [
	^ 5
]

{ #category : 'generated' }
LeAnnotationParser class >> symbolNames [
	^ #('<className>' '<unarySelector>' '<selector>' '<integer>' '<labelText>' '<whitespace>' '<name>' '<eq>' '<label>' '<full>' '<expanded>' '<boolean>' '<show>' '<height>' '<bar>' '<return>' '<alignment>' '<previewShow>' '<previewExpanded>' '<previewHeight>' '<noCode>' '<gtgt>' '<codeExpanded>' '<documentWidth>' '<fullWidth>' '<paragraphWidth>' '<class>' '<path>' '<db>' '<uuid>' 'B e g i n' 'ClassAnnotation' 'ClassAnnotationItems' 'ClassAnnotationItem' 'Height' 'Show' 'Expanded' 'Full' 'Label' 'SwitchToDefault' 'SwitchToLabel' 'ClassName' 'ExampleAnnotation' 'ExampleAnnotationItems' 'ExampleAnnotationItem' 'Return' 'Alignment' 'PreviewShow' 'PreviewExpanded' 'OptionalBooleanValue' 'PreviewHeight' 'NoCode' 'CodeExpanded' 'MethodAnnotation' 'MethodAnnotationItems' 'MethodAnnotationItem' 'MethodName' 'ChangesAnnotation' 'ChangesAnnotationItems' 'ChangesAnnotationItem' 'Path' 'PageAnnotation' 'PageAnnotationItems' 'PageAnnotationItem' 'Db' 'SwitchToUuid' 'SwitchToPath' 'PageLabel' 'E O F' 'error')
]

{ #category : 'generated' }
LeAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeClassAnnotationNode #LeClassAnnotationNode #OrderedCollection #LeArgumentNode #LeHeightArgumentNode #LeShowArgumentNode #LeExpandedArgumentNode #LeFullArgumentNode #LeLabelArgumentNode nil nil #LeClassNameArgumentNode #LeExampleAnnotationNode #OrderedCollection #LeArgumentNode #LeReturnArgumentNode #LeAlignmentArgumentNode #LePreviewShowArgumentNode #LePreviewExpandedArgumentNode #OrderedCollection #LePreviewHeightArgumentNode #LeNoCodeArgumentNode #LeCodeExpandedArgumentNode #LeMethodAnnotationNode #OrderedCollection #LeArgumentNode #LeMethodNameArgumentNode #LeChangesAnnotationNode #OrderedCollection #LeArgumentNode #LeFileNameArgumentNode #LePageAnnotationNode #OrderedCollection #LeArgumentNode #LeDbArgumentNode nil nil #LePageArgumentNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : 'generated' }
LeAnnotationParser class >> transitionTable [
^#(
#[1 0 25 0 1 0 29 0 7 0 33 0 9 0 37 0 10 0 41 0 11 0 45 0 13 0 49 0 14 0 53 0 32 0 57 0 33 0 61 0 34 0 61 0 35 0 61 0 36 0 61 0 37 0 61 0 38 0 61 0 39 0 61 0 42] 
#[1 0 89 0 1 0 93 0 7 0 33 0 9 0 41 0 11 0 97 0 16 0 101 0 17 0 105 0 18 0 109 0 19 0 113 0 20 0 117 0 21 0 121 0 23 0 141 0 37 0 141 0 39 0 133 0 43 0 137 0 44 0 141 0 45 0 141 0 46 0 141 0 47 0 141 0 48 0 141 0 49 0 141 0 51 0 141 0 52 0 141 0 53 0 141 0 57] 
#[1 0 89 0 1 0 93 0 7 0 33 0 9 0 41 0 11 0 45 0 13 0 49 0 14 0 201 0 35 0 201 0 36 0 201 0 37 0 201 0 39 0 193 0 54 0 197 0 55 0 201 0 56 0 201 0 57] 
#[1 0 209 0 7 0 41 0 11 0 45 0 13 0 49 0 14 0 213 0 28 0 237 0 35 0 237 0 36 0 237 0 37 0 229 0 58 0 233 0 59 0 237 0 60 0 237 0 61] 
#[1 0 245 0 9 0 249 0 28 0 253 0 29 1 1 0 62 1 5 0 63 1 9 0 64 1 9 0 65 1 9 0 68] 
#[1 0 6 0 15 1 21 0 27 0 6 0 69] 
#[0 1 25 0 8] 
#[1 0 10 0 8 1 29 0 41] 
#[1 1 33 0 8 0 14 0 15 1 37 0 50 0 14 0 69] 
#[1 1 33 0 8 0 14 0 15 1 41 0 50 0 14 0 69] 
#[0 1 45 0 8] 
#[0 1 49 0 8] 
#[0 0 0 0 69] 
#[1 1 53 0 15 0 18 0 69] 
#[0 0 22 0 15 0 69] 
#[0 0 26 0 15 0 69] 
#[0 0 30 0 15 0 69] 
#[0 0 34 0 15 0 69] 
#[0 0 38 0 15 0 69] 
#[0 0 42 0 15 0 69] 
#[0 0 46 0 15 0 69] 
#[1 1 57 0 22 1 61 0 27] 
#[0 1 65 0 8] 
#[0 1 69 0 8] 
#[0 1 73 0 8] 
#[0 1 77 0 8] 
#[1 1 33 0 8 0 14 0 15 1 81 0 50 0 14 0 69] 
#[0 1 85 0 8] 
#[1 1 33 0 8 0 14 0 15 1 89 0 50 0 14 0 69] 
#[1 1 33 0 8 0 14 0 15 1 93 0 50 0 14 0 69] 
#[0 0 50 0 15 0 69] 
#[0 0 54 0 15 0 69] 
#[0 0 0 0 69] 
#[1 1 97 0 15 0 58 0 69] 
#[0 0 62 0 15 0 69] 
#[0 0 66 0 15 0 69] 
#[0 0 70 0 15 0 69] 
#[0 0 74 0 15 0 69] 
#[0 0 78 0 15 0 69] 
#[0 0 82 0 15 0 69] 
#[0 0 86 0 15 0 69] 
#[0 0 90 0 15 0 69] 
#[0 0 94 0 15 0 69] 
#[0 0 98 0 15 0 69] 
#[0 0 102 0 15 0 69] 
#[0 0 106 0 15 0 69] 
#[0 0 110 0 15 0 69] 
#[0 0 0 0 69] 
#[1 1 101 0 15 0 114 0 69] 
#[0 0 118 0 15 0 69] 
#[0 0 122 0 15 0 69] 
#[0 1 105 0 8] 
#[0 0 126 0 15 0 69] 
#[0 0 130 0 15 0 69] 
#[0 0 134 0 15 0 69] 
#[0 0 138 0 15 0 69] 
#[0 0 0 0 69] 
#[1 1 109 0 15 0 142 0 69] 
#[0 0 146 0 15 0 69] 
#[0 0 150 0 15 0 69] 
#[0 1 113 0 8] 
#[0 0 154 0 15 0 69] 
#[1 0 158 0 8 1 117 0 66] 
#[0 0 0 0 69] 
#[1 1 121 0 15 0 162 0 69] 
#[0 0 166 0 15 0 69] 
#[0 0 170 0 15 0 69] 
#[0 0 174 0 15 0 69] 
#[0 0 178 0 15 0 69] 
#[0 1 125 0 1] 
#[0 1 129 0 8] 
#[1 1 133 0 12 0 182 0 15 0 182 0 69] 
#[0 0 186 0 15 0 69] 
#[0 0 190 0 15 0 69] 
#[0 1 137 0 3] 
#[0 1 141 0 4] 
#[1 0 25 0 1 0 29 0 7 0 33 0 9 0 37 0 10 0 41 0 11 0 45 0 13 0 49 0 14 1 145 0 34 1 145 0 35 1 145 0 36 1 145 0 37 1 145 0 38 1 145 0 39 1 145 0 42] 
#[0 1 149 0 3] 
#[0 1 153 0 22] 
#[0 1 157 0 1] 
#[0 1 161 0 2] 
#[1 1 165 0 24 1 169 0 25 1 173 0 26] 
#[0 1 177 0 3] 
#[0 0 194 0 15 0 69] 
#[0 1 181 0 4] 
#[0 0 198 0 15 0 69] 
#[0 0 202 0 15 0 69] 
#[1 0 89 0 1 0 93 0 7 0 33 0 9 0 41 0 11 0 97 0 16 0 101 0 17 0 105 0 18 0 109 0 19 0 113 0 20 0 117 0 21 0 121 0 23 1 185 0 37 1 185 0 39 1 185 0 45 1 185 0 46 1 185 0 47 1 185 0 48 1 185 0 49 1 185 0 51 1 185 0 52 1 185 0 53 1 185 0 57] 
#[1 0 89 0 1 0 93 0 7 0 33 0 9 0 41 0 11 0 45 0 13 0 49 0 14 1 189 0 35 1 189 0 36 1 189 0 37 1 189 0 39 1 189 0 56 1 189 0 57] 
#[0 1 193 0 28] 
#[1 0 209 0 7 0 41 0 11 0 45 0 13 0 49 0 14 0 213 0 28 1 197 0 35 1 197 0 36 1 197 0 37 1 197 0 60 1 197 0 61] 
#[0 1 201 0 28] 
#[0 1 205 0 8] 
#[1 0 245 0 9 0 249 0 28 0 253 0 29 1 209 0 64 1 209 0 65 1 209 0 68] 
#[1 0 206 0 15 1 213 0 27 0 206 0 69] 
#[1 0 210 0 5 1 217 0 40] 
#[0 0 214 0 15 0 69] 
#[0 0 218 0 15 0 69] 
#[0 0 222 0 15 0 69] 
#[0 0 226 0 15 0 69] 
#[0 0 230 0 15 0 69] 
#[0 1 221 0 3] 
#[1 1 225 0 22 1 229 0 27] 
#[0 0 234 0 15 0 69] 
#[0 0 238 0 15 0 69] 
#[0 0 242 0 15 0 69] 
#[0 0 246 0 15 0 69] 
#[0 0 250 0 15 0 69] 
#[0 0 254 0 15 0 69] 
#[0 1 2 0 15 0 69] 
#[0 1 6 0 15 0 69] 
#[0 1 10 0 15 0 69] 
#[0 1 14 0 15 0 69] 
#[0 1 18 0 15 0 69] 
#[1 1 22 0 30 1 233 0 67] 
#[0 1 26 0 15 0 69] 
#[0 1 30 0 15 0 69] 
#[0 1 237 0 5] 
#[0 1 34 0 15 0 69] 
#[0 1 241 0 3] 
#[0 1 245 0 22] 
#[0 1 249 0 30] 
#[0 1 38 0 15 0 69] 
#[0 1 42 0 15 0 69] 
#[0 1 253 0 3] 
#[0 1 46 0 15 0 69] 
#[0 1 50 0 15 0 69]
	).
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForAlignment1: nodes [
	| result |
	result := LeAlignmentArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForChangesAnnotation1: nodes [
	| result |
	result := LeChangesAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassAnnotation1: nodes [
	| result |
	result := LeClassAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassAnnotationItems1: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 1).
	self add: (nodes at: 3) to: (result at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassAnnotationItems2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassName1: nodes [
	| result |
	result := LeClassNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassName2: nodes [
	| result |
	result := LeClassNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	result classToken: (nodes at: 4).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassName3: nodes [
	| result |
	result := LeClassNameArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassName4: nodes [
	| result |
	result := LeClassNameArgumentNode new.
	result value: (nodes at: 1).
	result classToken: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForCodeExpanded1: nodes [
	| result |
	result := LeCodeExpandedArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForDb1: nodes [
	| result |
	result := LeDbArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 3).
	result value: (nodes at: 5).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForExampleAnnotation1: nodes [
	| result |
	result := LeExampleAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForExpanded1: nodes [
	| result |
	result := LeExpandedArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForFull1: nodes [
	| result |
	result := LeFullArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForHeight1: nodes [
	| result |
	result := LeHeightArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForLabel1: nodes [
	| result |
	result := LeLabelArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 3).
	result value: (nodes at: 5).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForMethodAnnotation1: nodes [
	| result |
	result := LeMethodAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForMethodName1: nodes [
	| result |
	result := LeMethodNameArgumentNode new.
	result value: (nodes at: 1).
	result gtGt: (nodes at: 2).
	result selector: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForMethodName2: nodes [
	| result |
	result := LeMethodNameArgumentNode new.
	result value: (nodes at: 1).
	result classToken: (nodes at: 2).
	result gtGt: (nodes at: 3).
	result selector: (nodes at: 4).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForMethodName3: nodes [
	| result |
	result := LeMethodNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	result gtGt: (nodes at: 4).
	result selector: (nodes at: 5).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForMethodName4: nodes [
	| result |
	result := LeMethodNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	result classToken: (nodes at: 4).
	result gtGt: (nodes at: 5).
	result selector: (nodes at: 6).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForNoCode1: nodes [
	| result |
	result := LeNoCodeArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForOptionalBooleanValue1: nodes [
	| result |
	result := Array new: 2.
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForOptionalBooleanValue2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForOptionalBooleanValue3: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPageAnnotation1: nodes [
	| result |
	result := LePageAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPageLabel1: nodes [
	| result |
	result := LePageArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPageLabel2: nodes [
	| result |
	result := LePageArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPath1: nodes [
	| result |
	result := LeFileNameArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPath2: nodes [
	| result |
	result := LeFileNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPreviewExpanded1: nodes [
	| result |
	result := LePreviewExpandedArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPreviewHeight1: nodes [
	| result |
	result := LePreviewHeightArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPreviewShow1: nodes [
	| result |
	result := LePreviewShowArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForReturn1: nodes [
	| result |
	result := LeReturnArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForShow1: nodes [
	| result |
	result := LeShowArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForSwitchToDefault1: nodes [
	self scope: #default.
	^ nil
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForSwitchToLabel1: nodes [
	self scope: #label.
	^ nil
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForSwitchToPath1: nodes [
	self scope: #path.
	^ nil
]

{ #category : 'generated-reduction actions' }
LeAnnotationParser >> reduceActionForSwitchToUuid1: nodes [
	self scope: #uuid.
	^ nil
]

{ #category : 'testing' }
LeAnnotationParser >> tryAllTokens [
	^ true
]

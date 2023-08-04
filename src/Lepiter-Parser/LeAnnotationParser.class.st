Class {
	#name : #LeAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Parser'
}

{ #category : #'generated-accessing' }
LeAnnotationParser class >> cacheId [
	^'2023-08-04T09:44:29.302587-04:00'
]

{ #category : #'instance creation' }
LeAnnotationParser class >> createParserOnStream: aStream startingAt: anInteger [
	| parser |
	parser := super createParserOnStream: aStream startingAt: anInteger.
	(anInteger = self startingStateForChangesAnnotation
		or: [ anInteger = self startingStateForPageAnnotation ])
		ifTrue: [ parser scope: #path ].
	^ parser
]

{ #category : #generated }
LeAnnotationParser class >> definitionComment [
"%glr;
%prefix Le;
%root AnnotationParse;
%suffix Node;

%hierarchy Argument (
	AlignmentArgument
	CodeExpandedArgument
	DateArgument
	DbArgument
	ExpandedArgument
	FullArgument
	HeightArgument
	IdArgument
	LabelArgument
	NameArgument
	NoCodeArgument
	PreviewExpandedArgument
	PreviewHeightArgument
	PreviewShowArgument
	ReturnArgument
	ShowArgument
	PackageTagArgument
);
%hierarchy NameArgument (FileNameArgument ClassNameArgument PageNameArgument PackageNameArgument);
%hierarchy ClassNameArgument (MethodNameArgument);

%hierarchy Annotation (
	ClassAnnotation
	PackageAnnotation
	ExampleAnnotation
	MethodAnnotation
	ChangesAnnotation
	PageAnnotation
	TodoAnnotation
);

%excludes label path uuid;

%start ClassAnnotation ExampleAnnotation MethodAnnotation ChangesAnnotation PageAnnotation TodoAnnotation;

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
	: class(Trait)?
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
<completed>
	: completed
	;
<due>
	: due
	;
<date>
	: \d{1,4} \-(1[0-2]|0[1-9])\-(0[1-9]|[12][0-9]|3[01])
	| (\d{1,4} (\-\d{0,2} (\-\d{0,2})? )? | \-\d{0,2} (\-\d{0,2})?)	# hack to handle partial dates
	;
path default <id>
	: id
	;
<packageName>
	: <isUppercase> ( <isLetter> | _ | <isDigit> | - ) *
	;
<tag>
	: tag
	;
PackageAnnotation 
	: PackageAnnotationItems {{}}
	;
PackageAnnotationItems
	
	: PackageAnnotationItems <bar> 'separator' PackageAnnotationItem 'item'
	| PackageAnnotationItem 'item'
	;
PackageAnnotationItem
	: PackageName
	| Label
	| Tag
	| Expanded
	| Show
	| Height
	;
Tag
	: <tag> 'name' <eq> 'equals' <packageName> 'value' {{PackageTagArgument}}
	;
PackageName
	: <name> 'name' <eq> 'equals' <packageName> 'value' {{PackageNameArgument}}
	| <packageName> 'value' {{PackageNameArgument}}
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
	| Id
	| Label
	;
Id
	: <id> 'name' SwitchToUuid <eq> 'equals' SwitchToPath <uuid> 'value' {{IdArgument}}
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
	: <path> 'value' {{PageNameArgument}}
	| <name> 'name' <eq> 'equals' <path> 'value' {{PageNameArgument}}
	;
TodoAnnotation
	: TodoAnnotationItems {{}}
	;
TodoAnnotationItems
	: TodoAnnotationItems <bar> 'separator' TodoAnnotationItem 'item'
	| TodoAnnotationItem 'item'
	;
TodoAnnotationItem
	: Due
	| Completed
	| Label
	;
Completed
	: <completed> 'name' <eq> 'equals' <date> 'value'? {{DateArgument}}
	;
Due
	: <due> 'name' <eq> 'equals' <date> 'value'? {{DateArgument}}
	;
ClassAnnotation
	: ClassAnnotationItems {{}}
	;"
]

{ #category : #generated }
LeAnnotationParser class >> reduceTable [
^#(
	#(51 0 #reduceActionForSwitchToLabel1: 3579905 true) 
	#(60 0 #reduceActionForOptionalBooleanValue1: 4591617 false) 
	#(42 1 #reduceActionForPackageName2: 2761730 false) 
	#(38 1 #reduceActionForPackageAnnotation1: 2399233 false) 
	#(39 1 #reduceActionForPackageAnnotationItems2: 2453506 false) 
	#(40 1 #liftFirstValue: 2589699 false) 
	#(40 1 #liftFirstValue: 2589697 false) 
	#(40 1 #liftFirstValue: 2589702 false) 
	#(40 1 #liftFirstValue: 2589701 false) 
	#(40 1 #liftFirstValue: 2589700 false) 
	#(40 1 #liftFirstValue: 2589698 false) 
	#(52 1 #reduceActionForClassName3: 3627011 false) 
	#(85 1 #reduceActionForClassAnnotation1: 6666241 false) 
	#(43 1 #reduceActionForPackageAnnotationItems2: 2906114 false) 
	#(44 1 #liftFirstValue: 3032070 false) 
	#(44 1 #liftFirstValue: 3032069 false) 
	#(44 1 #liftFirstValue: 3032068 false) 
	#(44 1 #liftFirstValue: 3032067 false) 
	#(44 1 #liftFirstValue: 3032066 false) 
	#(44 1 #liftFirstValue: 3032065 false) 
	#(55 1 #liftFirstValue: 3993602 false) 
	#(55 1 #liftFirstValue: 3993603 false) 
	#(53 1 #reduceActionForExampleAnnotation1: 3806209 false) 
	#(54 1 #reduceActionForPackageAnnotationItems2: 3859458 false) 
	#(55 1 #liftFirstValue: 3993610 false) 
	#(55 1 #liftFirstValue: 3993609 false) 
	#(55 1 #liftFirstValue: 3993608 false) 
	#(55 1 #liftFirstValue: 3993607 false) 
	#(55 1 #liftFirstValue: 3993606 false) 
	#(55 1 #liftFirstValue: 3993605 false) 
	#(55 1 #liftFirstValue: 3993604 false) 
	#(55 1 #liftFirstValue: 3993601 false) 
	#(66 1 #liftFirstValue: 5100549 false) 
	#(66 1 #liftFirstValue: 5100548 false) 
	#(66 1 #liftFirstValue: 5100547 false) 
	#(66 1 #liftFirstValue: 5100546 false) 
	#(64 1 #reduceActionForMethodAnnotation1: 4919297 false) 
	#(65 1 #reduceActionForPackageAnnotationItems2: 4970498 false) 
	#(66 1 #liftFirstValue: 5100545 false) 
	#(71 1 #reduceActionForPath1: 5583873 false) 
	#(70 1 #liftFirstValue: 5519363 false) 
	#(70 1 #liftFirstValue: 5519362 false) 
	#(70 1 #liftFirstValue: 5519361 false) 
	#(68 1 #reduceActionForChangesAnnotation1: 5331969 false) 
	#(69 1 #reduceActionForPackageAnnotationItems2: 5385218 false) 
	#(70 1 #liftFirstValue: 5519364 false) 
	#(79 1 #reduceActionForPageLabel1: 6167553 false) 
	#(77 0 #reduceActionForSwitchToUuid1: 6077441 true) 
	#(74 1 #liftFirstValue: 5833732 false) 
	#(72 1 #reduceActionForPageAnnotation1: 5663745 false) 
	#(73 1 #reduceActionForPackageAnnotationItems2: 5710850 false) 
	#(74 1 #liftFirstValue: 5833731 false) 
	#(74 1 #liftFirstValue: 5833730 false) 
	#(74 1 #liftFirstValue: 5833729 false) 
	#(82 1 #liftFirstValue: 6458371 false) 
	#(80 1 #reduceActionForTodoAnnotation1: 6289409 false) 
	#(81 1 #reduceActionForPackageAnnotationItems2: 6336514 false) 
	#(82 1 #liftFirstValue: 6458370 false) 
	#(82 1 #liftFirstValue: 6458369 false) 
	#(60 1 #reduceActionForOptionalBooleanValue2: 4591618 false) 
	#(47 2 #reduceActionForExpanded1: 3275777 false) 
	#(52 2 #reduceActionForClassName4: 3627012 false) 
	#(48 2 #reduceActionForFull1: 3352577 false) 
	#(59 2 #reduceActionForPreviewExpanded1: 4493313 false) 
	#(62 2 #reduceActionForNoCode1: 4759553 false) 
	#(63 2 #reduceActionForCodeExpanded1: 4830209 false) 
	#(83 2 #reduceActionForCompleted1: 6510593 false) 
	#(84 2 #reduceActionForCompleted1: 6594561 false) 
	#(42 3 #reduceActionForPackageName1: 2761729 false) 
	#(50 0 #reduceActionForSwitchToDefault1: 3528705 true) 
	#(60 2 #reduceActionForOptionalBooleanValue3: 4591619 false) 
	#(46 3 #reduceActionForShow1: 3198977 false) 
	#(45 3 #reduceActionForHeight1: 3117057 false) 
	#(41 3 #reduceActionForTag1: 2677761 false) 
	#(39 3 #reduceActionForPackageAnnotationItems1: 2453505 false) 
	#(52 3 #reduceActionForClassName1: 3627009 false) 
	#(43 3 #reduceActionForPackageAnnotationItems1: 2906113 false) 
	#(67 3 #reduceActionForMethodName1: 5179393 false) 
	#(56 3 #reduceActionForReturn1: 4157441 false) 
	#(57 3 #reduceActionForAlignment1: 4245505 false) 
	#(57 3 #reduceActionForAlignment1: 4245506 false) 
	#(57 3 #reduceActionForAlignment1: 4245507 false) 
	#(58 3 #reduceActionForPreviewShow1: 4395009 false) 
	#(61 3 #reduceActionForPreviewHeight1: 4656129 false) 
	#(54 3 #reduceActionForPackageAnnotationItems1: 3859457 false) 
	#(65 3 #reduceActionForPackageAnnotationItems1: 4970497 false) 
	#(71 3 #reduceActionForPath2: 5583874 false) 
	#(69 3 #reduceActionForPackageAnnotationItems1: 5385217 false) 
	#(79 3 #reduceActionForPageLabel2: 6167554 false) 
	#(78 0 #reduceActionForSwitchToPath1: 6122497 true) 
	#(73 3 #reduceActionForPackageAnnotationItems1: 5710849 false) 
	#(83 3 #reduceActionForCompleted2: 6510594 false) 
	#(84 3 #reduceActionForCompleted2: 6594562 false) 
	#(81 3 #reduceActionForPackageAnnotationItems1: 6336513 false) 
	#(52 4 #reduceActionForClassName2: 3627010 false) 
	#(67 4 #reduceActionForMethodName2: 5179394 false) 
	#(49 5 #reduceActionForLabel1: 3417089 false) 
	#(67 5 #reduceActionForMethodName3: 5179395 false) 
	#(76 5 #reduceActionForDb1: 5984257 false) 
	#(75 5 #reduceActionForId1: 5891073 false) 
	#(67 6 #reduceActionForMethodName4: 5179396 false)
	).
]

{ #category : #generated }
LeAnnotationParser class >> scannerClass [
	^LeAnnotationScanner
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForChangesAnnotation [
	^ 5
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForClassAnnotation [
	^ 2
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForExampleAnnotation [
	^ 3
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForMethodAnnotation [
	^ 4
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForPackageAnnotation [
	^ 1
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForPageAnnotation [
	^ 6
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForTodoAnnotation [
	^ 7
]

{ #category : #generated }
LeAnnotationParser class >> symbolNames [
	^ #('<className>' '<unarySelector>' '<selector>' '<integer>' '<labelText>' '<whitespace>' '<name>' '<eq>' '<label>' '<full>' '<expanded>' '<boolean>' '<show>' '<height>' '<bar>' '<return>' '<alignment>' '<previewShow>' '<previewExpanded>' '<previewHeight>' '<noCode>' '<gtgt>' '<codeExpanded>' '<documentWidth>' '<fullWidth>' '<paragraphWidth>' '<class>' '<path>' '<db>' '<uuid>' '<completed>' '<due>' '<date>' '<id>' '<packageName>' '<tag>' 'B e g i n' 'PackageAnnotation' 'PackageAnnotationItems' 'PackageAnnotationItem' 'Tag' 'PackageName' 'ClassAnnotationItems' 'ClassAnnotationItem' 'Height' 'Show' 'Expanded' 'Full' 'Label' 'SwitchToDefault' 'SwitchToLabel' 'ClassName' 'ExampleAnnotation' 'ExampleAnnotationItems' 'ExampleAnnotationItem' 'Return' 'Alignment' 'PreviewShow' 'PreviewExpanded' 'OptionalBooleanValue' 'PreviewHeight' 'NoCode' 'CodeExpanded' 'MethodAnnotation' 'MethodAnnotationItems' 'MethodAnnotationItem' 'MethodName' 'ChangesAnnotation' 'ChangesAnnotationItems' 'ChangesAnnotationItem' 'Path' 'PageAnnotation' 'PageAnnotationItems' 'PageAnnotationItem' 'Id' 'Db' 'SwitchToUuid' 'SwitchToPath' 'PageLabel' 'TodoAnnotation' 'TodoAnnotationItems' 'TodoAnnotationItem' 'Completed' 'Due' 'ClassAnnotation' 'E O F' 'error')
]

{ #category : #generated }
LeAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LePackageAnnotationNode #LePackageAnnotationNode #OrderedCollection #LeArgumentNode #LePackageTagArgumentNode #LePackageNameArgumentNode #OrderedCollection #LeArgumentNode #LeHeightArgumentNode #LeShowArgumentNode #LeExpandedArgumentNode #LeFullArgumentNode #LeLabelArgumentNode nil nil #LeClassNameArgumentNode #LeExampleAnnotationNode #OrderedCollection #LeArgumentNode #LeReturnArgumentNode #LeAlignmentArgumentNode #LePreviewShowArgumentNode #LePreviewExpandedArgumentNode #OrderedCollection #LePreviewHeightArgumentNode #LeNoCodeArgumentNode #LeCodeExpandedArgumentNode #LeMethodAnnotationNode #OrderedCollection #LeArgumentNode #LeMethodNameArgumentNode #LeChangesAnnotationNode #OrderedCollection #LeArgumentNode #LeFileNameArgumentNode #LePageAnnotationNode #OrderedCollection #LeArgumentNode #LeIdArgumentNode #LeDbArgumentNode nil nil #LePageNameArgumentNode #LeTodoAnnotationNode #OrderedCollection #LeArgumentNode #LeDateArgumentNode #LeDateArgumentNode #LeClassAnnotationNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeAnnotationParser class >> transitionTable [
^#(
#[1 0 33 0 7 0 37 0 9 0 41 0 11 0 45 0 13 0 49 0 14 0 53 0 35 0 57 0 36 0 61 0 38 0 65 0 39 0 69 0 40 0 69 0 41 0 69 0 42 0 69 0 45 0 69 0 46 0 69 0 47 0 69 0 49] 
#[1 0 97 0 1 0 101 0 7 0 37 0 9 0 105 0 10 0 41 0 11 0 45 0 13 0 49 0 14 0 109 0 43 0 113 0 44 0 113 0 45 0 113 0 46 0 113 0 47 0 113 0 48 0 113 0 49 0 113 0 52 0 141 0 85] 
#[1 0 145 0 1 0 149 0 7 0 37 0 9 0 41 0 11 0 153 0 16 0 157 0 17 0 161 0 18 0 165 0 19 0 169 0 20 0 173 0 21 0 177 0 23 0 197 0 47 0 197 0 49 0 189 0 53 0 193 0 54 0 197 0 55 0 197 0 56 0 197 0 57 0 197 0 58 0 197 0 59 0 197 0 61 0 197 0 62 0 197 0 63 0 197 0 67] 
#[1 0 145 0 1 0 149 0 7 0 37 0 9 0 41 0 11 0 45 0 13 0 49 0 14 1 1 0 45 1 1 0 46 1 1 0 47 1 1 0 49 0 249 0 64 0 253 0 65 1 1 0 66 1 1 0 67] 
#[1 1 9 0 7 0 41 0 11 0 45 0 13 0 49 0 14 1 13 0 28 1 37 0 45 1 37 0 46 1 37 0 47 1 29 0 68 1 33 0 69 1 37 0 70 1 37 0 71] 
#[1 1 45 0 7 0 37 0 9 1 49 0 28 1 53 0 29 1 57 0 34 1 73 0 49 1 65 0 72 1 69 0 73 1 73 0 74 1 73 0 75 1 73 0 76 1 73 0 79] 
#[1 0 37 0 9 1 89 0 31 1 93 0 32 1 109 0 49 1 101 0 80 1 105 0 81 1 109 0 82 1 109 0 83 1 109 0 84] 
#[0 1 121 0 8] 
#[1 0 6 0 8 1 125 0 51] 
#[1 1 129 0 8 0 10 0 15 1 133 0 60 0 10 0 86] 
#[0 1 137 0 8] 
#[0 1 141 0 8] 
#[0 0 14 0 15 0 86] 
#[0 1 145 0 8] 
#[0 0 0 0 86] 
#[1 1 149 0 15 0 18 0 86] 
#[0 0 22 0 15 0 86] 
#[0 0 26 0 15 0 86] 
#[0 0 30 0 15 0 86] 
#[0 0 34 0 15 0 86] 
#[0 0 38 0 15 0 86] 
#[0 0 42 0 15 0 86] 
#[0 0 46 0 15 0 86] 
#[1 0 50 0 15 1 153 0 27 0 50 0 86] 
#[0 1 157 0 8] 
#[1 1 129 0 8 0 10 0 15 1 161 0 60 0 10 0 86] 
#[1 1 165 0 15 0 54 0 86] 
#[0 0 58 0 15 0 86] 
#[0 0 62 0 15 0 86] 
#[0 0 66 0 15 0 86] 
#[0 0 70 0 15 0 86] 
#[0 0 74 0 15 0 86] 
#[0 0 78 0 15 0 86] 
#[0 0 82 0 15 0 86] 
#[0 0 0 0 86] 
#[1 1 169 0 22 1 173 0 27] 
#[0 1 177 0 8] 
#[0 1 181 0 8] 
#[0 1 185 0 8] 
#[0 1 189 0 8] 
#[1 1 129 0 8 0 10 0 15 1 193 0 60 0 10 0 86] 
#[0 1 197 0 8] 
#[1 1 129 0 8 0 10 0 15 1 201 0 60 0 10 0 86] 
#[1 1 129 0 8 0 10 0 15 1 205 0 60 0 10 0 86] 
#[0 0 86 0 15 0 86] 
#[0 0 90 0 15 0 86] 
#[0 0 0 0 86] 
#[1 1 209 0 15 0 94 0 86] 
#[0 0 98 0 15 0 86] 
#[0 0 102 0 15 0 86] 
#[0 0 106 0 15 0 86] 
#[0 0 110 0 15 0 86] 
#[0 0 114 0 15 0 86] 
#[0 0 118 0 15 0 86] 
#[0 0 122 0 15 0 86] 
#[0 0 126 0 15 0 86] 
#[0 0 130 0 15 0 86] 
#[0 0 134 0 15 0 86] 
#[0 0 138 0 15 0 86] 
#[0 0 142 0 15 0 86] 
#[0 0 146 0 15 0 86] 
#[0 0 0 0 86] 
#[1 1 213 0 15 0 150 0 86] 
#[0 0 154 0 15 0 86] 
#[0 0 158 0 15 0 86] 
#[0 1 217 0 8] 
#[0 0 162 0 15 0 86] 
#[0 0 166 0 15 0 86] 
#[0 0 170 0 15 0 86] 
#[0 0 174 0 15 0 86] 
#[0 0 0 0 86] 
#[1 1 221 0 15 0 178 0 86] 
#[0 0 182 0 15 0 86] 
#[0 0 186 0 15 0 86] 
#[0 1 225 0 8] 
#[0 0 190 0 15 0 86] 
#[1 0 194 0 8 1 229 0 77] 
#[1 0 194 0 8 1 233 0 77] 
#[0 0 198 0 15 0 86] 
#[0 0 0 0 86] 
#[1 1 237 0 15 0 202 0 86] 
#[0 0 206 0 15 0 86] 
#[0 0 210 0 15 0 86] 
#[0 0 214 0 15 0 86] 
#[0 0 218 0 15 0 86] 
#[0 1 241 0 8] 
#[0 1 245 0 8] 
#[0 0 222 0 15 0 86] 
#[0 0 0 0 86] 
#[1 1 249 0 15 0 226 0 86] 
#[0 0 230 0 15 0 86] 
#[0 0 234 0 15 0 86] 
#[0 0 238 0 15 0 86] 
#[0 1 253 0 35] 
#[0 2 1 0 8] 
#[1 2 5 0 12 0 242 0 15 0 242 0 86] 
#[0 0 246 0 15 0 86] 
#[0 2 9 0 3] 
#[0 2 13 0 4] 
#[0 2 17 0 35] 
#[1 0 33 0 7 0 37 0 9 0 41 0 11 0 45 0 13 0 49 0 14 0 53 0 35 0 57 0 36 2 21 0 40 2 21 0 41 2 21 0 42 2 21 0 45 2 21 0 46 2 21 0 47 2 21 0 49] 
#[0 0 250 0 15 0 86] 
#[0 2 25 0 1] 
#[0 0 254 0 15 0 86] 
#[1 0 97 0 1 0 101 0 7 0 37 0 9 0 105 0 10 0 41 0 11 0 45 0 13 0 49 0 14 2 29 0 44 2 29 0 45 2 29 0 46 2 29 0 47 2 29 0 48 2 29 0 49 2 29 0 52] 
#[0 2 33 0 3] 
#[0 2 37 0 22] 
#[0 2 41 0 1] 
#[0 2 45 0 2] 
#[1 2 49 0 24 2 53 0 25 2 57 0 26] 
#[0 2 61 0 3] 
#[0 1 2 0 15 0 86] 
#[0 2 65 0 4] 
#[0 1 6 0 15 0 86] 
#[0 1 10 0 15 0 86] 
#[1 0 145 0 1 0 149 0 7 0 37 0 9 0 41 0 11 0 153 0 16 0 157 0 17 0 161 0 18 0 165 0 19 0 169 0 20 0 173 0 21 0 177 0 23 2 69 0 47 2 69 0 49 2 69 0 55 2 69 0 56 2 69 0 57 2 69 0 58 2 69 0 59 2 69 0 61 2 69 0 62 2 69 0 63 2 69 0 67] 
#[1 0 145 0 1 0 149 0 7 0 37 0 9 0 41 0 11 0 45 0 13 0 49 0 14 2 73 0 45 2 73 0 46 2 73 0 47 2 73 0 49 2 73 0 66 2 73 0 67] 
#[0 2 77 0 28] 
#[1 1 9 0 7 0 41 0 11 0 45 0 13 0 49 0 14 1 13 0 28 2 81 0 45 2 81 0 46 2 81 0 47 2 81 0 70 2 81 0 71] 
#[0 2 85 0 28] 
#[0 2 89 0 8] 
#[0 2 93 0 8] 
#[1 1 45 0 7 0 37 0 9 1 49 0 28 1 53 0 29 1 57 0 34 2 97 0 49 2 97 0 74 2 97 0 75 2 97 0 76 2 97 0 79] 
#[1 1 14 0 15 2 101 0 33 1 14 0 86] 
#[1 1 18 0 15 2 105 0 33 1 18 0 86] 
#[1 0 37 0 9 1 89 0 31 1 93 0 32 2 109 0 49 2 109 0 82 2 109 0 83 2 109 0 84] 
#[0 1 22 0 15 0 86] 
#[1 1 26 0 5 2 113 0 50] 
#[0 1 30 0 15 0 86] 
#[0 1 34 0 15 0 86] 
#[0 1 38 0 15 0 86] 
#[0 1 42 0 15 0 86] 
#[0 1 46 0 15 0 86] 
#[1 1 50 0 15 2 117 0 27 1 50 0 86] 
#[0 1 54 0 15 0 86] 
#[0 1 58 0 15 0 86] 
#[0 2 121 0 3] 
#[1 2 125 0 22 2 129 0 27] 
#[0 1 62 0 15 0 86] 
#[0 1 66 0 15 0 86] 
#[0 1 70 0 15 0 86] 
#[0 1 74 0 15 0 86] 
#[0 1 78 0 15 0 86] 
#[0 1 82 0 15 0 86] 
#[0 1 86 0 15 0 86] 
#[0 1 90 0 15 0 86] 
#[0 1 94 0 15 0 86] 
#[0 1 98 0 15 0 86] 
#[0 1 102 0 15 0 86] 
#[1 1 106 0 30 2 133 0 78] 
#[1 1 106 0 30 2 137 0 78] 
#[0 1 110 0 15 0 86] 
#[0 1 114 0 15 0 86] 
#[0 1 118 0 15 0 86] 
#[0 1 122 0 15 0 86] 
#[0 2 141 0 5] 
#[0 1 126 0 15 0 86] 
#[0 1 130 0 15 0 86] 
#[0 2 145 0 3] 
#[0 2 149 0 22] 
#[0 2 153 0 30] 
#[0 2 157 0 30] 
#[0 1 134 0 15 0 86] 
#[0 1 138 0 15 0 86] 
#[0 2 161 0 3] 
#[0 1 142 0 15 0 86] 
#[0 1 146 0 15 0 86] 
#[0 1 150 0 15 0 86]
	).
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForAlignment1: nodes [
	| result |
	result := LeAlignmentArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForChangesAnnotation1: nodes [
	| result |
	result := LeChangesAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassAnnotation1: nodes [
	| result |
	result := LeClassAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassName1: nodes [
	| result |
	result := LeClassNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassName2: nodes [
	| result |
	result := LeClassNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	result classToken: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassName3: nodes [
	| result |
	result := LeClassNameArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassName4: nodes [
	| result |
	result := LeClassNameArgumentNode new.
	result value: (nodes at: 1).
	result classToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForCodeExpanded1: nodes [
	| result |
	result := LeCodeExpandedArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForCompleted1: nodes [
	| result |
	result := LeDateArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForCompleted2: nodes [
	| result |
	result := LeDateArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForDb1: nodes [
	| result |
	result := LeDbArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 3).
	result value: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForExampleAnnotation1: nodes [
	| result |
	result := LeExampleAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForExpanded1: nodes [
	| result |
	result := LeExpandedArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForFull1: nodes [
	| result |
	result := LeFullArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForHeight1: nodes [
	| result |
	result := LeHeightArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForId1: nodes [
	| result |
	result := LeIdArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 3).
	result value: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForLabel1: nodes [
	| result |
	result := LeLabelArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 3).
	result value: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForMethodAnnotation1: nodes [
	| result |
	result := LeMethodAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForMethodName1: nodes [
	| result |
	result := LeMethodNameArgumentNode new.
	result value: (nodes at: 1).
	result gtGt: (nodes at: 2).
	result selector: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForMethodName2: nodes [
	| result |
	result := LeMethodNameArgumentNode new.
	result value: (nodes at: 1).
	result classToken: (nodes at: 2).
	result gtGt: (nodes at: 3).
	result selector: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
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

{ #category : #'generated-reduction actions' }
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

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForNoCode1: nodes [
	| result |
	result := LeNoCodeArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForOptionalBooleanValue1: nodes [
	| result |
	result := Array new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForOptionalBooleanValue2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForOptionalBooleanValue3: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPackageAnnotation1: nodes [
	| result |
	result := LePackageAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPackageAnnotationItems1: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 1).
	self add: (nodes at: 3) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPackageAnnotationItems2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPackageName1: nodes [
	| result |
	result := LePackageNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPackageName2: nodes [
	| result |
	result := LePackageNameArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPageAnnotation1: nodes [
	| result |
	result := LePageAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPageLabel1: nodes [
	| result |
	result := LePageNameArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPageLabel2: nodes [
	| result |
	result := LePageNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPath1: nodes [
	| result |
	result := LeFileNameArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPath2: nodes [
	| result |
	result := LeFileNameArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPreviewExpanded1: nodes [
	| result |
	result := LePreviewExpandedArgumentNode new.
	result name: (nodes at: 1).
	result equals: ((nodes at: 2) at: 1).
	result value: ((nodes at: 2) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPreviewHeight1: nodes [
	| result |
	result := LePreviewHeightArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPreviewShow1: nodes [
	| result |
	result := LePreviewShowArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForReturn1: nodes [
	| result |
	result := LeReturnArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForShow1: nodes [
	| result |
	result := LeShowArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForSwitchToDefault1: nodes [
	self scope: #default.
	^ nil
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForSwitchToLabel1: nodes [
	self scope: #label.
	^ nil
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForSwitchToPath1: nodes [
	self scope: #path.
	^ nil
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForSwitchToUuid1: nodes [
	self scope: #uuid.
	^ nil
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForTag1: nodes [
	| result |
	result := LePackageTagArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForTodoAnnotation1: nodes [
	| result |
	result := LeTodoAnnotationNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result separators.
	result addNodes: ((nodes at: 1) at: 2) to: result items.
	^ result
]

{ #category : #testing }
LeAnnotationParser >> tryAllTokens [
	^ true
]

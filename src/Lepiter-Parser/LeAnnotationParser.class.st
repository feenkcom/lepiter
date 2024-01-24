Class {
	#name : #LeAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Parser'
}

{ #category : #'generated-accessing' }
LeAnnotationParser class >> cacheId [
	^'2024-01-24T14:00:52.409165+01:00'
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
	PreviewSelectArgument
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
<previewSelect>
	: previewSelect
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
	| PreviewSelect
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
PreviewSelect
	: <previewSelect> 'name' <eq> 'equals' <selector> 'value' {{PreviewSelectArgument}}
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
	#(52 0 #reduceActionForSwitchToLabel1: 3640321 true) 
	#(62 0 #reduceActionForOptionalBooleanValue1: 4773889 false) 
	#(43 1 #reduceActionForPackageName2: 2822146 false) 
	#(39 1 #reduceActionForPackageAnnotation1: 2459649 false) 
	#(40 1 #reduceActionForPackageAnnotationItems2: 2513922 false) 
	#(41 1 #liftFirstValue: 2650115 false) 
	#(41 1 #liftFirstValue: 2650113 false) 
	#(41 1 #liftFirstValue: 2650118 false) 
	#(41 1 #liftFirstValue: 2650117 false) 
	#(41 1 #liftFirstValue: 2650116 false) 
	#(41 1 #liftFirstValue: 2650114 false) 
	#(53 1 #reduceActionForClassName3: 3687427 false) 
	#(87 1 #reduceActionForClassAnnotation1: 6848513 false) 
	#(44 1 #reduceActionForPackageAnnotationItems2: 2966530 false) 
	#(45 1 #liftFirstValue: 3092486 false) 
	#(45 1 #liftFirstValue: 3092485 false) 
	#(45 1 #liftFirstValue: 3092484 false) 
	#(45 1 #liftFirstValue: 3092483 false) 
	#(45 1 #liftFirstValue: 3092482 false) 
	#(45 1 #liftFirstValue: 3092481 false) 
	#(56 1 #liftFirstValue: 4054018 false) 
	#(56 1 #liftFirstValue: 4054019 false) 
	#(54 1 #reduceActionForExampleAnnotation1: 3866625 false) 
	#(55 1 #reduceActionForPackageAnnotationItems2: 3919874 false) 
	#(56 1 #liftFirstValue: 4054027 false) 
	#(56 1 #liftFirstValue: 4054026 false) 
	#(56 1 #liftFirstValue: 4054024 false) 
	#(56 1 #liftFirstValue: 4054025 false) 
	#(56 1 #liftFirstValue: 4054023 false) 
	#(56 1 #liftFirstValue: 4054022 false) 
	#(56 1 #liftFirstValue: 4054021 false) 
	#(56 1 #liftFirstValue: 4054020 false) 
	#(56 1 #liftFirstValue: 4054017 false) 
	#(68 1 #liftFirstValue: 5282821 false) 
	#(68 1 #liftFirstValue: 5282820 false) 
	#(68 1 #liftFirstValue: 5282819 false) 
	#(68 1 #liftFirstValue: 5282818 false) 
	#(66 1 #reduceActionForMethodAnnotation1: 5101569 false) 
	#(67 1 #reduceActionForPackageAnnotationItems2: 5152770 false) 
	#(68 1 #liftFirstValue: 5282817 false) 
	#(73 1 #reduceActionForPath1: 5766145 false) 
	#(72 1 #liftFirstValue: 5701635 false) 
	#(72 1 #liftFirstValue: 5701634 false) 
	#(72 1 #liftFirstValue: 5701633 false) 
	#(70 1 #reduceActionForChangesAnnotation1: 5514241 false) 
	#(71 1 #reduceActionForPackageAnnotationItems2: 5567490 false) 
	#(72 1 #liftFirstValue: 5701636 false) 
	#(81 1 #reduceActionForPageLabel1: 6349825 false) 
	#(79 0 #reduceActionForSwitchToUuid1: 6259713 true) 
	#(76 1 #liftFirstValue: 6016004 false) 
	#(74 1 #reduceActionForPageAnnotation1: 5846017 false) 
	#(75 1 #reduceActionForPackageAnnotationItems2: 5893122 false) 
	#(76 1 #liftFirstValue: 6016003 false) 
	#(76 1 #liftFirstValue: 6016002 false) 
	#(76 1 #liftFirstValue: 6016001 false) 
	#(84 1 #liftFirstValue: 6640643 false) 
	#(82 1 #reduceActionForTodoAnnotation1: 6471681 false) 
	#(83 1 #reduceActionForPackageAnnotationItems2: 6518786 false) 
	#(84 1 #liftFirstValue: 6640642 false) 
	#(84 1 #liftFirstValue: 6640641 false) 
	#(62 1 #reduceActionForOptionalBooleanValue2: 4773890 false) 
	#(48 2 #reduceActionForExpanded1: 3336193 false) 
	#(53 2 #reduceActionForClassName4: 3687428 false) 
	#(49 2 #reduceActionForFull1: 3412993 false) 
	#(61 2 #reduceActionForPreviewExpanded1: 4675585 false) 
	#(64 2 #reduceActionForNoCode1: 4941825 false) 
	#(65 2 #reduceActionForCodeExpanded1: 5012481 false) 
	#(85 2 #reduceActionForCompleted1: 6692865 false) 
	#(86 2 #reduceActionForCompleted1: 6776833 false) 
	#(43 3 #reduceActionForPackageName1: 2822145 false) 
	#(51 0 #reduceActionForSwitchToDefault1: 3589121 true) 
	#(62 2 #reduceActionForOptionalBooleanValue3: 4773891 false) 
	#(47 3 #reduceActionForShow1: 3259393 false) 
	#(46 3 #reduceActionForHeight1: 3177473 false) 
	#(42 3 #reduceActionForTag1: 2738177 false) 
	#(40 3 #reduceActionForPackageAnnotationItems1: 2513921 false) 
	#(53 3 #reduceActionForClassName1: 3687425 false) 
	#(44 3 #reduceActionForPackageAnnotationItems1: 2966529 false) 
	#(69 3 #reduceActionForMethodName1: 5361665 false) 
	#(57 3 #reduceActionForReturn1: 4235265 false) 
	#(58 3 #reduceActionForAlignment1: 4323329 false) 
	#(58 3 #reduceActionForAlignment1: 4323330 false) 
	#(58 3 #reduceActionForAlignment1: 4323331 false) 
	#(59 3 #reduceActionForPreviewShow1: 4472833 false) 
	#(60 3 #reduceActionForPreviewSelect1: 4571137 false) 
	#(63 3 #reduceActionForPreviewHeight1: 4838401 false) 
	#(55 3 #reduceActionForPackageAnnotationItems1: 3919873 false) 
	#(67 3 #reduceActionForPackageAnnotationItems1: 5152769 false) 
	#(73 3 #reduceActionForPath2: 5766146 false) 
	#(71 3 #reduceActionForPackageAnnotationItems1: 5567489 false) 
	#(81 3 #reduceActionForPageLabel2: 6349826 false) 
	#(80 0 #reduceActionForSwitchToPath1: 6304769 true) 
	#(75 3 #reduceActionForPackageAnnotationItems1: 5893121 false) 
	#(85 3 #reduceActionForCompleted2: 6692866 false) 
	#(86 3 #reduceActionForCompleted2: 6776834 false) 
	#(83 3 #reduceActionForPackageAnnotationItems1: 6518785 false) 
	#(53 4 #reduceActionForClassName2: 3687426 false) 
	#(69 4 #reduceActionForMethodName2: 5361666 false) 
	#(50 5 #reduceActionForLabel1: 3477505 false) 
	#(69 5 #reduceActionForMethodName3: 5361667 false) 
	#(78 5 #reduceActionForDb1: 6166529 false) 
	#(77 5 #reduceActionForId1: 6073345 false) 
	#(69 6 #reduceActionForMethodName4: 5361668 false)
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
	^ #('<className>' '<unarySelector>' '<selector>' '<integer>' '<labelText>' '<whitespace>' '<name>' '<eq>' '<label>' '<full>' '<expanded>' '<boolean>' '<show>' '<height>' '<bar>' '<return>' '<alignment>' '<previewShow>' '<previewSelect>' '<previewExpanded>' '<previewHeight>' '<noCode>' '<gtgt>' '<codeExpanded>' '<documentWidth>' '<fullWidth>' '<paragraphWidth>' '<class>' '<path>' '<db>' '<uuid>' '<completed>' '<due>' '<date>' '<id>' '<packageName>' '<tag>' 'B e g i n' 'PackageAnnotation' 'PackageAnnotationItems' 'PackageAnnotationItem' 'Tag' 'PackageName' 'ClassAnnotationItems' 'ClassAnnotationItem' 'Height' 'Show' 'Expanded' 'Full' 'Label' 'SwitchToDefault' 'SwitchToLabel' 'ClassName' 'ExampleAnnotation' 'ExampleAnnotationItems' 'ExampleAnnotationItem' 'Return' 'Alignment' 'PreviewShow' 'PreviewSelect' 'PreviewExpanded' 'OptionalBooleanValue' 'PreviewHeight' 'NoCode' 'CodeExpanded' 'MethodAnnotation' 'MethodAnnotationItems' 'MethodAnnotationItem' 'MethodName' 'ChangesAnnotation' 'ChangesAnnotationItems' 'ChangesAnnotationItem' 'Path' 'PageAnnotation' 'PageAnnotationItems' 'PageAnnotationItem' 'Id' 'Db' 'SwitchToUuid' 'SwitchToPath' 'PageLabel' 'TodoAnnotation' 'TodoAnnotationItems' 'TodoAnnotationItem' 'Completed' 'Due' 'ClassAnnotation' 'E O F' 'error')
]

{ #category : #generated }
LeAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LePackageAnnotationNode #LePackageAnnotationNode #OrderedCollection #LeArgumentNode #LePackageTagArgumentNode #LePackageNameArgumentNode #OrderedCollection #LeArgumentNode #LeHeightArgumentNode #LeShowArgumentNode #LeExpandedArgumentNode #LeFullArgumentNode #LeLabelArgumentNode nil nil #LeClassNameArgumentNode #LeExampleAnnotationNode #OrderedCollection #LeArgumentNode #LeReturnArgumentNode #LeAlignmentArgumentNode #LePreviewShowArgumentNode #LePreviewSelectArgumentNode #LePreviewExpandedArgumentNode #OrderedCollection #LePreviewHeightArgumentNode #LeNoCodeArgumentNode #LeCodeExpandedArgumentNode #LeMethodAnnotationNode #OrderedCollection #LeArgumentNode #LeMethodNameArgumentNode #LeChangesAnnotationNode #OrderedCollection #LeArgumentNode #LeFileNameArgumentNode #LePageAnnotationNode #OrderedCollection #LeArgumentNode #LeIdArgumentNode #LeDbArgumentNode nil nil #LePageNameArgumentNode #LeTodoAnnotationNode #OrderedCollection #LeArgumentNode #LeDateArgumentNode #LeDateArgumentNode #LeClassAnnotationNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeAnnotationParser class >> transitionTable [
^#(
#[1 0 33 0 7 0 37 0 9 0 41 0 11 0 45 0 13 0 49 0 14 0 53 0 36 0 57 0 37 0 61 0 39 0 65 0 40 0 69 0 41 0 69 0 42 0 69 0 43 0 69 0 46 0 69 0 47 0 69 0 48 0 69 0 50] 
#[1 0 97 0 1 0 101 0 7 0 37 0 9 0 105 0 10 0 41 0 11 0 45 0 13 0 49 0 14 0 109 0 44 0 113 0 45 0 113 0 46 0 113 0 47 0 113 0 48 0 113 0 49 0 113 0 50 0 113 0 53 0 141 0 87] 
#[1 0 145 0 1 0 149 0 7 0 37 0 9 0 41 0 11 0 153 0 16 0 157 0 17 0 161 0 18 0 165 0 19 0 169 0 20 0 173 0 21 0 177 0 22 0 181 0 24 0 201 0 48 0 201 0 50 0 193 0 54 0 197 0 55 0 201 0 56 0 201 0 57 0 201 0 58 0 201 0 59 0 201 0 60 0 201 0 61 0 201 0 63 0 201 0 64 0 201 0 65 0 201 0 69] 
#[1 0 145 0 1 0 149 0 7 0 37 0 9 0 41 0 11 0 45 0 13 0 49 0 14 1 9 0 46 1 9 0 47 1 9 0 48 1 9 0 50 1 1 0 66 1 5 0 67 1 9 0 68 1 9 0 69] 
#[1 1 17 0 7 0 41 0 11 0 45 0 13 0 49 0 14 1 21 0 29 1 45 0 46 1 45 0 47 1 45 0 48 1 37 0 70 1 41 0 71 1 45 0 72 1 45 0 73] 
#[1 1 53 0 7 0 37 0 9 1 57 0 29 1 61 0 30 1 65 0 35 1 81 0 50 1 73 0 74 1 77 0 75 1 81 0 76 1 81 0 77 1 81 0 78 1 81 0 81] 
#[1 0 37 0 9 1 97 0 32 1 101 0 33 1 117 0 50 1 109 0 82 1 113 0 83 1 117 0 84 1 117 0 85 1 117 0 86] 
#[0 1 129 0 8] 
#[1 0 6 0 8 1 133 0 52] 
#[1 1 137 0 8 0 10 0 15 1 141 0 62 0 10 0 88] 
#[0 1 145 0 8] 
#[0 1 149 0 8] 
#[0 0 14 0 15 0 88] 
#[0 1 153 0 8] 
#[0 0 0 0 88] 
#[1 1 157 0 15 0 18 0 88] 
#[0 0 22 0 15 0 88] 
#[0 0 26 0 15 0 88] 
#[0 0 30 0 15 0 88] 
#[0 0 34 0 15 0 88] 
#[0 0 38 0 15 0 88] 
#[0 0 42 0 15 0 88] 
#[0 0 46 0 15 0 88] 
#[1 0 50 0 15 1 161 0 28 0 50 0 88] 
#[0 1 165 0 8] 
#[1 1 137 0 8 0 10 0 15 1 169 0 62 0 10 0 88] 
#[1 1 173 0 15 0 54 0 88] 
#[0 0 58 0 15 0 88] 
#[0 0 62 0 15 0 88] 
#[0 0 66 0 15 0 88] 
#[0 0 70 0 15 0 88] 
#[0 0 74 0 15 0 88] 
#[0 0 78 0 15 0 88] 
#[0 0 82 0 15 0 88] 
#[0 0 0 0 88] 
#[1 1 177 0 23 1 181 0 28] 
#[0 1 185 0 8] 
#[0 1 189 0 8] 
#[0 1 193 0 8] 
#[0 1 197 0 8] 
#[0 1 201 0 8] 
#[1 1 137 0 8 0 10 0 15 1 205 0 62 0 10 0 88] 
#[0 1 209 0 8] 
#[1 1 137 0 8 0 10 0 15 1 213 0 62 0 10 0 88] 
#[1 1 137 0 8 0 10 0 15 1 217 0 62 0 10 0 88] 
#[0 0 86 0 15 0 88] 
#[0 0 90 0 15 0 88] 
#[0 0 0 0 88] 
#[1 1 221 0 15 0 94 0 88] 
#[0 0 98 0 15 0 88] 
#[0 0 102 0 15 0 88] 
#[0 0 106 0 15 0 88] 
#[0 0 110 0 15 0 88] 
#[0 0 114 0 15 0 88] 
#[0 0 118 0 15 0 88] 
#[0 0 122 0 15 0 88] 
#[0 0 126 0 15 0 88] 
#[0 0 130 0 15 0 88] 
#[0 0 134 0 15 0 88] 
#[0 0 138 0 15 0 88] 
#[0 0 142 0 15 0 88] 
#[0 0 146 0 15 0 88] 
#[0 0 150 0 15 0 88] 
#[0 0 0 0 88] 
#[1 1 225 0 15 0 154 0 88] 
#[0 0 158 0 15 0 88] 
#[0 0 162 0 15 0 88] 
#[0 1 229 0 8] 
#[0 0 166 0 15 0 88] 
#[0 0 170 0 15 0 88] 
#[0 0 174 0 15 0 88] 
#[0 0 178 0 15 0 88] 
#[0 0 0 0 88] 
#[1 1 233 0 15 0 182 0 88] 
#[0 0 186 0 15 0 88] 
#[0 0 190 0 15 0 88] 
#[0 1 237 0 8] 
#[0 0 194 0 15 0 88] 
#[1 0 198 0 8 1 241 0 79] 
#[1 0 198 0 8 1 245 0 79] 
#[0 0 202 0 15 0 88] 
#[0 0 0 0 88] 
#[1 1 249 0 15 0 206 0 88] 
#[0 0 210 0 15 0 88] 
#[0 0 214 0 15 0 88] 
#[0 0 218 0 15 0 88] 
#[0 0 222 0 15 0 88] 
#[0 1 253 0 8] 
#[0 2 1 0 8] 
#[0 0 226 0 15 0 88] 
#[0 0 0 0 88] 
#[1 2 5 0 15 0 230 0 88] 
#[0 0 234 0 15 0 88] 
#[0 0 238 0 15 0 88] 
#[0 0 242 0 15 0 88] 
#[0 2 9 0 36] 
#[0 2 13 0 8] 
#[1 2 17 0 12 0 246 0 15 0 246 0 88] 
#[0 0 250 0 15 0 88] 
#[0 2 21 0 3] 
#[0 2 25 0 4] 
#[0 2 29 0 36] 
#[1 0 33 0 7 0 37 0 9 0 41 0 11 0 45 0 13 0 49 0 14 0 53 0 36 0 57 0 37 2 33 0 41 2 33 0 42 2 33 0 43 2 33 0 46 2 33 0 47 2 33 0 48 2 33 0 50] 
#[0 0 254 0 15 0 88] 
#[0 2 37 0 1] 
#[0 1 2 0 15 0 88] 
#[1 0 97 0 1 0 101 0 7 0 37 0 9 0 105 0 10 0 41 0 11 0 45 0 13 0 49 0 14 2 41 0 45 2 41 0 46 2 41 0 47 2 41 0 48 2 41 0 49 2 41 0 50 2 41 0 53] 
#[0 2 45 0 3] 
#[0 2 49 0 23] 
#[0 2 53 0 1] 
#[0 2 57 0 2] 
#[1 2 61 0 25 2 65 0 26 2 69 0 27] 
#[0 2 73 0 3] 
#[0 2 77 0 3] 
#[0 1 6 0 15 0 88] 
#[0 2 81 0 4] 
#[0 1 10 0 15 0 88] 
#[0 1 14 0 15 0 88] 
#[1 0 145 0 1 0 149 0 7 0 37 0 9 0 41 0 11 0 153 0 16 0 157 0 17 0 161 0 18 0 165 0 19 0 169 0 20 0 173 0 21 0 177 0 22 0 181 0 24 2 85 0 48 2 85 0 50 2 85 0 56 2 85 0 57 2 85 0 58 2 85 0 59 2 85 0 60 2 85 0 61 2 85 0 63 2 85 0 64 2 85 0 65 2 85 0 69] 
#[1 0 145 0 1 0 149 0 7 0 37 0 9 0 41 0 11 0 45 0 13 0 49 0 14 2 89 0 46 2 89 0 47 2 89 0 48 2 89 0 50 2 89 0 68 2 89 0 69] 
#[0 2 93 0 29] 
#[1 1 17 0 7 0 41 0 11 0 45 0 13 0 49 0 14 1 21 0 29 2 97 0 46 2 97 0 47 2 97 0 48 2 97 0 72 2 97 0 73] 
#[0 2 101 0 29] 
#[0 2 105 0 8] 
#[0 2 109 0 8] 
#[1 1 53 0 7 0 37 0 9 1 57 0 29 1 61 0 30 1 65 0 35 2 113 0 50 2 113 0 76 2 113 0 77 2 113 0 78 2 113 0 81] 
#[1 1 18 0 15 2 117 0 34 1 18 0 88] 
#[1 1 22 0 15 2 121 0 34 1 22 0 88] 
#[1 0 37 0 9 1 97 0 32 1 101 0 33 2 125 0 50 2 125 0 84 2 125 0 85 2 125 0 86] 
#[0 1 26 0 15 0 88] 
#[1 1 30 0 5 2 129 0 51] 
#[0 1 34 0 15 0 88] 
#[0 1 38 0 15 0 88] 
#[0 1 42 0 15 0 88] 
#[0 1 46 0 15 0 88] 
#[0 1 50 0 15 0 88] 
#[1 1 54 0 15 2 133 0 28 1 54 0 88] 
#[0 1 58 0 15 0 88] 
#[0 1 62 0 15 0 88] 
#[0 2 137 0 3] 
#[1 2 141 0 23 2 145 0 28] 
#[0 1 66 0 15 0 88] 
#[0 1 70 0 15 0 88] 
#[0 1 74 0 15 0 88] 
#[0 1 78 0 15 0 88] 
#[0 1 82 0 15 0 88] 
#[0 1 86 0 15 0 88] 
#[0 1 90 0 15 0 88] 
#[0 1 94 0 15 0 88] 
#[0 1 98 0 15 0 88] 
#[0 1 102 0 15 0 88] 
#[0 1 106 0 15 0 88] 
#[0 1 110 0 15 0 88] 
#[1 1 114 0 31 2 149 0 80] 
#[1 1 114 0 31 2 153 0 80] 
#[0 1 118 0 15 0 88] 
#[0 1 122 0 15 0 88] 
#[0 1 126 0 15 0 88] 
#[0 1 130 0 15 0 88] 
#[0 2 157 0 5] 
#[0 1 134 0 15 0 88] 
#[0 1 138 0 15 0 88] 
#[0 2 161 0 3] 
#[0 2 165 0 23] 
#[0 2 169 0 31] 
#[0 2 173 0 31] 
#[0 1 142 0 15 0 88] 
#[0 1 146 0 15 0 88] 
#[0 2 177 0 3] 
#[0 1 150 0 15 0 88] 
#[0 1 154 0 15 0 88] 
#[0 1 158 0 15 0 88]
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
LeAnnotationParser >> reduceActionForPreviewSelect1: nodes [
	| result |
	result := LePreviewSelectArgumentNode new.
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

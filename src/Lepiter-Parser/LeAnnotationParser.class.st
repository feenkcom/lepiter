Class {
	#name : #LeAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Parser'
}

{ #category : #'generated-accessing' }
LeAnnotationParser class >> cacheId [
	^'2022-01-04T16:38:40.020785-06:00'
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
	;"
]

{ #category : #generated }
LeAnnotationParser class >> reduceTable [
^#(
	#(45 1 #reduceActionForClassName3: 2969603 false) 
	#(44 0 #reduceActionForSwitchToLabel1: 2922497 true) 
	#(53 0 #reduceActionForOptionalBooleanValue1: 3934209 false) 
	#(35 1 #reduceActionForClassAnnotation1: 2198529 false) 
	#(36 1 #reduceActionForClassAnnotationItems2: 2248706 false) 
	#(37 1 #liftFirstValue: 2374662 false) 
	#(37 1 #liftFirstValue: 2374661 false) 
	#(37 1 #liftFirstValue: 2374660 false) 
	#(37 1 #liftFirstValue: 2374659 false) 
	#(37 1 #liftFirstValue: 2374658 false) 
	#(37 1 #liftFirstValue: 2374657 false) 
	#(48 1 #liftFirstValue: 3336194 false) 
	#(48 1 #liftFirstValue: 3336195 false) 
	#(46 1 #reduceActionForExampleAnnotation1: 3148801 false) 
	#(47 1 #reduceActionForClassAnnotationItems2: 3202050 false) 
	#(48 1 #liftFirstValue: 3336202 false) 
	#(48 1 #liftFirstValue: 3336201 false) 
	#(48 1 #liftFirstValue: 3336200 false) 
	#(48 1 #liftFirstValue: 3336199 false) 
	#(48 1 #liftFirstValue: 3336198 false) 
	#(48 1 #liftFirstValue: 3336197 false) 
	#(48 1 #liftFirstValue: 3336196 false) 
	#(48 1 #liftFirstValue: 3336193 false) 
	#(59 1 #liftFirstValue: 4443141 false) 
	#(59 1 #liftFirstValue: 4443140 false) 
	#(59 1 #liftFirstValue: 4443139 false) 
	#(59 1 #liftFirstValue: 4443138 false) 
	#(57 1 #reduceActionForMethodAnnotation1: 4261889 false) 
	#(58 1 #reduceActionForClassAnnotationItems2: 4313090 false) 
	#(59 1 #liftFirstValue: 4443137 false) 
	#(64 1 #reduceActionForPath1: 4926465 false) 
	#(63 1 #liftFirstValue: 4861955 false) 
	#(63 1 #liftFirstValue: 4861954 false) 
	#(63 1 #liftFirstValue: 4861953 false) 
	#(61 1 #reduceActionForChangesAnnotation1: 4674561 false) 
	#(62 1 #reduceActionForClassAnnotationItems2: 4727810 false) 
	#(63 1 #liftFirstValue: 4861956 false) 
	#(71 1 #reduceActionForPageLabel1: 5401601 false) 
	#(69 0 #reduceActionForSwitchToUuid1: 5311489 true) 
	#(65 1 #reduceActionForPageAnnotation1: 5006337 false) 
	#(66 1 #reduceActionForClassAnnotationItems2: 5053442 false) 
	#(67 1 #liftFirstValue: 5176322 false) 
	#(67 1 #liftFirstValue: 5176321 false) 
	#(74 1 #liftFirstValue: 5685251 false) 
	#(72 1 #reduceActionForTodoAnnotation1: 5516289 false) 
	#(73 1 #reduceActionForClassAnnotationItems2: 5563394 false) 
	#(74 1 #liftFirstValue: 5685250 false) 
	#(74 1 #liftFirstValue: 5685249 false) 
	#(45 2 #reduceActionForClassName4: 2969604 false) 
	#(53 1 #reduceActionForOptionalBooleanValue2: 3934210 false) 
	#(41 2 #reduceActionForFull1: 2695169 false) 
	#(40 2 #reduceActionForExpanded1: 2618369 false) 
	#(52 2 #reduceActionForPreviewExpanded1: 3835905 false) 
	#(55 2 #reduceActionForNoCode1: 4102145 false) 
	#(56 2 #reduceActionForCodeExpanded1: 4172801 false) 
	#(75 2 #reduceActionForCompleted1: 5737473 false) 
	#(76 2 #reduceActionForCompleted1: 5821441 false) 
	#(45 3 #reduceActionForClassName1: 2969601 false) 
	#(43 0 #reduceActionForSwitchToDefault1: 2871297 true) 
	#(53 2 #reduceActionForOptionalBooleanValue3: 3934211 false) 
	#(39 3 #reduceActionForShow1: 2541569 false) 
	#(38 3 #reduceActionForHeight1: 2459649 false) 
	#(36 3 #reduceActionForClassAnnotationItems1: 2248705 false) 
	#(60 3 #reduceActionForMethodName1: 4521985 false) 
	#(49 3 #reduceActionForReturn1: 3500033 false) 
	#(50 3 #reduceActionForAlignment1: 3588097 false) 
	#(50 3 #reduceActionForAlignment1: 3588098 false) 
	#(50 3 #reduceActionForAlignment1: 3588099 false) 
	#(51 3 #reduceActionForPreviewShow1: 3737601 false) 
	#(54 3 #reduceActionForPreviewHeight1: 3998721 false) 
	#(47 3 #reduceActionForClassAnnotationItems1: 3202049 false) 
	#(58 3 #reduceActionForClassAnnotationItems1: 4313089 false) 
	#(64 3 #reduceActionForPath2: 4926466 false) 
	#(62 3 #reduceActionForClassAnnotationItems1: 4727809 false) 
	#(71 3 #reduceActionForPageLabel2: 5401602 false) 
	#(70 0 #reduceActionForSwitchToPath1: 5356545 true) 
	#(66 3 #reduceActionForClassAnnotationItems1: 5053441 false) 
	#(75 3 #reduceActionForCompleted2: 5737474 false) 
	#(76 3 #reduceActionForCompleted2: 5821442 false) 
	#(73 3 #reduceActionForClassAnnotationItems1: 5563393 false) 
	#(45 4 #reduceActionForClassName2: 2969602 false) 
	#(60 4 #reduceActionForMethodName2: 4521986 false) 
	#(42 5 #reduceActionForLabel1: 2759681 false) 
	#(60 5 #reduceActionForMethodName3: 4521987 false) 
	#(68 5 #reduceActionForDb1: 5218305 false) 
	#(60 6 #reduceActionForMethodName4: 4521988 false)
	).
]

{ #category : #generated }
LeAnnotationParser class >> scannerClass [
	^LeAnnotationScanner
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForChangesAnnotation [
	^ 4
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForClassAnnotation [
	^ 1
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForExampleAnnotation [
	^ 2
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForMethodAnnotation [
	^ 3
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForPageAnnotation [
	^ 5
]

{ #category : #generated }
LeAnnotationParser class >> startingStateForTodoAnnotation [
	^ 6
]

{ #category : #generated }
LeAnnotationParser class >> symbolNames [
	^ #('<className>' '<unarySelector>' '<selector>' '<integer>' '<labelText>' '<whitespace>' '<name>' '<eq>' '<label>' '<full>' '<expanded>' '<boolean>' '<show>' '<height>' '<bar>' '<return>' '<alignment>' '<previewShow>' '<previewExpanded>' '<previewHeight>' '<noCode>' '<gtgt>' '<codeExpanded>' '<documentWidth>' '<fullWidth>' '<paragraphWidth>' '<class>' '<path>' '<db>' '<uuid>' '<completed>' '<due>' '<date>' 'B e g i n' 'ClassAnnotation' 'ClassAnnotationItems' 'ClassAnnotationItem' 'Height' 'Show' 'Expanded' 'Full' 'Label' 'SwitchToDefault' 'SwitchToLabel' 'ClassName' 'ExampleAnnotation' 'ExampleAnnotationItems' 'ExampleAnnotationItem' 'Return' 'Alignment' 'PreviewShow' 'PreviewExpanded' 'OptionalBooleanValue' 'PreviewHeight' 'NoCode' 'CodeExpanded' 'MethodAnnotation' 'MethodAnnotationItems' 'MethodAnnotationItem' 'MethodName' 'ChangesAnnotation' 'ChangesAnnotationItems' 'ChangesAnnotationItem' 'Path' 'PageAnnotation' 'PageAnnotationItems' 'PageAnnotationItem' 'Db' 'SwitchToUuid' 'SwitchToPath' 'PageLabel' 'TodoAnnotation' 'TodoAnnotationItems' 'TodoAnnotationItem' 'Completed' 'Due' 'E O F' 'error')
]

{ #category : #generated }
LeAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeClassAnnotationNode #LeClassAnnotationNode #OrderedCollection #LeArgumentNode #LeHeightArgumentNode #LeShowArgumentNode #LeExpandedArgumentNode #LeFullArgumentNode #LeLabelArgumentNode nil nil #LeClassNameArgumentNode #LeExampleAnnotationNode #OrderedCollection #LeArgumentNode #LeReturnArgumentNode #LeAlignmentArgumentNode #LePreviewShowArgumentNode #LePreviewExpandedArgumentNode #OrderedCollection #LePreviewHeightArgumentNode #LeNoCodeArgumentNode #LeCodeExpandedArgumentNode #LeMethodAnnotationNode #OrderedCollection #LeArgumentNode #LeMethodNameArgumentNode #LeChangesAnnotationNode #OrderedCollection #LeArgumentNode #LeFileNameArgumentNode #LePageAnnotationNode #OrderedCollection #LeArgumentNode #LeDbArgumentNode nil nil #LePageArgumentNode #LeTodoAnnotationNode #OrderedCollection #LeArgumentNode #LeDateArgumentNode #LeDateArgumentNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeAnnotationParser class >> transitionTable [
^#(
#[1 0 29 0 1 0 33 0 7 0 37 0 9 0 41 0 10 0 45 0 11 0 49 0 13 0 53 0 14 0 57 0 35 0 61 0 36 0 65 0 37 0 65 0 38 0 65 0 39 0 65 0 40 0 65 0 41 0 65 0 42 0 65 0 45] 
#[1 0 93 0 1 0 97 0 7 0 37 0 9 0 45 0 11 0 101 0 16 0 105 0 17 0 109 0 18 0 113 0 19 0 117 0 20 0 121 0 21 0 125 0 23 0 145 0 40 0 145 0 42 0 137 0 46 0 141 0 47 0 145 0 48 0 145 0 49 0 145 0 50 0 145 0 51 0 145 0 52 0 145 0 54 0 145 0 55 0 145 0 56 0 145 0 60] 
#[1 0 93 0 1 0 97 0 7 0 37 0 9 0 45 0 11 0 49 0 13 0 53 0 14 0 205 0 38 0 205 0 39 0 205 0 40 0 205 0 42 0 197 0 57 0 201 0 58 0 205 0 59 0 205 0 60] 
#[1 0 213 0 7 0 45 0 11 0 49 0 13 0 53 0 14 0 217 0 28 0 241 0 38 0 241 0 39 0 241 0 40 0 233 0 61 0 237 0 62 0 241 0 63 0 241 0 64] 
#[1 0 249 0 9 0 253 0 28 1 1 0 29 1 5 0 65 1 9 0 66 1 13 0 67 1 13 0 68 1 13 0 71] 
#[1 0 37 0 9 1 25 0 31 1 29 0 32 1 45 0 42 1 37 0 72 1 41 0 73 1 45 0 74 1 45 0 75 1 45 0 76] 
#[1 0 6 0 15 1 57 0 27 0 6 0 77] 
#[0 1 61 0 8] 
#[1 0 10 0 8 1 65 0 44] 
#[1 1 69 0 8 0 14 0 15 1 73 0 53 0 14 0 77] 
#[1 1 69 0 8 0 14 0 15 1 77 0 53 0 14 0 77] 
#[0 1 81 0 8] 
#[0 1 85 0 8] 
#[0 0 0 0 77] 
#[1 1 89 0 15 0 18 0 77] 
#[0 0 22 0 15 0 77] 
#[0 0 26 0 15 0 77] 
#[0 0 30 0 15 0 77] 
#[0 0 34 0 15 0 77] 
#[0 0 38 0 15 0 77] 
#[0 0 42 0 15 0 77] 
#[0 0 46 0 15 0 77] 
#[1 1 93 0 22 1 97 0 27] 
#[0 1 101 0 8] 
#[0 1 105 0 8] 
#[0 1 109 0 8] 
#[0 1 113 0 8] 
#[1 1 69 0 8 0 14 0 15 1 117 0 53 0 14 0 77] 
#[0 1 121 0 8] 
#[1 1 69 0 8 0 14 0 15 1 125 0 53 0 14 0 77] 
#[1 1 69 0 8 0 14 0 15 1 129 0 53 0 14 0 77] 
#[0 0 50 0 15 0 77] 
#[0 0 54 0 15 0 77] 
#[0 0 0 0 77] 
#[1 1 133 0 15 0 58 0 77] 
#[0 0 62 0 15 0 77] 
#[0 0 66 0 15 0 77] 
#[0 0 70 0 15 0 77] 
#[0 0 74 0 15 0 77] 
#[0 0 78 0 15 0 77] 
#[0 0 82 0 15 0 77] 
#[0 0 86 0 15 0 77] 
#[0 0 90 0 15 0 77] 
#[0 0 94 0 15 0 77] 
#[0 0 98 0 15 0 77] 
#[0 0 102 0 15 0 77] 
#[0 0 106 0 15 0 77] 
#[0 0 110 0 15 0 77] 
#[0 0 0 0 77] 
#[1 1 137 0 15 0 114 0 77] 
#[0 0 118 0 15 0 77] 
#[0 0 122 0 15 0 77] 
#[0 1 141 0 8] 
#[0 0 126 0 15 0 77] 
#[0 0 130 0 15 0 77] 
#[0 0 134 0 15 0 77] 
#[0 0 138 0 15 0 77] 
#[0 0 0 0 77] 
#[1 1 145 0 15 0 142 0 77] 
#[0 0 146 0 15 0 77] 
#[0 0 150 0 15 0 77] 
#[0 1 149 0 8] 
#[0 0 154 0 15 0 77] 
#[1 0 158 0 8 1 153 0 69] 
#[0 0 0 0 77] 
#[1 1 157 0 15 0 162 0 77] 
#[0 0 166 0 15 0 77] 
#[0 0 170 0 15 0 77] 
#[0 0 174 0 15 0 77] 
#[0 1 161 0 8] 
#[0 1 165 0 8] 
#[0 0 178 0 15 0 77] 
#[0 0 0 0 77] 
#[1 1 169 0 15 0 182 0 77] 
#[0 0 186 0 15 0 77] 
#[0 0 190 0 15 0 77] 
#[0 0 194 0 15 0 77] 
#[0 0 198 0 15 0 77] 
#[0 1 173 0 1] 
#[0 1 177 0 8] 
#[1 1 181 0 12 0 202 0 15 0 202 0 77] 
#[0 0 206 0 15 0 77] 
#[0 0 210 0 15 0 77] 
#[0 1 185 0 3] 
#[0 1 189 0 4] 
#[1 0 29 0 1 0 33 0 7 0 37 0 9 0 41 0 10 0 45 0 11 0 49 0 13 0 53 0 14 1 193 0 37 1 193 0 38 1 193 0 39 1 193 0 40 1 193 0 41 1 193 0 42 1 193 0 45] 
#[0 1 197 0 3] 
#[0 1 201 0 22] 
#[0 1 205 0 1] 
#[0 1 209 0 2] 
#[1 1 213 0 24 1 217 0 25 1 221 0 26] 
#[0 1 225 0 3] 
#[0 0 214 0 15 0 77] 
#[0 1 229 0 4] 
#[0 0 218 0 15 0 77] 
#[0 0 222 0 15 0 77] 
#[1 0 93 0 1 0 97 0 7 0 37 0 9 0 45 0 11 0 101 0 16 0 105 0 17 0 109 0 18 0 113 0 19 0 117 0 20 0 121 0 21 0 125 0 23 1 233 0 40 1 233 0 42 1 233 0 48 1 233 0 49 1 233 0 50 1 233 0 51 1 233 0 52 1 233 0 54 1 233 0 55 1 233 0 56 1 233 0 60] 
#[1 0 93 0 1 0 97 0 7 0 37 0 9 0 45 0 11 0 49 0 13 0 53 0 14 1 237 0 38 1 237 0 39 1 237 0 40 1 237 0 42 1 237 0 59 1 237 0 60] 
#[0 1 241 0 28] 
#[1 0 213 0 7 0 45 0 11 0 49 0 13 0 53 0 14 0 217 0 28 1 245 0 38 1 245 0 39 1 245 0 40 1 245 0 63 1 245 0 64] 
#[0 1 249 0 28] 
#[0 1 253 0 8] 
#[1 0 249 0 9 0 253 0 28 1 1 0 29 2 1 0 67 2 1 0 68 2 1 0 71] 
#[1 0 226 0 15 2 5 0 33 0 226 0 77] 
#[1 0 230 0 15 2 9 0 33 0 230 0 77] 
#[1 0 37 0 9 1 25 0 31 1 29 0 32 2 13 0 42 2 13 0 74 2 13 0 75 2 13 0 76] 
#[1 0 234 0 15 2 17 0 27 0 234 0 77] 
#[1 0 238 0 5 2 21 0 43] 
#[0 0 242 0 15 0 77] 
#[0 0 246 0 15 0 77] 
#[0 0 250 0 15 0 77] 
#[0 0 254 0 15 0 77] 
#[0 1 2 0 15 0 77] 
#[0 2 25 0 3] 
#[1 2 29 0 22 2 33 0 27] 
#[0 1 6 0 15 0 77] 
#[0 1 10 0 15 0 77] 
#[0 1 14 0 15 0 77] 
#[0 1 18 0 15 0 77] 
#[0 1 22 0 15 0 77] 
#[0 1 26 0 15 0 77] 
#[0 1 30 0 15 0 77] 
#[0 1 34 0 15 0 77] 
#[0 1 38 0 15 0 77] 
#[0 1 42 0 15 0 77] 
#[0 1 46 0 15 0 77] 
#[1 1 50 0 30 2 37 0 70] 
#[0 1 54 0 15 0 77] 
#[0 1 58 0 15 0 77] 
#[0 1 62 0 15 0 77] 
#[0 1 66 0 15 0 77] 
#[0 1 70 0 15 0 77] 
#[0 2 41 0 5] 
#[0 1 74 0 15 0 77] 
#[0 2 45 0 3] 
#[0 2 49 0 22] 
#[0 2 53 0 30] 
#[0 1 78 0 15 0 77] 
#[0 1 82 0 15 0 77] 
#[0 2 57 0 3] 
#[0 1 86 0 15 0 77] 
#[0 1 90 0 15 0 77]
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
LeAnnotationParser >> reduceActionForClassAnnotationItems1: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 1).
	self add: (nodes at: 3) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForClassAnnotationItems2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 2).
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
	result := LePageArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeAnnotationParser >> reduceActionForPageLabel2: nodes [
	| result |
	result := LePageArgumentNode new.
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

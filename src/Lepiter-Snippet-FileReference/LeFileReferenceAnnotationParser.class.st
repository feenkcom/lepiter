Class {
	#name : #LeFileReferenceAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #'generated-accessing' }
LeFileReferenceAnnotationParser class >> cacheId [
	^'2026-02-27T07:16:28.044648-06:00'
]

{ #category : #generated }
LeFileReferenceAnnotationParser class >> definitionComment [
"%root FileReferenceParse;
%prefix Le;
%suffix Node;
%hierarchy FileReferenceArgument (FileReferencePath FileReferenceLabel FileReferenceRange FileReferenceExpanded FileReferenceHeight);
%glr;

<whitespace>
	: \s+
	;
<bareValue>
	: \d+[^|}\s=:][^|}\s=:]*|[^\d|}\s=:][^|}\s=:]*
	;
<quotedValue>
	: \""(\""\""|[^\""])*\""
	;
<integer>
	: \d+
	;

FileReferenceAnnotation 
	: Item 'item' (""|"" 'bar' Item 'item')* ""|"" 'bar'? {{}}
	;
Item
	: Label
	| Range
	| Expanded
	| Height
	| Path
	;
Path
	: ""path"" 'name' ""="" 'equals' Value 'value' {{FileReferencePath}}
	| Value 'value' {{FileReferencePath}}
	;
Label
	: ""label"" 'name' ""="" 'equals' Value 'value' {{FileReferenceLabel}}
	;
Value
	: <quotedValue>
	| <bareValue>
	;
Range
	: ""range"" 'name' ""="" 'equals' <integer> 'start' "":"" 'colon' <integer> 'end' {{FileReferenceRange}}
	;
Expanded
	: ""expanded"" 'name' (""="" 'equals' ExpandedValue 'value')? {{FileReferenceExpanded}}
	;
ExpandedValue
	: ""true""
	| ""false""
	;
Height
	: ""height"" 'name' ""="" 'equals' <integer> 'value' {{FileReferenceHeight}}
	;"
]

{ #category : #'class initialization' }
LeFileReferenceAnnotationParser class >> initialize [
	LeParser annotationParsers
		at: 'gtFileReference'
		put: [ :parser | parser spawnParser: self startingAt: self startingStateForFileReferenceAnnotation ]
]

{ #category : #'class initialization' }
LeFileReferenceAnnotationParser class >> obsolete [
	LeParser annotationParsers removeKey: 'gtFileReference' ifAbsent: [  ].
	^ super obsolete
]

{ #category : #generated }
LeFileReferenceAnnotationParser class >> reduceTable [
^#(
	#(24 1 #reduceActionForExpanded1: 838657 false) 
	#(22 1 #liftFirstValue: 685058 false) 
	#(22 1 #liftFirstValue: 685057 false) 
	#(18 0 #reduceActionFor______bar__Item__item___1: 388097 false) 
	#(19 1 #liftFirstValue: 433157 false) 
	#(19 1 #liftFirstValue: 433153 false) 
	#(20 1 #reduceActionForPath2: 490498 false) 
	#(19 1 #liftFirstValue: 433154 false) 
	#(19 1 #liftFirstValue: 433155 false) 
	#(19 1 #liftFirstValue: 433156 false) 
	#(16 2 #reduceActionForFileReferenceAnnotation1: 347137 false) 
	#(25 1 #liftFirstValue: 937986 false) 
	#(25 1 #liftFirstValue: 937985 false) 
	#(24 3 #reduceActionForExpanded2: 838658 false) 
	#(26 3 #reduceActionForHeight1: 976897 false) 
	#(21 3 #reduceActionForLabel1: 606209 false) 
	#(20 3 #reduceActionForPath1: 490497 false) 
	#(16 3 #reduceActionForFileReferenceAnnotation2: 347138 false) 
	#(18 2 #reduceActionFor______bar__Item__item___2: 388098 false) 
	#(17 2 #reduceActionFor______bar__Item__item__1: 388097 false) 
	#(23 5 #reduceActionForRange1: 727041 false)
	).
]

{ #category : #'generated-accessing' }
LeFileReferenceAnnotationParser class >> scannerClass [
	^LeFileReferenceAnnotationScanner
]

{ #category : #generated }
LeFileReferenceAnnotationParser class >> startingStateForFileReferenceAnnotation [
	^ 1
]

{ #category : #generated }
LeFileReferenceAnnotationParser class >> symbolNames [
	^ #('":"' '"="' '"expanded"' '"false"' '"height"' '"label"' '"path"' '"range"' '"true"' '"|"' '<whitespace>' '<bareValue>' '<quotedValue>' '<integer>' 'B e g i n' 'FileReferenceAnnotation' '("|" ''bar'' Item ''item'')' '("|" ''bar'' Item ''item'')*' 'Item' 'Path' 'Label' 'Value' 'Range' 'Expanded' 'ExpandedValue' 'Height' 'E O F' 'error')
]

{ #category : #generated }
LeFileReferenceAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeFileReferenceAnnotationNode #LeFileReferenceAnnotationNode #OrderedCollection #OrderedCollection #LeFileReferenceArgumentNode #LeFileReferencePathNode #LeFileReferenceLabelNode #SmaCCToken #LeFileReferenceRangeNode #LeFileReferenceExpandedNode #SmaCCToken #LeFileReferenceHeightNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeFileReferenceAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 3 0 13 0 5 0 17 0 6 0 21 0 7 0 25 0 8 0 53 0 12 0 53 0 13 0 37 0 16 0 41 0 19 0 41 0 20 0 41 0 21 0 53 0 22 0 41 0 23 0 41 0 24 0 41 0 26] 
#[1 0 69 0 2 0 6 0 10 0 6 0 27] 
#[0 0 73 0 2] 
#[0 0 77 0 2] 
#[0 0 81 0 2] 
#[0 0 85 0 2] 
#[0 0 10 0 10 0 27] 
#[0 0 14 0 10 0 27] 
#[0 0 0 0 27] 
#[1 0 18 0 10 0 89 0 18 0 18 0 27] 
#[0 0 22 0 10 0 27] 
#[0 0 26 0 10 0 27] 
#[0 0 30 0 10 0 27] 
#[0 0 34 0 10 0 27] 
#[0 0 38 0 10 0 27] 
#[0 0 42 0 10 0 27] 
#[0 0 101 0 4 0 9 0 25] 
#[0 0 105 0 14] 
#[0 0 109 0 12 0 13 0 22] 
#[0 0 113 0 12 0 13 0 22] 
#[0 0 117 0 14] 
#[1 0 121 0 10 0 125 0 17 0 46 0 27] 
#[0 0 50 0 10 0 27] 
#[0 0 54 0 10 0 27] 
#[0 0 58 0 10 0 27] 
#[0 0 62 0 10 0 27] 
#[0 0 66 0 10 0 27] 
#[0 0 70 0 10 0 27] 
#[0 0 129 0 1] 
#[1 0 9 0 3 0 13 0 5 0 17 0 6 0 21 0 7 0 25 0 8 0 53 0 12 0 53 0 13 0 133 0 19 0 133 0 20 0 133 0 21 0 53 0 22 0 133 0 23 0 133 0 24 0 133 0 26 0 74 0 27] 
#[0 0 78 0 10 0 27] 
#[0 0 137 0 14] 
#[0 0 82 0 10 0 27] 
#[0 0 86 0 10 0 27]
	).
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForExpanded1: nodes [
	| result |
	result := LeFileReferenceExpandedNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForExpanded2: nodes [
	| result |
	result := LeFileReferenceExpandedNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForFileReferenceAnnotation1: nodes [
	| result |
	result := LeFileReferenceAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForFileReferenceAnnotation2: nodes [
	| result |
	result := LeFileReferenceAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	result addToken: (nodes at: 3) to: result bars.
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForHeight1: nodes [
	| result |
	result := LeFileReferenceHeightNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForLabel1: nodes [
	| result |
	result := LeFileReferenceLabelNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForPath1: nodes [
	| result |
	result := LeFileReferencePathNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForPath2: nodes [
	| result |
	result := LeFileReferencePathNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionForRange1: nodes [
	| result |
	result := LeFileReferenceRangeNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result start: (nodes at: 3).
	result colon: (nodes at: 4).
	result end: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionFor______bar__Item__item__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionFor______bar__Item__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeFileReferenceAnnotationParser >> reduceActionFor______bar__Item__item___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #testing }
LeFileReferenceAnnotationParser >> tryAllTokens [
	^ true
]

{ #category : #testing }
LeFileReferenceAnnotationParser >> useAllTokenIds [
	^ false
]

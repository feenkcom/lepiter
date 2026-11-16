Class {
	#name : #LeWordAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #'generated-accessing' }
LeWordAnnotationParser class >> cacheId [
	^'2021-12-07T12:09:11.210953-06:00'
]

{ #category : #generated }
LeWordAnnotationParser class >> definitionComment [
"%glr;


%root WordParse;
%prefix Le;
%suffix Node;
%hierarchy WordArgument (WordExpanded WordHeight WordValue);
<word>
	: <isLetter>+
	;
<whitespace>
	: \s+
	;
<integer>
	: \d+
	;WordAnnotation 
	: Item 'item' (""|"" 'bar' Item 'item')* ""|"" 'bar'? {{}}
	;
Item
	: Word
	| Expanded
	| Height
	;
Height
	: ""height"" 'name' ""="" 'equals' <integer> 'value' {{WordHeight}}
	;
Word
	: (""word"" 'name' ""="" 'equals')? <word> 'value' {{WordValue}}
	| ""word"" 'value' {{WordValue}}
	;
Expanded
	: ""expanded"" 'name' (""="" 'equals' (""true"" 'value' | ""false"" 'value'))? {{WordExpanded}}
	;"
]

{ #category : #initialization }
LeWordAnnotationParser class >> initialize [
	LeParser annotationParsers
		at: 'gtWordExplanation'
		put: [ :parser | parser spawnParser: self startingAt: self startingStateForWordAnnotation ]
]

{ #category : #initialization }
LeWordAnnotationParser class >> obsolete [
	LeParser annotationParsers removeKey: 'gtWordExplanation' ifAbsent: [  ].
	^ super obsolete
]

{ #category : #generated }
LeWordAnnotationParser class >> reduceTable [
^#(
	#(18 1 #reduceActionForExpanded1: 481281 false) 
	#(17 1 #reduceActionForWord3: 376835 false) 
	#(17 1 #reduceActionForWord3: 376833 false) 
	#(14 0 #reduceActionFor______bar__Item__item___1: 216065 false) 
	#(15 1 #liftFirstValue: 261123 false) 
	#(15 1 #liftFirstValue: 261121 false) 
	#(15 1 #liftFirstValue: 261122 false) 
	#(12 2 #reduceActionForWordAnnotation1: 184321 false) 
	#(18 3 #reduceActionForExpanded3: 481283 false) 
	#(18 3 #reduceActionForExpanded3: 481282 false) 
	#(16 3 #reduceActionForHeight1: 300033 false) 
	#(17 3 #reduceActionForWord2: 376834 false) 
	#(12 3 #reduceActionForWordAnnotation2: 184322 false) 
	#(14 2 #reduceActionFor______bar__Item__item___2: 216066 false) 
	#(13 2 #reduceActionFor______bar__Item__item__1: 216065 false)
	).
]

{ #category : #generated }
LeWordAnnotationParser class >> scannerClass [
	^LeWordAnnotationScanner
]

{ #category : #generated }
LeWordAnnotationParser class >> startingStateForWordAnnotation [
	^ 1
]

{ #category : #generated }
LeWordAnnotationParser class >> symbolNames [
	^ #('"="' '"expanded"' '"false"' '"height"' '"true"' '"word"' '"|"' '<word>' '<whitespace>' '<integer>' 'B e g i n' 'WordAnnotation' '("|" ''bar'' Item ''item'')' '("|" ''bar'' Item ''item'')*' 'Item' 'Height' 'Word' 'Expanded' 'E O F' 'error')
]

{ #category : #generated }
LeWordAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeWordAnnotationNode #LeWordAnnotationNode #OrderedCollection #OrderedCollection #LeWordArgumentNode #LeWordHeightNode #LeWordValueNode #LeWordExpandedNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeWordAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 4 0 17 0 6 0 21 0 8 0 25 0 12 0 29 0 15 0 29 0 16 0 29 0 17 0 29 0 18] 
#[1 0 45 0 1 0 6 0 7 0 6 0 19] 
#[0 0 49 0 1] 
#[1 0 53 0 1 0 10 0 7 0 10 0 19] 
#[0 0 14 0 7 0 19] 
#[0 0 0 0 19] 
#[1 0 18 0 7 0 57 0 14 0 18 0 19] 
#[0 0 22 0 7 0 19] 
#[0 0 26 0 7 0 19] 
#[0 0 30 0 7 0 19] 
#[1 0 61 0 3 0 65 0 5] 
#[0 0 69 0 10] 
#[0 0 73 0 8] 
#[1 0 77 0 7 0 81 0 13 0 34 0 19] 
#[0 0 38 0 7 0 19] 
#[0 0 42 0 7 0 19] 
#[0 0 46 0 7 0 19] 
#[0 0 50 0 7 0 19] 
#[1 0 9 0 2 0 13 0 4 0 17 0 6 0 21 0 8 0 85 0 15 0 85 0 16 0 85 0 17 0 85 0 18 0 54 0 19] 
#[0 0 58 0 7 0 19] 
#[0 0 62 0 7 0 19]
	).
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionForExpanded1: nodes [
	| result |
	result := LeWordExpandedNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionForExpanded3: nodes [
	| result |
	result := LeWordExpandedNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionForHeight1: nodes [
	| result |
	result := LeWordHeightNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionForWord2: nodes [
	| result |
	result := LeWordValueNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionForWord3: nodes [
	| result |
	result := LeWordValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionForWordAnnotation1: nodes [
	| result |
	result := LeWordAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionForWordAnnotation2: nodes [
	| result |
	result := LeWordAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	result addToken: (nodes at: 3) to: result bars.
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionFor______bar__Item__item__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionFor______bar__Item__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeWordAnnotationParser >> reduceActionFor______bar__Item__item___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #testing }
LeWordAnnotationParser >> tryAllTokens [
	^ true
]

{ #category : #testing }
LeWordAnnotationParser >> useAllTokenIds [
	^ false
]

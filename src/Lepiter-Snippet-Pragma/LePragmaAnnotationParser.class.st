Class {
	#name : #LePragmaAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #'generated-accessing' }
LePragmaAnnotationParser class >> cacheId [
	^'2026-03-05T13:18:40.885778+01:00'
]

{ #category : #generated }
LePragmaAnnotationParser class >> definitionComment [
"%prefix Le;
%suffix Node;
%hierarchy PragmaArgument (PragmaName PragmaExpanded);
%root PragmaParse;
<whitespace>
	: \s+
	;
<lemma>
	: (<isLetter> | <isDigit> | "":"" | ""_"")+ 
	;
PragmaAnnotation 
	: Item 'item' ( ""|"" 'bar' Item 'item' )* ""|"" 'bar'? {{}}
	;
Item
	: Pragma
	| Expanded
	;
Pragma
	: (""pragma"" 'name' ""="" 'equals')? <lemma> 'value' {{PragmaName}}
	| ""pragma"" 'value' {{PragmaName}}
	;
Expanded
	: ""expanded"" 'name' (""="" 'equals' (""true"" 'value' | ""false"" 'value')?)? {{PragmaExpanded}}
	;"
]

{ #category : #initialization }
LePragmaAnnotationParser class >> initialize [
	LeParser annotationParsers
		at: 'gtPragma'
		put: [ :parser | parser spawnParser: self startingAt: self startingStateForPragmaAnnotation ]
]

{ #category : #initialization }
LePragmaAnnotationParser class >> obsolete [
	LeParser annotationParsers removeKey: 'gtPragma' ifAbsent: [  ].
	^ super obsolete
]

{ #category : #parsing }
LePragmaAnnotationParser class >> parseEmbeddedStream: aStream startingAt: anInteger [
	^ super parseEmbeddedStream: aStream startingAt: anInteger
]

{ #category : #generated }
LePragmaAnnotationParser class >> reduceTable [
^#(
	#(15 1 #reduceActionForExpanded1: 407553 false) 
	#(14 1 #reduceActionForPragma3: 293891 false) 
	#(14 1 #reduceActionForPragma3: 293889 false) 
	#(12 0 #reduceActionFor_______bar__Item__item____1: 216065 false) 
	#(13 1 #liftFirstValue: 263169 false) 
	#(13 1 #liftFirstValue: 263170 false) 
	#(15 2 #reduceActionForExpanded2: 407554 false) 
	#(10 2 #reduceActionForPragmaAnnotation1: 182273 false) 
	#(15 3 #reduceActionForExpanded3: 407556 false) 
	#(15 3 #reduceActionForExpanded3: 407555 false) 
	#(14 3 #reduceActionForPragma2: 293890 false) 
	#(10 3 #reduceActionForPragmaAnnotation2: 182274 false) 
	#(12 2 #reduceActionFor_______bar__Item__item____2: 216066 false) 
	#(11 2 #reduceActionFor_______bar__Item__item___1: 216065 false)
	).
]

{ #category : #'generated-accessing' }
LePragmaAnnotationParser class >> scannerClass [
	^LePragmaAnnotationScanner
]

{ #category : #generated }
LePragmaAnnotationParser class >> startingStateForPragmaAnnotation [
	^ 1
]

{ #category : #generated }
LePragmaAnnotationParser class >> symbolNames [
	^ #('"="' '"expanded"' '"false"' '"pragma"' '"true"' '"|"' '<whitespace>' '<lemma>' 'B e g i n' 'PragmaAnnotation' '( "|" ''bar'' Item ''item'' )' '( "|" ''bar'' Item ''item'' )*' 'Item' 'Pragma' 'Expanded' 'E O F' 'error')
]

{ #category : #generated }
LePragmaAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LePragmaAnnotationNode #LePragmaAnnotationNode #OrderedCollection #OrderedCollection #LePragmaArgumentNode #LePragmaNameNode #LePragmaExpandedNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LePragmaAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 4 0 17 0 8 0 21 0 10 0 25 0 13 0 25 0 14 0 25 0 15] 
#[1 0 37 0 1 0 6 0 6 0 6 0 16] 
#[1 0 41 0 1 0 10 0 6 0 10 0 16] 
#[0 0 14 0 6 0 16] 
#[0 0 0 0 16] 
#[1 0 18 0 6 0 45 0 12 0 18 0 16] 
#[0 0 22 0 6 0 16] 
#[0 0 26 0 6 0 16] 
#[1 0 49 0 3 0 53 0 5 0 30 0 6 0 30 0 16] 
#[0 0 57 0 8] 
#[1 0 61 0 6 0 65 0 11 0 34 0 16] 
#[0 0 38 0 6 0 16] 
#[0 0 42 0 6 0 16] 
#[0 0 46 0 6 0 16] 
#[1 0 9 0 2 0 13 0 4 0 17 0 8 0 69 0 13 0 69 0 14 0 69 0 15 0 50 0 16] 
#[0 0 54 0 6 0 16] 
#[0 0 58 0 6 0 16]
	).
]

{ #category : #private }
LePragmaAnnotationParser >> reduceActionForExpanded1: nodes [
	| result |
	result := LePragmaExpandedNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LePragmaAnnotationParser >> reduceActionForExpanded2: nodes [
	| result |
	result := LePragmaExpandedNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	^ result
]

{ #category : #private }
LePragmaAnnotationParser >> reduceActionForExpanded3: nodes [
	| result |
	result := LePragmaExpandedNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #private }
LePragmaAnnotationParser >> reduceActionForPragma2: nodes [
	| result |
	result := LePragmaNameNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #private }
LePragmaAnnotationParser >> reduceActionForPragma3: nodes [
	| result |
	result := LePragmaNameNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LePragmaAnnotationParser >> reduceActionForPragmaAnnotation1: nodes [
	| result |
	result := LePragmaAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LePragmaAnnotationParser >> reduceActionForPragmaAnnotation2: nodes [
	| result |
	result := LePragmaAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	result addToken: (nodes at: 3) to: result bars.
	^ result
]

{ #category : #'generated-reduction actions' }
LePragmaAnnotationParser >> reduceActionFor_______bar__Item__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LePragmaAnnotationParser >> reduceActionFor_______bar__Item__item____1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LePragmaAnnotationParser >> reduceActionFor_______bar__Item__item____2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #parsing }
LePragmaAnnotationParser >> tryAllTokens [
	"Required by embedded parsing in GLR."
	^ true
]

{ #category : #parsing }
LePragmaAnnotationParser >> useAllTokenIds [
	"Required by embedded parsing in GLR."
	^ true
]

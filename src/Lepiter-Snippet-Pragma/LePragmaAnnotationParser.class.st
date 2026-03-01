Class {
	#name : #LePragmaAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #'generated-accessing' }
LePragmaAnnotationParser class >> cacheId [
	^'2026-03-01T15:35:59.305099+01:00'
]

{ #category : #generated }
LePragmaAnnotationParser class >> definitionComment [
"%glr;
%prefix Le;
%suffix Node;
%hierarchy PragmaArgument (PragmaName);
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
	;
Pragma
	: (""pragma"" 'name' ""="" 'equals')? <lemma> 'value' {{PragmaName}}
	| ""pragma"" 'value' {{PragmaName}}
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

{ #category : #generated }
LePragmaAnnotationParser class >> reduceTable [
^#(
	#(11 1 #reduceActionForPragma3: 273411 false) 
	#(11 1 #reduceActionForPragma3: 273409 false) 
	#(9 0 #reduceActionFor_______bar__Item__item____1: 207873 false) 
	#(10 1 #liftFirstValue: 254977 false) 
	#(7 2 #reduceActionForPragmaAnnotation1: 174081 false) 
	#(11 3 #reduceActionForPragma2: 273410 false) 
	#(7 3 #reduceActionForPragmaAnnotation2: 174082 false) 
	#(9 2 #reduceActionFor_______bar__Item__item____2: 207874 false) 
	#(8 2 #reduceActionFor_______bar__Item__item___1: 207873 false)
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
	^ #('"="' '"pragma"' '"|"' '<whitespace>' '<lemma>' 'B e g i n' 'PragmaAnnotation' '( "|" ''bar'' Item ''item'' )' '( "|" ''bar'' Item ''item'' )*' 'Item' 'Pragma' 'E O F' 'error')
]

{ #category : #generated }
LePragmaAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LePragmaAnnotationNode #LePragmaAnnotationNode #OrderedCollection #OrderedCollection #LePragmaNameNode #LePragmaNameNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LePragmaAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 5 0 17 0 7 0 21 0 10 0 21 0 11] 
#[1 0 29 0 1 0 6 0 3 0 6 0 12] 
#[0 0 10 0 3 0 12] 
#[0 0 0 0 12] 
#[1 0 14 0 3 0 33 0 9 0 14 0 12] 
#[0 0 18 0 3 0 12] 
#[0 0 37 0 5] 
#[1 0 41 0 3 0 45 0 8 0 22 0 12] 
#[0 0 26 0 3 0 12] 
#[1 0 9 0 2 0 13 0 5 0 49 0 10 0 49 0 11 0 30 0 12] 
#[0 0 34 0 3 0 12] 
#[0 0 38 0 3 0 12]
	).
]

{ #category : #'generated-reduction actions' }
LePragmaAnnotationParser >> reduceActionForPragma2: nodes [
	| result |
	result := LePragmaNameNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
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

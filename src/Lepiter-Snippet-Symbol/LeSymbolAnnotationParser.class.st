Class {
	#name : #LeSymbolAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #'generated-accessing' }
LeSymbolAnnotationParser class >> cacheId [
	^'2026-03-07T17:54:42.324867+01:00'
]

{ #category : #generated }
LeSymbolAnnotationParser class >> definitionComment [
"%prefix Le;
%suffix Node;
%root SymbolParse;
%glr;
<lemma>
	: (<isLetter> | <isDigit> | "":"" | ""_"" | ""-"")+ 
	;
<whitespace>
	: \s+
	;
SymbolAnnotation
	: Symbol 'symbol' {{}}
	;
Symbol
	: (""symbol"" 'name' ""="" 'equals')? <lemma> 'value' {{SymbolName}}
	| ""symbol"" 'value' {{SymbolName}}
	;"
]

{ #category : #initialization }
LeSymbolAnnotationParser class >> initialize [
	LeParser annotationParsers
		at: 'gtSymbol'
		put: [ :parser | parser spawnParser: self startingAt: self startingStateForSymbolAnnotation ]
]

{ #category : #initialization }
LeSymbolAnnotationParser class >> obsolete [
	LeParser annotationParsers removeKey: 'gtSymbol' ifAbsent: [  ].
	^ super obsolete
]

{ #category : #parsing }
LeSymbolAnnotationParser class >> parseEmbeddedStream: aStream startingAt: anInteger [
	^ super parseEmbeddedStream: aStream startingAt: anInteger
]

{ #category : #generated }
LeSymbolAnnotationParser class >> reduceTable [
^#(
	#(7 1 #reduceActionForSymbol3: 183299 false) 
	#(7 1 #reduceActionForSymbol3: 183297 false) 
	#(6 1 #reduceActionForSymbolAnnotation1: 138241 false) 
	#(7 3 #reduceActionForSymbol2: 183298 false)
	).
]

{ #category : #'generated-accessing' }
LeSymbolAnnotationParser class >> scannerClass [
	^LeSymbolAnnotationScanner
]

{ #category : #generated }
LeSymbolAnnotationParser class >> startingStateForSymbolAnnotation [
	^ 1
]

{ #category : #generated }
LeSymbolAnnotationParser class >> symbolNames [
	^ #('"="' '"symbol"' '<lemma>' '<whitespace>' 'B e g i n' 'SymbolAnnotation' 'Symbol' 'E O F' 'error')
]

{ #category : #generated }
LeSymbolAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeSymbolAnnotationNode #LeSymbolAnnotationNode #LeSymbolNameNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeSymbolAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 3 0 17 0 6 0 21 0 7] 
#[1 0 25 0 1 0 6 0 8] 
#[0 0 10 0 8] 
#[0 0 0 0 8] 
#[0 0 14 0 8] 
#[0 0 29 0 3] 
#[0 0 18 0 8]
	).
]

{ #category : #'generated-reduction actions' }
LeSymbolAnnotationParser >> reduceActionForSymbol2: nodes [
	| result |
	result := LeSymbolNameNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeSymbolAnnotationParser >> reduceActionForSymbol3: nodes [
	| result |
	result := LeSymbolNameNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeSymbolAnnotationParser >> reduceActionForSymbolAnnotation1: nodes [
	| result |
	result := LeSymbolAnnotationNode new.
	result symbol: (nodes at: 1).
	^ result
]

Class {
	#name : #GtShellScriptParser,
	#superclass : #SmaCCParser,
	#category : #'Lepiter-Snippet-Shell-Parser'
}

{ #category : #'generated-accessing' }
GtShellScriptParser class >> cacheId [
	^'2026-10-07T08:19:34.357574-03:00'
]

{ #category : #generated }
GtShellScriptParser class >> definitionComment [
"%prefix GtShellScript;
%suffix Node;
%root Program;

<anything>
	: .+
	;
Start
	: <anything> 'string' {{String}}
	| {{String}}
	;"
]

{ #category : #generated }
GtShellScriptParser class >> reduceTable [
^#(
	#(3 0 #reduceActionForStart2: 75778 false) 
	#(3 1 #reduceActionForStart1: 75777 false)
	).
]

{ #category : #generated }
GtShellScriptParser class >> scannerClass [
	^GtShellScriptScanner
]

{ #category : #generated }
GtShellScriptParser class >> startingStateForStart [
	^ 1
]

{ #category : #generated }
GtShellScriptParser class >> symbolNames [
	^ #('<anything>' 'B e g i n' 'Start' 'E O F' 'error')
]

{ #category : #generated }
GtShellScriptParser class >> symbolTypes [
	^ #(#SmaCCToken #GtShellScriptStringNode #GtShellScriptStringNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtShellScriptParser class >> transitionTable [
^#(
#[1 0 9 0 1 0 13 0 3 0 6 0 4] 
#[0 0 10 0 4] 
#[0 0 0 0 4]
	).
]

{ #category : #'generated-reduction actions' }
GtShellScriptParser >> reduceActionForStart1: nodes [
	| result |
	result := GtShellScriptStringNode new.
	result string: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtShellScriptParser >> reduceActionForStart2: nodes [
	| result |
	result := GtShellScriptStringNode new.
	^ result
]

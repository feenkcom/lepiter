Class {
	#name : #LePictureAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #'generated-accessing' }
LePictureAnnotationParser class >> cacheId [
	^'2025-04-01T13:32:12.808651-03:00'
]

{ #category : #generated }
LePictureAnnotationParser class >> definitionComment [
"%glr;


%root PictureParse;
%prefix Le;
%suffix Node;
%hierarchy PictureArgument (PictureReference);
<whitespace>
	: \s+
	;
<reference>
	: (<isLetter> | <isDigit>)+
	;
PictureAnnotation 
	: Item 'item' ( ""|"" 'bar' Item 'item' )* ""|"" 'bar'? {{}}
	;
Item
	: Reference
	;
Reference
	: (""reference"" 'name' ""="" 'equals')? <reference> 'value' {{PictureReference}}
	| ""reference"" 'value' {{PictureReference}}
	;"
]

{ #category : #initialization }
LePictureAnnotationParser class >> initialize [
	LeParser annotationParsers
		at: 'gtPictureReference'
		put: [ :parser | parser spawnParser: self startingAt: self startingStateForPictureAnnotation ]
]

{ #category : #initialization }
LePictureAnnotationParser class >> obsolete [
	LeParser annotationParsers removeKey: 'gtPictureReference' ifAbsent: [  ].
	^ super obsolete
]

{ #category : #generated }
LePictureAnnotationParser class >> reduceTable [
^#(
	#(11 1 #reduceActionForReference3: 276483 false) 
	#(11 1 #reduceActionForReference3: 276481 false) 
	#(9 0 #reduceActionFor_______bar__Item__item____1: 207873 false) 
	#(10 1 #liftFirstValue: 254977 false) 
	#(7 2 #reduceActionForPictureAnnotation1: 173057 false) 
	#(11 3 #reduceActionForReference2: 276482 false) 
	#(7 3 #reduceActionForPictureAnnotation2: 173058 false) 
	#(9 2 #reduceActionFor_______bar__Item__item____2: 207874 false) 
	#(8 2 #reduceActionFor_______bar__Item__item___1: 207873 false)
	).
]

{ #category : #generated }
LePictureAnnotationParser class >> scannerClass [
	^LePictureAnnotationScanner
]

{ #category : #generated }
LePictureAnnotationParser class >> startingStateForPictureAnnotation [
	^ 1
]

{ #category : #generated }
LePictureAnnotationParser class >> symbolNames [
	^ #('"="' '"reference"' '"|"' '<whitespace>' '<reference>' 'B e g i n' 'PictureAnnotation' '( "|" ''bar'' Item ''item'' )' '( "|" ''bar'' Item ''item'' )*' 'Item' 'Reference' 'E O F' 'error')
]

{ #category : #generated }
LePictureAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LePictureAnnotationNode #LePictureAnnotationNode #OrderedCollection #OrderedCollection #LePictureReferenceNode #LePictureReferenceNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LePictureAnnotationParser class >> transitionTable [
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
LePictureAnnotationParser >> reduceActionForPictureAnnotation1: nodes [
	| result |
	result := LePictureAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LePictureAnnotationParser >> reduceActionForPictureAnnotation2: nodes [
	| result |
	result := LePictureAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	result addToken: (nodes at: 3) to: result bars.
	^ result
]

{ #category : #'generated-reduction actions' }
LePictureAnnotationParser >> reduceActionForReference2: nodes [
	| result |
	result := LePictureReferenceNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LePictureAnnotationParser >> reduceActionForReference3: nodes [
	| result |
	result := LePictureReferenceNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LePictureAnnotationParser >> reduceActionFor_______bar__Item__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LePictureAnnotationParser >> reduceActionFor_______bar__Item__item____1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LePictureAnnotationParser >> reduceActionFor_______bar__Item__item____2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

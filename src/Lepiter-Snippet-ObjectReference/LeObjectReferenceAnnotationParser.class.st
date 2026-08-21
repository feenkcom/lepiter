Class {
	#name : #LeObjectReferenceAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #'generated-accessing' }
LeObjectReferenceAnnotationParser class >> cacheId [
	^'2026-08-12T15:57:58.09+02:00'
]

{ #category : #generated }
LeObjectReferenceAnnotationParser class >> definitionComment [
"%glr;

%root ObjectReferenceParse;
%prefix Le;
%suffix Node;
%hierarchy ObjectReferenceArgument (ObjectReferenceId ObjectReferenceLabel ObjectReferenceExpanded ObjectReferenceFallbackLabel ObjectReferenceShow ObjectReferenceHeight);
<id>
	: [a-z0-9\-]*[0-9][a-z0-9\-]*
	;
<selector>
	: [a-zA-Z][a-zA-Z0-9:]*
	;
<stringValue>
	: \'[^\']*\'
	;
<whitespace>
	: \s+
	;
ObjectReferenceAnnotation 
	: Item 'item' (""|"" 'bar' Item 'item')* ""|"" 'bar'? {{}}
	;
Item
	: Id
	| Label
	| Expanded
	| FallbackLabel
	| Show
	| Height
	;
Id
	: (""id"" 'name' ""="" 'equals')? <id> 'value' {{ObjectReferenceId}}
	| ""id"" 'value' {{ObjectReferenceId}}
	;
Label
	: ""label"" 'name' ""="" 'equals' ""#""? <selector> 'value' {{ObjectReferenceLabel}}
	;
Expanded
	: ""expanded"" 'name' (""="" 'equals' (""true"" 'value' | ""false"" 'value'))? {{ObjectReferenceExpanded}}
	;
FallbackLabel
	: ""fallbackLabelString"" 'name' ""="" 'equals' <stringValue> 'value' {{ObjectReferenceFallbackLabel}}
	;
Show
	: ""show"" 'name' ""="" 'equals' ""#""? <selector> 'value' {{ObjectReferenceShow}}
	;
Height
	: ""height"" 'name' ""="" 'equals' <id> 'value' {{ObjectReferenceHeight}}
	;"
]

{ #category : #generated }
LeObjectReferenceAnnotationParser class >> reduceTable [
^#(
	#(23 1 #reduceActionForExpanded1: 738305 false) 
	#(21 1 #reduceActionForId3: 534531 false) 
	#(21 1 #reduceActionForId3: 534529 false) 
	#(19 0 #reduceActionFor______bar__Item__item___1: 417793 false) 
	#(20 1 #liftFirstValue: 462849 false) 
	#(20 1 #liftFirstValue: 462850 false) 
	#(20 1 #liftFirstValue: 462851 false) 
	#(20 1 #liftFirstValue: 462852 false) 
	#(20 1 #liftFirstValue: 462853 false) 
	#(20 1 #liftFirstValue: 462854 false) 
	#(17 2 #reduceActionForObjectReferenceAnnotation1: 374785 false) 
	#(23 3 #reduceActionForExpanded3: 738307 false) 
	#(23 3 #reduceActionForExpanded3: 738306 false) 
	#(24 3 #reduceActionForFallbackLabel1: 852993 false) 
	#(26 3 #reduceActionForHeight1: 1060865 false) 
	#(21 3 #reduceActionForId2: 534530 false) 
	#(22 3 #reduceActionForLabel1: 647169 false) 
	#(25 3 #reduceActionForShow1: 972801 false) 
	#(17 3 #reduceActionForObjectReferenceAnnotation2: 374786 false) 
	#(19 2 #reduceActionFor______bar__Item__item___2: 417794 false) 
	#(22 4 #reduceActionForLabel2: 647170 false) 
	#(25 4 #reduceActionForShow2: 972802 false) 
	#(18 2 #reduceActionFor______bar__Item__item__1: 417793 false)
	).
]

{ #category : #generated }
LeObjectReferenceAnnotationParser class >> scannerClass [
	^LeObjectReferenceAnnotationScanner
]

{ #category : #generated }
LeObjectReferenceAnnotationParser class >> startingStateForObjectReferenceAnnotation [
	^1
]

{ #category : #generated }
LeObjectReferenceAnnotationParser class >> symbolNames [
	^#('"#"' '"="' '"expanded"' '"fallbackLabelString"' '"false"' '"height"' '"id"' '"label"' '"show"' '"true"' '"|"' '<id>' '<selector>' '<stringValue>' '<whitespace>' 'B e g i n' 'ObjectReferenceAnnotation' '("|" ''bar'' Item ''item'')' '("|" ''bar'' Item ''item'')*' 'Item' 'Id' 'Label' 'Expanded' 'FallbackLabel' 'Show' 'Height' 'E O F' 'error')
]

{ #category : #generated }
LeObjectReferenceAnnotationParser class >> symbolTypes [
	^#(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeObjectReferenceAnnotationNode #LeObjectReferenceAnnotationNode #OrderedCollection #OrderedCollection #LeObjectReferenceArgumentNode #LeObjectReferenceIdNode #LeObjectReferenceLabelNode #LeObjectReferenceExpandedNode #LeObjectReferenceFallbackLabelNode #LeObjectReferenceShowNode #LeObjectReferenceHeightNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeObjectReferenceAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 3 0 13 0 4 0 17 0 6 0 21 0 7 0 25 0 8 0 29 0 9 0 33 0 12 0 37 0 17 0 41 0 20 0 41 0 21 0 41 0 22 0 41 0 23 0 41 0 24 0 41 0 25 0 41 0 26] 
#[1 0 69 0 2 0 6 0 11 0 6 0 27] 
#[0 0 73 0 2] 
#[0 0 77 0 2] 
#[1 0 81 0 2 0 10 0 11 0 10 0 27] 
#[0 0 85 0 2] 
#[0 0 89 0 2] 
#[0 0 14 0 11 0 27] 
#[0 0 0 0 27] 
#[1 0 18 0 11 0 93 0 19 0 18 0 27] 
#[0 0 22 0 11 0 27] 
#[0 0 26 0 11 0 27] 
#[0 0 30 0 11 0 27] 
#[0 0 34 0 11 0 27] 
#[0 0 38 0 11 0 27] 
#[0 0 42 0 11 0 27] 
#[1 0 97 0 5 0 101 0 10] 
#[0 0 105 0 14] 
#[0 0 109 0 12] 
#[0 0 113 0 12] 
#[1 0 117 0 1 0 121 0 13] 
#[1 0 125 0 1 0 129 0 13] 
#[1 0 133 0 11 0 137 0 18 0 46 0 27] 
#[0 0 50 0 11 0 27] 
#[0 0 54 0 11 0 27] 
#[0 0 58 0 11 0 27] 
#[0 0 62 0 11 0 27] 
#[0 0 66 0 11 0 27] 
#[0 0 141 0 13] 
#[0 0 70 0 11 0 27] 
#[0 0 145 0 13] 
#[0 0 74 0 11 0 27] 
#[1 0 9 0 3 0 13 0 4 0 17 0 6 0 21 0 7 0 25 0 8 0 29 0 9 0 33 0 12 0 149 0 20 0 149 0 21 0 149 0 22 0 149 0 23 0 149 0 24 0 149 0 25 0 149 0 26 0 78 0 27] 
#[0 0 82 0 11 0 27] 
#[0 0 86 0 11 0 27] 
#[0 0 90 0 11 0 27] 
#[0 0 94 0 11 0 27]
	).
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForExpanded1: nodes [
	| result |
	result := LeObjectReferenceExpandedNode new.
	result name: (nodes at: 1).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForExpanded3: nodes [
	| result |
	result := LeObjectReferenceExpandedNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForFallbackLabel1: nodes [
	| result |
	result := LeObjectReferenceFallbackLabelNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForHeight1: nodes [
	| result |
	result := LeObjectReferenceHeightNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForId2: nodes [
	| result |
	result := LeObjectReferenceIdNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForId3: nodes [
	| result |
	result := LeObjectReferenceIdNode new.
	result value: (nodes at: 1).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForLabel1: nodes [
	| result |
	result := LeObjectReferenceLabelNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForLabel2: nodes [
	| result |
	result := LeObjectReferenceLabelNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 4).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForObjectReferenceAnnotation1: nodes [
	| result |
	result := LeObjectReferenceAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForObjectReferenceAnnotation2: nodes [
	| result |
	result := LeObjectReferenceAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	result addToken: (nodes at: 3) to: result bars.
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForShow1: nodes [
	| result |
	result := LeObjectReferenceShowNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionForShow2: nodes [
	| result |
	result := LeObjectReferenceShowNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 4).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionFor______bar__Item__item__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionFor______bar__Item__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^result
]

{ #category : #'generated-reduction actions' }
LeObjectReferenceAnnotationParser >> reduceActionFor______bar__Item__item___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^result
]

"
Examples for gtPragma completion.
"
Class {
	#name : #LePragmaAnnotationCompletionVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #examples }
LePragmaAnnotationCompletionVisitorExamples >> completeExpandedAttribute [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions position anAst anAnnotation |
	aString := '{{gtPragma:gtView|}}'.
	anAst := LeParser parse: aString.
	anAnnotation := (anAst // LePragmaAnnotationNode) anyOne.
	position := anAnnotation bars last stopPosition.

	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: (actions collect: #text) asSet equals: (Set with: 'expanded').

	^ aResult
]

{ #category : #examples }
LePragmaAnnotationCompletionVisitorExamples >> completeExpandedBoolean [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions position texts |
	aString := '{{gtPragma:gtView|expanded=}}'.
	position := aString size - 2.

	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].
	texts := actions collect: #text.

	self assert: (texts includes: 'true').
	self assert: (texts includes: 'false').

	^ aResult
]

{ #category : #examples }
LePragmaAnnotationCompletionVisitorExamples >> completePragmaAtStart [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions position |

	aString := '{{gtPragma:}}'.
	position := (aString indexOf: $}) - 1.

	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: actions notEmpty.

	^ aResult
]

{ #category : #examples }
LePragmaAnnotationCompletionVisitorExamples >> completePragmaName [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions position prefix |
	LePragmaAnnotationParser initialize.
	LePragmaAnnotationCompletionVisitor initialize.

	prefix := 'gt'.
	aString := '{{gtPragma:' , prefix , '}}'.
	position := (aString indexOf: $}) - 1.

	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: (actions anySatisfy: [ :each | (each respondsTo: #text) and: [ each text notNil ] ]).

	^ aResult
]

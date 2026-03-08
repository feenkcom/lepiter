"
Examples for gtSymbol completion.
"
Class {
	#name : #LeSymbolAnnotationCompletionVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #examples }
LeSymbolAnnotationCompletionVisitorExamples >> completeSymbolAfterColon [
	<gtExample>
	<noTest>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions position |
	aString := '{{gtSymbol:}}'.
	position := (aString indexOf: $:) + 1.
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.
	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].
	self assert: actions notEmpty.
	^ aResult
]

{ #category : #examples }
LeSymbolAnnotationCompletionVisitorExamples >> completeSymbolAtStart [
	<gtExample>
	<noTest>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions position |
	aString := '{{gtSymbol:}}'.
	position := (aString indexOf: $}) - 1.
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy
			completionResultFor: aString
			at: position
			requested: true.
	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].
	self assert: actions notEmpty.
	^ aResult
]

{ #category : #examples }
LeSymbolAnnotationCompletionVisitorExamples >> completeSymbolName [
	<gtExample>
	<noTest>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions position prefix |
	prefix := 'as'.
	aString := '{{gtSymbol:' , prefix , '}}'.
	position := (aString indexOf: $}) - 1.
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.
	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].
	self assert: (actions anySatisfy: [ :each | (each respondsTo: #text) and: [ each text notNil ] ]).
	^ aResult
]

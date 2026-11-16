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

{ #category : #'examples - registration' }
LeSymbolAnnotationCompletionVisitorExamples >> registrationIsIdempotent [
	<gtExample>
	<return: #OrderedCollection>
	| completions completionsBefore |
	completions := LeContentCompletionVisitor additionalCompletionVisitors.
	completionsBefore := completions copy.
	[ LeSymbolAnnotationCompletionVisitor
		initialize;
		initialize.
	self assert: (completions occurrencesOf: LeSymbolAnnotationCompletionVisitor) equals: 1 ]
		ensure: [ completions
				removeAll;
				addAll: completionsBefore ].
	^ completions

]

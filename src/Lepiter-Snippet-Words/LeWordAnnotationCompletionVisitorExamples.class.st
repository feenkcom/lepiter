"
Examples for gtWordExplanation completion.
"
Class {
	#name : #LeWordAnnotationCompletionVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Words'
}

{ #category : #examples }
LeWordAnnotationCompletionVisitorExamples >> completeWordAnnotationAttributePrefix [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions anAst aWordValue position texts displayTexts |
	aString := '{{gtWordExplanation:toolkit|he}}'.
	anAst := LeParser parse: aString.
	aWordValue := anAst // LeWordValueNode
			detect: [ :each | each value source = 'he' ]
			ifNone: [ nil ].
	position := aWordValue value stopPosition.

	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy
			completionResultFor: aString
			at: position
			requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].
	texts := actions collect: #text.
	displayTexts := actions collect: [ :each | each displayText asString ].

	self assert: (texts asSet includes: 'ight=').
	self assert: (displayTexts asSet includes: 'height=').
	self assert: (displayTexts asSet includes: 'expanded') not.

	^ aResult
]

{ #category : #examples }
LeWordAnnotationCompletionVisitorExamples >> completeWordAnnotationAttributes [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions anAst anAnnotation position |
	aString := '{{gtWordExplanation:toolkit|}}'.
	anAst := LeParser parse: aString.
	anAnnotation := (anAst // LeWordAnnotationNode) anyOne.
	position := anAnnotation bars last stopPosition.
	
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: (actions collect: #text) asSet equals: (Set with: 'expanded' with: 'height=').

	^ aResult
]

{ #category : #examples }
LeWordAnnotationCompletionVisitorExamples >> completeWordAnnotationHeightAfterExpanded [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions anAst anAnnotation position |
	aString := '{{gtWordExplanation:toolkit|expanded|}}'.
	anAst := LeParser parse: aString.
	anAnnotation := (anAst // LeWordAnnotationNode) anyOne.
	position := anAnnotation bars last stopPosition.
	
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: (actions collect: #text) asSet equals: (Set with: 'height=').

	^ aResult
]

{ #category : #examples }
LeWordAnnotationCompletionVisitorExamples >> completeWordAnnotationNoSuggestions [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions anAst anAnnotation position |
	aString := '{{gtWordExplanation:toolkit|expanded|height=200|}}'.
	anAst := LeParser parse: aString.
	anAnnotation := (anAst // LeWordAnnotationNode) anyOne.
	position := anAnnotation bars last stopPosition.
	
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: actions isEmpty.

	^ aResult
]

Class {
	#name : #LeCompleterExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-UI-Snippet-Examples'
}

{ #category : #completion }
LeCompleterExamples >> completeAnnotationStart [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{' asRopedText.
	position := text size.
	actions := self completionActionsFor: text at: position.
	self assert: (actions anySatisfy: [ :each | each label = 'gtClass' ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeAnnotationWithText [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtE' asRopedText.
	position := text size.
	actions := self completionActionsFor: text at: position.
	self assert: (actions anySatisfy: [ :each | each label = 'gtExample' ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeArgumentWithText [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtClass:ex}}' asRopedText.
	position := text size - 2.
	actions := self completionActionsFor: text at: position.
	self
		assert: (actions anySatisfy: [ :each | each label beginsWith: 'expanded' ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeClassNameWithoutParseError [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtClass:Obje}}' asRopedText.
	position := text size - 2.
	actions := self completionActionsFor: text at: position.
	self assert: (actions anySatisfy: [ :each | each label = 'Object' ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeExampleSelector [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtExample:LeCompleterExamples>>comp}}' asRopedText.
	position := text size - 2.
	actions := self completionActionsFor: text at: position.
	self
		assert: (actions anySatisfy: [ :each | each label = thisContext selector asString ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeExampleStartSelector [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtExample:LeCompleterExamples>>}}' asRopedText.
	position := text size - 2.
	actions := self completionActionsFor: text at: position.
	self
		assert: (actions anySatisfy: [ :each | each label = thisContext selector asString ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeExpandedBoolean [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtClass:Object|expanded=}}' asRopedText.
	position := text size - 2.
	actions := self completionActionsFor: text at: position.
	self assert: (actions anySatisfy: [ :each | each label beginsWith: 'true' ]).
	self assert: (actions anySatisfy: [ :each | each label beginsWith: 'false' ]).
	self assert: actions size = 2.
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeMetaclass [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtClass:Object c}}' asRopedText.
	position := text size - 2.
	actions := self completionActionsFor: text at: position.
	self assert: (actions anySatisfy: [ :each | each label = 'class' ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeSecondArgument [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtClass:Object|}}' asRopedText.
	position := text size - 2.
	actions := self completionActionsFor: text at: position.
	self
		assert: (actions anySatisfy: [ :each | each label beginsWith: 'name' ]) not.
	self assert: (actions anySatisfy: [ :each | each label beginsWith: 'height' ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completeStartArgument [
	<gtExample>
	<return: #Array>
	| actions text position |
	text := '{{gtClass:}}' asRopedText.
	position := text size - 2.
	actions := self completionActionsFor: text at: position.
	self assert: (actions anySatisfy: [ :each | each label beginsWith: 'name' ]).
	^ actions
]

{ #category : #completion }
LeCompleterExamples >> completer [
	<gtExample>
	<return: #LeCompletionStrategy>
	^ LeCompletionStrategy new database: LeDatabase new
]

{ #category : #completion }
LeCompleterExamples >> completionActionStreamFor: text at: position [
	^ (self completer
		completionResultFor: text
		at: position
		requested: true) stream
]

{ #category : #completion }
LeCompleterExamples >> completionActionsFor: text at: position [
	^ ((self completionActionStreamFor: text at: position) take: 1000) toArray wait
]

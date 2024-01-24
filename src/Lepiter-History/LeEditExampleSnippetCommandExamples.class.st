Class {
	#name : #LeEditExampleSnippetCommandExamples,
	#superclass : #LeEditSnippetStateCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditExampleSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditExampleSnippetCommandExamples
]

{ #category : #asserting }
LeEditExampleSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self assert: (self targetSnippet similarTo: self initialModifiedSnippet)
]

{ #category : #accessing }
LeEditExampleSnippetCommandExamples >> changedStateAttributes [
	^ #(codeExpanded exampleBehaviorName exampleSelector noCode previewExpanded previewHeight previewShowSelector previewSelectSelector)
]

{ #category : #accessing }
LeEditExampleSnippetCommandExamples >> initialModifiedSnippet [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditExampleSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder  
		updateSnippetStateCommandBasedOn:  self initialModifiedSnippet.
]

Class {
	#name : #LeContextMenuItemCommandSpecification,
	#superclass : #LeContextMenuItemSpecification,
	#instVars : [
		'commandGenerator'
	],
	#category : #'Lepiter-UI-Snippet-Spotter'
}

{ #category : #'api - actions' }
LeContextMenuItemCommandSpecification >> actOn: menuObject [
	| aboveSnippet |
	
	aboveSnippet := menuObject widget snippetViewModel snippetModel.
	^ (self asSnippetCommandBelow: aboveSnippet) execute
]

{ #category : #accessing }
LeContextMenuItemCommandSpecification >> asSnippetCommandBelow: aReferenceSnippet [

	^ commandGenerator value: aReferenceSnippet
]

{ #category : #accessing }
LeContextMenuItemCommandSpecification >> commandGenerator [
	^ commandGenerator
]

{ #category : #accessing }
LeContextMenuItemCommandSpecification >> commandGenerator: anObject [
	commandGenerator := anObject
]

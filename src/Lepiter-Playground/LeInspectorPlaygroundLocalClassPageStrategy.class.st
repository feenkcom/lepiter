Class {
	#name : #LeInspectorPlaygroundLocalClassPageStrategy,
	#superclass : #LeInspectorPlaygroundPageStrategy,
	#category : #'Lepiter-Playground'
}

{ #category : #accessing }
LeInspectorPlaygroundLocalClassPageStrategy >> configureExistingPage: aPage forObject: anObject [
	"| page |
	page := LePage pharoClassName: anObject class name.
	page addSnippet: LePharoSnippet new.
	^ page"
]

{ #category : #accessing }
LeInspectorPlaygroundLocalClassPageStrategy >> createNewPageForObject: anObject [
	| page |
	page := LePage pharoClassName: anObject class name.
	page addSnippet: LePharoSnippet new.
	^ page
]

{ #category : #accessing }
LeInspectorPlaygroundLocalClassPageStrategy >> pageDatabaseKeyBasedOnObject: anObject [ 
	^ anObject class name
]

{ #category : #accessing }
LeInspectorPlaygroundLocalClassPageStrategy >> playgroundPageType [
	^ LePharoClassPageType
]

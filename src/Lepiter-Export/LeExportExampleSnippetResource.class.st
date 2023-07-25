Class {
	#name : #LeExportExampleSnippetResource,
	#superclass : #LeExportSnippetResource,
	#instVars : [
		'height',
		'element'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #accessing }
LeExportExampleSnippetResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportExampleSnippetResource: self
]

{ #category : #testing }
LeExportExampleSnippetResource >> canExampleBeExecuted [
	^ self hasExample and: [ self example canBeExecuted ]
]

{ #category : #initialization }
LeExportExampleSnippetResource >> defaultState [
	^ (self reference isNotNil and: [ self reference exists ])
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState uninitialized ]
]

{ #category : #accessing }
LeExportExampleSnippetResource >> example [
	^ self snippet exampleMethod compiledMethod gtExample
]

{ #category : #testing }
LeExportExampleSnippetResource >> hasExample [
	^ self hasMethod and: [ self example isNotNil ]
]

{ #category : #testing }
LeExportExampleSnippetResource >> hasMethod [
	^ self snippet exampleMethod isNotNil and: [ self method isNotNil ]
]

{ #category : #accessing }
LeExportExampleSnippetResource >> height [
	<return: #Number>
	^ height
]

{ #category : #accessing }
LeExportExampleSnippetResource >> height: aNumber [
	height := aNumber
]

{ #category : #accessing }
LeExportExampleSnippetResource >> method [
	^ self snippet exampleMethod compiledMethod
]

{ #category : #accessing }
LeExportExampleSnippetResource >> previewShowSelector [
	^ self snippet previewShowSelector
]

{ #category : #accessing }
LeExportExampleSnippetResource >> sourceCode [
	^ self method sourceCode
]

{ #category : #testing }
LeExportExampleSnippetResource >> wantsCodeOutput [
	^ self hasMethod and: [ self snippet hasNoCode and: [ self snippet noCode not ] ]
]

{ #category : #testing }
LeExportExampleSnippetResource >> wantsPreviewOutput [
	^ self canExampleBeExecuted
		and: [ (self snippet hasPreviewExpanded and: [ self snippet previewExpanded ])
				or: [ self snippet hasNoCode and: [ self snippet noCode ] ] ]
]

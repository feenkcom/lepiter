Class {
	#name : #LeExportSnippetResources,
	#superclass : #Object,
	#instVars : [
		'resources'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #testing }
LeExportSnippetResources >> ifEmpty: emptyBlock ifOne: oneBlock ifMore: moreBlock [

	resources ifEmpty: [ ^ emptyBlock value ].
	^ resources size = 1
		ifTrue: [ oneBlock cull: resources anyOne ]
		ifFalse: [ moreBlock cull: resources ]
]

{ #category : #accessing }
LeExportSnippetResources >> resource [
	self
		assert: [ resources size = 1 ]
		description: [ 'There must be just one resource' ].
	^ resources
]

{ #category : #accessing }
LeExportSnippetResources >> resources [
	^ resources
]

{ #category : #accessing }
LeExportSnippetResources >> resources: aCollection [
	resources := aCollection
]

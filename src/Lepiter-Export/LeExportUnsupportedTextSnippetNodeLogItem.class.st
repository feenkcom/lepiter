Class {
	#name : #LeExportUnsupportedTextSnippetNodeLogItem,
	#superclass : #Object,
	#traits : 'TLeExportLogItem',
	#classTraits : 'TLeExportLogItem classTrait',
	#instVars : [
		'snippet',
		'node'
	],
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #accessing }
LeExportUnsupportedTextSnippetNodeLogItem >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeExportUnsupportedTextSnippetNodeLogItem >> description [
	^ self snippet gtDisplayText
]

{ #category : #'gt - extensions' }
LeExportUnsupportedTextSnippetNodeLogItem >> gtNodeFor: aView [
	<gtView>
	node ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Node';
		priority: 10;
		object: [ node ];
		view: #gtExploreFor:
]

{ #category : #'gt - extensions' }
LeExportUnsupportedTextSnippetNodeLogItem >> gtSnippetFor: aView [
	<gtView>
	snippet ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Snippet';
		priority: 1;
		object: [ snippet ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Page'
			tooltip: 'Inspect page'
			action: [ :aButton | aButton phlow spawnObject: snippet page ]
]

{ #category : #testing }
LeExportUnsupportedTextSnippetNodeLogItem >> isProblemLog [
	^ true
]

{ #category : #accessing }
LeExportUnsupportedTextSnippetNodeLogItem >> name [
	^ 'unsupported text node'
]

{ #category : #accessing }
LeExportUnsupportedTextSnippetNodeLogItem >> node [
	^ node
]

{ #category : #accessing }
LeExportUnsupportedTextSnippetNodeLogItem >> node: anObject [
	node := anObject
]

{ #category : #accessing }
LeExportUnsupportedTextSnippetNodeLogItem >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportUnsupportedTextSnippetNodeLogItem >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeExportUnsupportedTextSnippetNodeLogItem >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping logs by this type."

	^ self node class
]

Class {
	#name : #LeExportUnsupportedSnippetLogItem,
	#superclass : #Object,
	#traits : 'TLeExportLogItem',
	#classTraits : 'TLeExportLogItem classTrait',
	#instVars : [
		'snippet'
	],
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #accessing }
LeExportUnsupportedSnippetLogItem >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeExportUnsupportedSnippetLogItem >> description [
	^ self snippet gtDisplayText
]

{ #category : #'gt - extensions' }
LeExportUnsupportedSnippetLogItem >> gtLiveFor: aView [
	<gtView>
	snippet ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Snippet';
		priority: 1;
		object: [ snippet ];
		view: #gtLiveFor:
]

{ #category : #testing }
LeExportUnsupportedSnippetLogItem >> isProblemLog [
	^ true
]

{ #category : #accessing }
LeExportUnsupportedSnippetLogItem >> name [
	^ 'unsupported snippet'
]

{ #category : #accessing }
LeExportUnsupportedSnippetLogItem >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportUnsupportedSnippetLogItem >> snippet: anObject [
	snippet := anObject
]

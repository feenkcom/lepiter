Class {
	#name : #LeExportMissingChangesSnippetFileLogItem,
	#superclass : #Object,
	#traits : 'TLeExportLogItem',
	#classTraits : 'TLeExportLogItem classTrait',
	#instVars : [
		'snippet',
		'snippetViewModel'
	],
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #accessing }
LeExportMissingChangesSnippetFileLogItem >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeExportMissingChangesSnippetFileLogItem >> description [
	^ self snippet gtDisplayText
]

{ #category : #'gt - extensions' }
LeExportMissingChangesSnippetFileLogItem >> gtLiveFor: aView [
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
LeExportMissingChangesSnippetFileLogItem >> isProblemLog [
	^ true
]

{ #category : #accessing }
LeExportMissingChangesSnippetFileLogItem >> name [
	^ 'missing changes file'
]

{ #category : #accessing }
LeExportMissingChangesSnippetFileLogItem >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportMissingChangesSnippetFileLogItem >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeExportMissingChangesSnippetFileLogItem >> snippetViewModel [
	^ snippetViewModel
]

{ #category : #accessing }
LeExportMissingChangesSnippetFileLogItem >> snippetViewModel: aViewModel [
	snippetViewModel := aViewModel.
	snippet := aViewModel snippetModel.
]

{ #category : #accessing }
LeExportMissingChangesSnippetFileLogItem >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping logs by this type."

	^ self snippet class
]

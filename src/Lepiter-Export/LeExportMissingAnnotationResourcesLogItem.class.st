Class {
	#name : #LeExportMissingAnnotationResourcesLogItem,
	#superclass : #Object,
	#traits : 'TLeExportLogItem',
	#classTraits : 'TLeExportLogItem classTrait',
	#instVars : [
		'snippet',
		'annotation',
		'method'
	],
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #accessing }
LeExportMissingAnnotationResourcesLogItem >> annotation [
	^ annotation
]

{ #category : #accessing }
LeExportMissingAnnotationResourcesLogItem >> annotation: anObject [
	annotation := anObject
]

{ #category : #accessing }
LeExportMissingAnnotationResourcesLogItem >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeExportMissingAnnotationResourcesLogItem >> description [
	^ self annotation gtDisplayText
]

{ #category : #'gt - extensions' }
LeExportMissingAnnotationResourcesLogItem >> gtSnippetFor: aView [
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
LeExportMissingAnnotationResourcesLogItem >> isProblemLog [
	^ true
]

{ #category : #accessing }
LeExportMissingAnnotationResourcesLogItem >> name [
	^ 'missing annotation resources'
]

{ #category : #accessing }
LeExportMissingAnnotationResourcesLogItem >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportMissingAnnotationResourcesLogItem >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeExportMissingAnnotationResourcesLogItem >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping logs by this type."

	^ self annotation class
]

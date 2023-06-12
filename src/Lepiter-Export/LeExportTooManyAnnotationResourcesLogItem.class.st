Class {
	#name : #LeExportTooManyAnnotationResourcesLogItem,
	#superclass : #Object,
	#traits : 'TLeExportLogItem',
	#classTraits : 'TLeExportLogItem classTrait',
	#instVars : [
		'snippet',
		'annotation',
		'resources'
	],
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> annotation [
	^ annotation
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> annotation: anObject [
	annotation := anObject
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> description [
	^ self annotation gtDisplayText
]

{ #category : #'gt - extensions' }
LeExportTooManyAnnotationResourcesLogItem >> gtSnippetFor: aView [
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
LeExportTooManyAnnotationResourcesLogItem >> isProblemLog [
	^ true
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> name [
	^ 'too many annotation resources'
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> resources [
	^ resources
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> resources: anObject [
	resources := anObject
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeExportTooManyAnnotationResourcesLogItem >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping logs by this type."

	^ self annotation class
]

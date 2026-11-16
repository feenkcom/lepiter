"
I log an annotation that an exporter could not resolve, for example a `gtPictureReference` annotation whose picture does not exist, or a `gtObject` annotation without a label.
The annotation is still exported, usually as a plain label, and my {{gtMethod:LeExportUnresolvedAnnotationLogItem>>#reason}} says why it is incomplete.
I do not know the annotation kinds, the component visitors of extension packages create me, for example {{gtClass:LePictureAnnotationHtmlVisitor}}.
See {{gtExample:LePictureAnnotationExportExamples>>#htmlTextSnippetWithUnresolvedPictureAnnotationInDatabase}}.
"
Class {
	#name : #LeExportUnresolvedAnnotationLogItem,
	#superclass : #Object,
	#traits : 'TLeExportLogItem',
	#classTraits : 'TLeExportLogItem classTrait',
	#instVars : [
		'snippet',
		'annotation',
		'reason'
	],
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> annotation [
	^ annotation

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> annotation: anAnnotationNode [
	annotation := anAnnotationNode

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> color [
	^ BrGlamorousColors errorBackgroundColor

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> description [
	^ self reason ifNil: [ self annotation gtDisplayText ]

]

{ #category : #'gt - extensions' }
LeExportUnresolvedAnnotationLogItem >> gtAnnotationFor: aView [
	<gtView>
	annotation ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Annotation';
		priority: 10;
		object: [ annotation ];
		view: #gtExploreFor:

]

{ #category : #'gt - extensions' }
LeExportUnresolvedAnnotationLogItem >> gtSnippetFor: aView [
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
LeExportUnresolvedAnnotationLogItem >> isProblemLog [
	^ true

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> name [
	^ 'unresolved annotation'

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> reason [
	"Answer a String that explains why the annotation could not be resolved"

	^ reason

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> reason: aString [
	reason := aString

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> snippet [
	^ snippet

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> snippet: aSnippet [
	snippet := aSnippet

]

{ #category : #accessing }
LeExportUnresolvedAnnotationLogItem >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping logs by this type."

	^ self annotation class

]

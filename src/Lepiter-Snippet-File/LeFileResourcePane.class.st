Class {
	#name : #LeFileResourcePane,
	#superclass : #Object,
	#instVars : [
		'bindingName',
		'fileReference',
		'acceptAction',
		'inspectAction'
	],
	#category : #'Lepiter-Snippet-File'
}

{ #category : #accessing }
LeFileResourcePane >> acceptAction [ 
	^ acceptAction ifNil: [ 
		[ :aModel :aButton :aMemento :aDescription |
			aButton phlow spawnObject: self bindingName -> self fileReference asFileReference ] ]
]

{ #category : #accessing }
LeFileResourcePane >> acceptAction: anAction [
	acceptAction := anAction
]

{ #category : #accessing }
LeFileResourcePane >> asElement [
	^ self asGtMagritteViewModel asElement padding: (BlInsets all: 10)
]

{ #category : #magritte }
LeFileResourcePane >> bindingDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 1;
		label: 'Binding';
		accessor: #bindingName;
		default: ''
]

{ #category : #accessing }
LeFileResourcePane >> bindingName [
	^ bindingName
]

{ #category : #accessing }
LeFileResourcePane >> bindingName: aString [
	bindingName := aString
]

{ #category : #accessing }
LeFileResourcePane >> fileReference [
	^ fileReference
]

{ #category : #accessing }
LeFileResourcePane >> fileReference: aString [
	fileReference := aString
]

{ #category : #magritte }
LeFileResourcePane >> fileReferenceDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 2;
		label: 'FileReference';
		accessor: #fileReference;
		default: ''
]

{ #category : #accessing }
LeFileResourcePane >> inspectAction [
	^ inspectAction ifNil: [ 
		[ :aModel :aButton :aMemento :aDescription |
			aButton phlow spawnObject: self bindingName -> self fileReference asFileReference ] ]
]

{ #category : #accessing }
LeFileResourcePane >> inspectAction: anAction [
	inspectAction := anAction
]

{ #category : #magritte }
LeFileResourcePane >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		priority: 10;
		beAlwaysEnabled;
		label: 'Accept the changes and set the file';
		isLabelVisible: false;
		blocIcon: BrGlamorousVectorIcons play;
		onSuccessCallback: (GtMagritteCallback new action: self acceptAction)
]

{ #category : #magritte }
LeFileResourcePane >> magritteCancelAction [
	<magritteActionDescription>
	^ nil
]

{ #category : #magritte }
LeFileResourcePane >> magritteInspectAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		priority: 20;
		beAlwaysEnabled;
		label: 'Accept the changes, set the file and inspect';
		isLabelVisible: false;
		blocIcon: BrGlamorousVectorIcons playinspect;
		onSuccessCallback: (GtMagritteCallback new action: self inspectAction)
]

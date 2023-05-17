Class {
	#name : #LeContentTraceEvent,
	#superclass : #Object,
	#instVars : [
		'uid',
		'timestamp'
	],
	#category : #'Lepiter-History-Storage'
}

{ #category : #accessing }
LeContentTraceEvent >> contentUid [
	^ self mainCommandSpecification contentUid
]

{ #category : #utils }
LeContentTraceEvent >> formatCommandTypeName: aCommandName [
	^ LeContentCommand formatTypeName: aCommandName
]

{ #category : #'gt - extensions' }
LeContentTraceEvent >> gtViewCommandSpecificationFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Main command';
		priority: 10;
		object: [ self mainCommandSpecification ];
		view: #gtViewSpecificationAttributesFor:
]

{ #category : #'gt - extensions' }
LeContentTraceEvent >> gtViewUndoSpecificationFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Undo command';
		priority: 15;
		object: [ self undoCommandSpecification ];
		view: #gtViewSpecificationAttributesFor:
]

{ #category : #initialization }
LeContentTraceEvent >> initialize [
	super initialize.
	
	uid := LeUID new.
	timestamp := DateAndTime now.
]

{ #category : #accessing }
LeContentTraceEvent >> label [
	self subclassResponsibility
]

{ #category : #utils }
LeContentTraceEvent >> mainCommandLabel [
	^ self formatCommandTypeName: self mainCommandTypeName
]

{ #category : #accessing }
LeContentTraceEvent >> mainCommandSpecification [
	self subclassResponsibility
]

{ #category : #accessing }
LeContentTraceEvent >> mainCommandTypeName [
	^ self mainCommandSpecification commandTypeName
]

{ #category : #printing }
LeContentTraceEvent >> printOn: aStream [ 
	super printOn: aStream.
	
	aStream parenthesize: [ 
		aStream << self mainCommandLabel]
]

{ #category : #'api - undo/redo' }
LeContentTraceEvent >> redoOn: aPage [
	^ (LeRedoContentCommand 
		forTraceEvent: self
		inPage: aPage) execute
]

{ #category : #accessing }
LeContentTraceEvent >> timestamp [
	^ timestamp
]

{ #category : #accessing }
LeContentTraceEvent >> uid [
	^ uid
]

{ #category : #utils }
LeContentTraceEvent >> undoCommandLabel [
	^ self formatCommandTypeName: self undoCommandTypeName
]

{ #category : #accessing }
LeContentTraceEvent >> undoCommandSpecification [
	self subclassResponsibility
]

{ #category : #accessing }
LeContentTraceEvent >> undoCommandTypeName [
	^ self undoCommandSpecification commandTypeName
]

{ #category : #'api - undo/redo' }
LeContentTraceEvent >> undoOn: aPage [
	^ (LeUndoContentCommand 
		forTraceEvent: self
		inPage: aPage) execute
]

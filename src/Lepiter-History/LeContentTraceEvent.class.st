Class {
	#name : #LeContentTraceEvent,
	#superclass : #Object,
	#instVars : [
		'uid'
	],
	#category : #'Lepiter-History-Storage'
}

{ #category : #accessing }
LeContentTraceEvent >> commandSpecification [
	self subclassResponsibility
]

{ #category : #accessing }
LeContentTraceEvent >> commandTypeName [
	^ self commandSpecification commandTypeName
]

{ #category : #'gt - extensions' }
LeContentTraceEvent >> gtViewCommandSpecificationFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Command Specification';
		priority: 10;
		object: [ self commandSpecification ];
		view: #gtViewSpecificationAttributesFor:
]

{ #category : #'gt - extensions' }
LeContentTraceEvent >> gtViewUndoSpecificationFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Undo Specification';
		priority: 15;
		object: [ self undoSpecification ];
		view: #gtViewSpecificationAttributesFor:
]

{ #category : #initialization }
LeContentTraceEvent >> initialize [
	super initialize.
	
	uid := LeUID new.
]

{ #category : #accessing }
LeContentTraceEvent >> label [
	self subclassResponsibility
]

{ #category : #printing }
LeContentTraceEvent >> printOn: aStream [ 
	super printOn: aStream.
	
	aStream parenthesize: [ 
		aStream << self commandTypeName ]
]

{ #category : #'api - undo/redo' }
LeContentTraceEvent >> redoOn: aPage [
	
	(LeRedoContentCommand 
		forTraceEvent: self
		inPage: aPage) execute
]

{ #category : #'api - undo/redo' }
LeContentTraceEvent >> undoOn: aPage [
	
	(LeUndoContentCommand 
		forTraceEvent: self
		inPage: aPage) execute
]

{ #category : #accessing }
LeContentTraceEvent >> undoSpecification [
	self subclassResponsibility
]

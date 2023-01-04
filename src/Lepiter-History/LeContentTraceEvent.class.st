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

{ #category : #utils }
LeContentTraceEvent >> formatCommandTypeName: aCommandName [
	^ String streamContents: [ :aStream  |
		(((aCommandName 
			withoutPrefix:  'Le')
			withoutPrefix: 'Page')
			withoutSuffix: 'Command')
				splitCamelCase asStringOn: aStream delimiter: ' ' ]
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

{ #category : #utils }
LeContentTraceEvent >> mainCommandLabel [
	^ self formatCommandTypeName: self commandTypeName
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

{ #category : #utils }
LeContentTraceEvent >> undoCommandLabel [
	^ self formatCommandTypeName: self undoCommandTypeName
]

{ #category : #accessing }
LeContentTraceEvent >> undoCommandTypeName [
	^ self undoSpecification commandTypeName
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

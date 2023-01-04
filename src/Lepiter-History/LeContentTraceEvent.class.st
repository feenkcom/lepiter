Class {
	#name : #LeContentTraceEvent,
	#superclass : #Object,
	#instVars : [
		'uid'
	],
	#category : #'Lepiter-History-Storage'
}

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
		title: 'Main Command';
		priority: 10;
		object: [ self mainCommandSpecification ];
		view: #gtViewSpecificationAttributesFor:
]

{ #category : #'gt - extensions' }
LeContentTraceEvent >> gtViewUndoSpecificationFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Undo Command';
		priority: 15;
		object: [ self undoCommandSpecification ];
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
		aStream << self mainCommandTypeName ]
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
LeContentTraceEvent >> undoCommandSpecification [
	self subclassResponsibility
]

{ #category : #accessing }
LeContentTraceEvent >> undoCommandTypeName [
	^ self undoCommandSpecification commandTypeName
]

{ #category : #'api - undo/redo' }
LeContentTraceEvent >> undoOn: aPage [
	
	(LeUndoContentCommand 
		forTraceEvent: self
		inPage: aPage) execute
]

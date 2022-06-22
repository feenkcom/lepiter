Class {
	#name : #LeContentEditTraceEvent,
	#superclass : #Object,
	#instVars : [
		'commandSpecification',
		'undoSpecification'
	],
	#category : #'Lepiter-History-Store'
}

{ #category : #accessing }
LeContentEditTraceEvent >> commandSpecification [

	^ commandSpecification
]

{ #category : #accessing }
LeContentEditTraceEvent >> commandSpecification: anObject [

	commandSpecification := anObject
]

{ #category : #'gt - extensions' }
LeContentEditTraceEvent >> gtViewCommandSpecificationFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Command Specification';
		priority: 10;
		object: [ self commandSpecification ];
		view: #gtViewSpecificationAttributesFor:
]

{ #category : #'gt - extensions' }
LeContentEditTraceEvent >> gtViewUndoSpecificationFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Undo Specification';
		priority: 15;
		object: [ self undoSpecification ];
		view: #gtViewSpecificationAttributesFor:
]

{ #category : #accessing }
LeContentEditTraceEvent >> undoSpecification [

	^ undoSpecification
]

{ #category : #accessing }
LeContentEditTraceEvent >> undoSpecification: anObject [

	undoSpecification := anObject
]

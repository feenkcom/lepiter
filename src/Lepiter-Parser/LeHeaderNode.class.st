Class {
	#name : 'LeHeaderNode',
	#superclass : 'LeContentNode',
	#instVars : [
		'numberSigns',
		'parts'
	],
	#category : 'Lepiter-Parser'
}

{ #category : 'generated' }
LeHeaderNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitHeader: self
]

{ #category : 'generated' }
LeHeaderNode >> compositeNodeVariables [
	^ #(#parts)
]

{ #category : 'generated' }
LeHeaderNode >> compositeTokenVariables [
	^ #(#numberSigns)
]

{ #category : 'accessing' }
LeHeaderNode >> headerLevel [
	^ numberSigns size min: 6
]

{ #category : 'generated-initialize-release' }
LeHeaderNode >> initialize [
	super initialize.
	numberSigns := OrderedCollection new: 2.
	parts := OrderedCollection new: 2.
]

{ #category : 'generated' }
LeHeaderNode >> numberSigns [
	^ numberSigns
]

{ #category : 'generated' }
LeHeaderNode >> numberSigns: anOrderedCollection [
	numberSigns := anOrderedCollection
]

{ #category : 'generated' }
LeHeaderNode >> parts [
	^ parts
]

{ #category : 'generated' }
LeHeaderNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]

Class {
	#name : #AlignmentStrategy,
	#superclass : #Object,
	#category : #'Lepiter-UI-Core-Strategies'
}

{ #category : #naming }
AlignmentStrategy class >> strategyName [
	self subclassResponsibility.
]

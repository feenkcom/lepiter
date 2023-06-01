Class {
	#name : #LeExportObjectSpecificationForwardFinder,
	#superclass : #LeExportObjectSpecificationFinder,
	#instVars : [
		'previousObjectContext'
	],
	#category : #'Lepiter-Export-Specification - Support'
}

{ #category : #accessing }
LeExportObjectSpecificationForwardFinder >> newObjectContext [
	^ LeExportObjectSpecificationSubsequentContext new
		specifications: specifications;
		object: object;
		previousContext: previousObjectContext
]

{ #category : #accessing }
LeExportObjectSpecificationForwardFinder >> previousObjectContext [
	^ previousObjectContext
]

{ #category : #accessing }
LeExportObjectSpecificationForwardFinder >> previousObjectContext: anObject [
	previousObjectContext := anObject
]

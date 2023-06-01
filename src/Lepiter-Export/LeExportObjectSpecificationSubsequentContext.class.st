Class {
	#name : #LeExportObjectSpecificationSubsequentContext,
	#superclass : #LeExportObjectSpecificationContext,
	#instVars : [
		'previousContext'
	],
	#category : #'Lepiter-Export-Specification - Support'
}

{ #category : #enumerating }
LeExportObjectSpecificationSubsequentContext >> objectContextsDo: aBlock [
	aBlock cull: self.
	previousContext objectContextsDo: aBlock 
]

{ #category : #accessing }
LeExportObjectSpecificationSubsequentContext >> previousContext [
	<return: #LeExportObjectSpecificationContext>
	^ previousContext
]

{ #category : #accessing }
LeExportObjectSpecificationSubsequentContext >> previousContext: anObject [
	previousContext := anObject
]

Class {
	#name : #LeMissingCodeReferencesTextVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'missingReferences'
	],
	#category : 'Lepiter-Validator-Visitors'
}

{ #category : #accessing }
LeMissingCodeReferencesTextVisitor >> missingReferences [
	^ missingReferences
]

{ #category : #accessing }
LeMissingCodeReferencesTextVisitor >> missingReferences: aMissingReferencesResult [
	missingReferences := aMissingReferencesResult
]

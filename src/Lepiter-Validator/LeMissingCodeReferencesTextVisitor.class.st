Class {
	#name : #LeMissingCodeReferencesTextVisitor,
	#superclass : #Object,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'missingReferences'
	],
	#category : #'Lepiter-Validator-Visitors'
}

{ #category : #accessing }
LeMissingCodeReferencesTextVisitor class >> defaultComponentVisitorClasses [
	^ {LeMissingCodeReferencesAnnotationsVisitor}
]

{ #category : #accessing }
LeMissingCodeReferencesTextVisitor >> missingReferences [
	^ missingReferences
]

{ #category : #accessing }
LeMissingCodeReferencesTextVisitor >> missingReferences: aMissingReferencesResult [
	missingReferences := aMissingReferencesResult
]

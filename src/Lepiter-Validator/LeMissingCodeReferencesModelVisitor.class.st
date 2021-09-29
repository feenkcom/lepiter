Class {
	#name : 'LeMissingCodeReferencesModelVisitor',
	#superclass : 'Object',
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'missingReferences'
	],
	#category : 'Lepiter-Validator-Visitors'
}

{ #category : 'accessing' }
LeMissingCodeReferencesModelVisitor >> missingReferences [
	^ missingReferences ifNil: [ 
		missingReferences := LePageValidatorMissingReferencesResult new ]
]

{ #category : 'api' }
LeMissingCodeReferencesModelVisitor >> missingReferencesInPage: aPage [
	self missingReferences targetPage: aPage.
	aPage acceptVisitor: self.
	^ self missingReferences
	
]

{ #category : 'visiting' }
LeMissingCodeReferencesModelVisitor >> visitTextSnippet: aLeTextSnippet [
	| snippetVisitor |
	snippetVisitor := LeMissingCodeReferencesTextVisitor new.
	snippetVisitor missingReferences: self missingReferences.
	snippetVisitor addVisitor: LeMissingCodeReferencesAnnotationsVisitor new.
	snippetVisitor acceptNode: aLeTextSnippet ast.

	^ self visitTextualSnippet: aLeTextSnippet
]

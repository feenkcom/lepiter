Class {
	#name : #LeExportSnippetToObjectSpecificationVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-Export-Specification - Support'
}

{ #category : #visiting }
LeExportSnippetToObjectSpecificationVisitor >> visitElementSnippet: aLeElementSnippet [
	| element finder |
	element := LeExportUtility newSnippetElementFor: aLeElementSnippet.
	
	finder := LeExportObjectSpecificationBuilder new 
		specifications: context specifications;
		object: element;
		find.
		
	^ finder objectSpecification
]

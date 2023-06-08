Class {
	#name : #LeExportTextSnippetVisitor,
	#superclass : #Object,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'context',
		'snippet'
	],
	#classInstVars : [
		'componentVisitorClasses'
	],
	#category : #'Lepiter-Export-! Core'
}

{ #category : #accessing }
LeExportTextSnippetVisitor >> context [
	^ context
]

{ #category : #accessing }
LeExportTextSnippetVisitor >> context: anObject [
	context := anObject
]

{ #category : #accessing }
LeExportTextSnippetVisitor >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportTextSnippetVisitor >> snippet: anObject [
	snippet := anObject
]

{ #category : #generated }
LeExportTextSnippetVisitor >> visitDocumenterAnnotation: aDocumenterAnnotation [
	| visitor |
	visitor := LeExportTextSnippetAnnotationVisitor new
		context: context;
		snippet: snippet.
		
	aDocumenterAnnotation annotation acceptVisitor: visitor.
	
	^ aDocumenterAnnotation
]

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
	| anAnnotation aVisitor |
	anAnnotation := aDocumenterAnnotation annotation.
	anAnnotation ifNil: [ ^ aDocumenterAnnotation ].

	aVisitor := self
			annotationVisitorFor: anAnnotation
			default: (LeExportTextSnippetAnnotationVisitor new
					context: context;
					snippet: snippet).

	"Annotations without export support do not create any export resources"
	aVisitor ifNotNil: [ anAnnotation acceptVisitor: aVisitor ].

	^ aDocumenterAnnotation

]

{ #category : #generated }
LeExportTextSnippetVisitor >> visitExternalImageLink: anExternalImageLink [
	| aBuilder |
	aBuilder := LeExportPictureResourceBuilder new
			resources: context resources;
			sequencer: context sequencer;
			fileStore: context fileStore;
			snippet: snippet.

	anExternalImageLink acceptVisitor: aBuilder.

	^ anExternalImageLink
]

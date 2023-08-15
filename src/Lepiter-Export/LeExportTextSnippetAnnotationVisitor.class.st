Class {
	#name : #LeExportTextSnippetAnnotationVisitor,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor + TLeExportResourceHelpers',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait + TLeExportResourceHelpers classTrait',
	#instVars : [
		'context',
		'snippet'
	],
	#category : #'Lepiter-Export-! Core'
}

{ #category : #accessing }
LeExportTextSnippetAnnotationVisitor >> context [
	^ context
]

{ #category : #accessing }
LeExportTextSnippetAnnotationVisitor >> context: anObject [
	context := anObject
]

{ #category : #accessing }
LeExportTextSnippetAnnotationVisitor >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportTextSnippetAnnotationVisitor >> snippet: anObject [
	snippet := anObject
]

{ #category : #visiting }
LeExportTextSnippetAnnotationVisitor >> visitExampleAnnotation: anExampleAnnotation [
	| aResource aHeight aPath aFile rbMethod aResourceState anExample |
	
	"Prepare height"
	aHeight := anExampleAnnotation previewHeight.
		
	"Prepare file"
	aPath := self nextPath.
	aFile := self nextFileReferenceTo: aPath.
	
	"Prepare example"
	rbMethod := anExampleAnnotation imageObject.
	(rbMethod isNil or: [
		rbMethod isDefined not ]) ifTrue: [ 
			aResourceState := LeExportExampleMethodIsNotDefinedState uniqueInstance.
	].
	
	aResourceState ifNil: [
		anExample := rbMethod compiledMethod gtExample.
		anExample 
			ifNil: [ 
				aResourceState := LeExportMethodIsNotExampleState uniqueInstance ]
			ifNotNil: [
				anExample := anExample ifNotNil: #asExampleWithResult.
				anExample canBeExecuted ifFalse: [
					"We consider only examples without arguments.
					We many need to change it in the future."
					aResourceState := LeExportExampleIsNotExecutableState uniqueInstance.
				] ] ].
	
	"Store the resource"
	aResource := LeExportTextSnippetExampleAnnotationResource new
		state: aResourceState;
		snippet: snippet;
		source: anExampleAnnotation;
		annotation: anExampleAnnotation;
		path: aPath;
		reference: aFile;
		height: aHeight.
		
	anExample ifNotNil: [
		aResource example: anExample ].
		
	self addResource: aResource
]

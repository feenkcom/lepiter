Class {
	#name : #LeHtmlTextSnippetAnnotationPostAbstractVisitor,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait',
	#instVars : [
		'context',
		'snippet'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #accessing }
LeHtmlTextSnippetAnnotationPostAbstractVisitor >> context [
	^ context
]

{ #category : #accessing }
LeHtmlTextSnippetAnnotationPostAbstractVisitor >> context: anObject [
	context := anObject
]

{ #category : #accessing }
LeHtmlTextSnippetAnnotationPostAbstractVisitor >> snippet [
	^ snippet
]

{ #category : #accessing }
LeHtmlTextSnippetAnnotationPostAbstractVisitor >> snippet: anObject [
	snippet := anObject
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationPostAbstractVisitor >> visitClassAnnotation: aClassAnnotation [
	| classNameArgument |
	aClassAnnotation hasLabel ifTrue: [ 
		context html escape: aClassAnnotation label.
		^ self ].
	
	classNameArgument := aClassAnnotation nameNode.
	context html escape: classNameArgument value source
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationPostAbstractVisitor >> visitMethodAnnotation: aMethodAnnotation [
	| nameNode |
	aMethodAnnotation hasLabel ifTrue: [ 
		context html escape: aMethodAnnotation label.
		^ self ].
	
	nameNode := aMethodAnnotation nameNode.
	context html escape: nameNode value source
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationPostAbstractVisitor >> visitPackageAnnotation: aPackageAnnotation [
	| nameNode |
	aPackageAnnotation hasLabel ifTrue: [ 
		context html escape: aPackageAnnotation label.
		^ self ].
	
	nameNode := aPackageAnnotation nameNode.
	context html escape: nameNode value source
]

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

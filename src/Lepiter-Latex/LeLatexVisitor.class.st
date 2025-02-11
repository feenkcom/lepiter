Class {
	#name : #LeLatexVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-Latex-Visitors'
}

{ #category : #accessing }
LeLatexVisitor >> contents [
	^ context contents
]

{ #category : #accessing }
LeLatexVisitor >> context [
	^ context ifNil: [ context := LeLatexContext new ]
]

{ #category : #accessing }
LeLatexVisitor >> context: anObject [
	context := anObject
]

{ #category : #visiting }
LeLatexVisitor >> visitTextSnippet: aLeTextSnippet [
	aLeTextSnippet ast
		acceptVisitor: (LeLatexTextSnippetVisitor new
				context: self context;
				yourself)
]

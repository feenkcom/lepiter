"
I am loosely based on LeHtmlTextSnippetVisitor.
I visit text snippets and generate output using a context object.
"
Class {
	#name : #LeLatexTextSnippetVisitor,
	#superclass : #Object,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'context'
	],
	#classInstVars : [
		'componentVisitorClasses'
	],
	#category : #'Lepiter-Latex-Visitors'
}

{ #category : #accessing }
LeLatexTextSnippetVisitor >> context [
	self
		assert: context notNil
		description: 'context must be initialized by the LeLatexVisitor'.
	^ context
]

{ #category : #accessing }
LeLatexTextSnippetVisitor >> context: anObject [
	context := anObject
]

{ #category : #generated }
LeLatexTextSnippetVisitor >> visitText: aText [
	context putText: aText content
]

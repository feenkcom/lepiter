"
I generate a simplified HTML output that may be used as a post description. 
It is assumed to visit just a {{gtClass:LeTextSnippet}} and it is a responsibility of a user to provide a meanigful text snippet to iterate on.
"
Class {
	#name : #LeHtmlTextSnippetPostAbstractVisitor,
	#superclass : #Object,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'context',
		'snippet'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #convenience }
LeHtmlTextSnippetPostAbstractVisitor >> contentsFor: snippet [
	"Note that here we expect a text snippet and we iterate over the text snippet ast"

	^ String
		streamContents: [ :stream | 
			self context stream: stream.
			snippet ast acceptVisitor: self ]
]

{ #category : #accessing }
LeHtmlTextSnippetPostAbstractVisitor >> context [
	^ context
]

{ #category : #accessing }
LeHtmlTextSnippetPostAbstractVisitor >> context: aContext [
	context := aContext
]

{ #category : #'gt - extensions' }
LeHtmlTextSnippetPostAbstractVisitor >> gtResourcesFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ context ];
		view: #gtResourcesFor:
]

{ #category : #'gt - extensions' }
LeHtmlTextSnippetPostAbstractVisitor >> gtStreamStateFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'HTML';
		priority: 10;
		object: [ context ];
		view: #gtStreamStateFor:
]

{ #category : #accessing }
LeHtmlTextSnippetPostAbstractVisitor >> snippet [
	^ snippet
]

{ #category : #accessing }
LeHtmlTextSnippetPostAbstractVisitor >> snippet: anObject [
	snippet := anObject
]

{ #category : #generated }
LeHtmlTextSnippetPostAbstractVisitor >> visitDocumenterAnnotation: aDocumenterAnnotation [
	aDocumenterAnnotation annotation
		acceptVisitor: (LeHtmlTextSnippetAnnotationPostAbstractVisitor new 
			context: context;
			snippet: snippet)
]

{ #category : #generated }
LeHtmlTextSnippetPostAbstractVisitor >> visitExternalLabelUrlLink: anExternalLabelUrlLink [
	| label |
	label := anExternalLabelUrlLink label trimBoth.
	label ifEmpty: [ label := anExternalLabelUrlLink url ].

	context html escape: label
]

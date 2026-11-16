"
I write `gtSymbol` annotations ({{gtClass:LeSymbolAnnotationNode}}) as plain text, for example `#asString`, into page abstracts (e.g. HTML page descriptions).
I am a component visitor of {{gtClass:LeHtmlTextSnippetPostAbstractVisitor}}: I register myself in {{gtMethod:LeSymbolAnnotationHtmlPostAbstractVisitor class>>#initialize}} and deregister in {{gtMethod:LeSymbolAnnotationHtmlPostAbstractVisitor class>>#obsolete}}.
See {{gtExample:LeSymbolAnnotationExportExamples>>#postAbstractTextSnippetWithSymbolAnnotation}}.
"
Class {
	#name : #LeSymbolAnnotationHtmlPostAbstractVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLeSymbolParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeSymbolParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #initialization }
LeSymbolAnnotationHtmlPostAbstractVisitor class >> initialize [
	LeHtmlTextSnippetPostAbstractVisitor addComponentVisitorClass: self

]

{ #category : #initialization }
LeSymbolAnnotationHtmlPostAbstractVisitor class >> obsolete [
	LeHtmlTextSnippetPostAbstractVisitor removeComponentVisitorClass: self.
	^ super obsolete

]

{ #category : #accessing }
LeSymbolAnnotationHtmlPostAbstractVisitor >> context [
	^ self composite context

]

{ #category : #visiting }
LeSymbolAnnotationHtmlPostAbstractVisitor >> visitSymbolAnnotation: aSymbolAnnotation [
	aSymbolAnnotation symbolName ifNil: [ ^ self ].

	self context html escape: '#' , aSymbolAnnotation symbolName

]

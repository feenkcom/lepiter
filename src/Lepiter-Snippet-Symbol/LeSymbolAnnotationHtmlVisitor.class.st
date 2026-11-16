"
I write `gtSymbol` annotations ({{gtClass:LeSymbolAnnotationNode}}) to HTML as a code label, for example `#asString`.
I am a component visitor of {{gtClass:LeHtmlTextSnippetVisitor}}: I register myself in {{gtMethod:LeSymbolAnnotationHtmlVisitor class>>#initialize}} and deregister in {{gtMethod:LeSymbolAnnotationHtmlVisitor class>>#obsolete}}, so the core {{gtPackage:Lepiter-HTML}} package does not depend on {{gtPackage:Lepiter-Snippet-Symbol}}.
See {{gtExample:LeSymbolAnnotationExportExamples>>#htmlTextSnippetWithSymbolAnnotation}}.
"
Class {
	#name : #LeSymbolAnnotationHtmlVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLeSymbolParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeSymbolParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #initialization }
LeSymbolAnnotationHtmlVisitor class >> initialize [
	LeHtmlTextSnippetVisitor addComponentVisitorClass: self

]

{ #category : #initialization }
LeSymbolAnnotationHtmlVisitor class >> obsolete [
	LeHtmlTextSnippetVisitor removeComponentVisitorClass: self.
	^ super obsolete

]

{ #category : #accessing }
LeSymbolAnnotationHtmlVisitor >> context [
	^ self composite context

]

{ #category : #visiting }
LeSymbolAnnotationHtmlVisitor >> visitSymbolAnnotation: aSymbolAnnotation [
	aSymbolAnnotation symbolName ifNil: [ ^ self ].

	self context html
		inlineTag: 'code'
		attributes: #('class' 'annotation annotation-label annotation-label-symbol')
		with: '#' , aSymbolAnnotation symbolName

]

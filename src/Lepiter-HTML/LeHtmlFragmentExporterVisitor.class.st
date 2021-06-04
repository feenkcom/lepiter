"
Write the supplied LeModel on to the stream as an HTML fragment that uses DIVs to reflect the document structure and annotations.

This is a HTML fragment in that it doesn't contain metadata. body tag, etc.

To export a page as a complete HTML document see {{gtClass:name=LeHtmlPageExporterVisitor}}.

To export a fragment to the supplied stream see {{gtMethod:name=LeContent>>#asHTMLFragment}}.

"
Class {
	#name : #LeHtmlFragmentExporterVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'stream',
		'level',
		'externalPicturesWriter'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> externalPicturesWriter [
	^ externalPicturesWriter
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> externalPicturesWriter: aDataWriter [
	externalPicturesWriter := aDataWriter
]

{ #category : #initialization }
LeHtmlFragmentExporterVisitor >> initialize [

	super initialize.
	level := 1.
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> stream [
	^ stream
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> stream: anObject [
	stream := anObject
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitContent: aLeContent [

	aLeContent hasChildren ifFalse: [ ^ self ].
	level := level + 1.
	stream 
		<< '<div class="content_children" style="margin-left: ';
		print: level * 20;
		<< 'pt';
		<< '">'.
	aLeContent children acceptVisitor: self.
	stream << '</div>'; cr.

]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitPage: aLePage [

	"Iterate over children, but don't mark as child content"
	aLePage children acceptVisitor: self.

]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitPharoSnippet: aLePharoSnippet [

	stream
		<< '<div class="pharo_snippet codeBlock">';
		<< '<pre>';
		<< '<code class="hljs smalltalk">';
		<< aLePharoSnippet code asHTMLString.
	self visitTextualSnippet: aLePharoSnippet.
	stream
		<< '</code>';
		<< '</pre>';
		<< '</div>';
		cr.

]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitTextSnippet: aLeTextSnippet [

	stream << '<div class="text_snippet">'.
	aLeTextSnippet ast acceptVisitor: (LeHtmlExporterTextSnippetVisitor new 
		stream: stream;
		externalPicturesWriter: self externalPicturesWriter).
	self visitTextualSnippet: aLeTextSnippet.
	stream
		<< '</div>';
		cr.

]

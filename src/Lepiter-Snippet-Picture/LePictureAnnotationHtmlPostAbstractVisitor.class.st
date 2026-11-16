"
I write `gtPictureReference` annotations ({{gtClass:LePictureAnnotationNode}}) as plain text into page abstracts (e.g. HTML page descriptions): the label the editor shows ({{gtMethod:LePictureSnippetReference>>#label}}), or the reference if the picture does not exist.
I am a component visitor of {{gtClass:LeHtmlTextSnippetPostAbstractVisitor}}: I register myself in {{gtMethod:LePictureAnnotationHtmlPostAbstractVisitor class>>#initialize}} and deregister in {{gtMethod:LePictureAnnotationHtmlPostAbstractVisitor class>>#obsolete}}.
See {{gtExample:LePictureAnnotationExportExamples>>#postAbstractTextSnippetWithResolvedPictureAnnotation}}.
"
Class {
	#name : #LePictureAnnotationHtmlPostAbstractVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLePictureParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLePictureParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #initialization }
LePictureAnnotationHtmlPostAbstractVisitor class >> initialize [
	LeHtmlTextSnippetPostAbstractVisitor addComponentVisitorClass: self

]

{ #category : #initialization }
LePictureAnnotationHtmlPostAbstractVisitor class >> obsolete [
	LeHtmlTextSnippetPostAbstractVisitor removeComponentVisitorClass: self.
	^ super obsolete

]

{ #category : #accessing }
LePictureAnnotationHtmlPostAbstractVisitor >> context [
	^ self composite context

]

{ #category : #accessing }
LePictureAnnotationHtmlPostAbstractVisitor >> page [
	"Answer the exported page, or the page of the exported snippet"

	^ self context page
		ifNil: [ self composite snippet ifNotNil: [ :aSnippet | aSnippet page ] ]

]

{ #category : #visiting }
LePictureAnnotationHtmlPostAbstractVisitor >> visitPictureAnnotation: aPictureAnnotation [
	| aReference |
	aReference := aPictureAnnotation pictureReference.

	self context html
		escape: ((LePictureSnippetReference forReference: aReference inPage: self page)
				ifNil: [ aReference ifNil: [ '' ] ]
				ifNotNil: [ :aPictureSnippetReference | aPictureSnippetReference label ])

]

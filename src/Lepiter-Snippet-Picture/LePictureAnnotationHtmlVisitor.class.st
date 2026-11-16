"
I write `gtPictureReference` annotations ({{gtClass:LePictureAnnotationNode}}) to HTML with the label the editor shows ({{gtMethod:LePictureSnippetReference>>#label}}), for example ""Figure 3"".
The label links to the figure element of the picture snippet (see {{gtMethod:LeHtmlFigureImageWriter class>>#elementIdForPictureReference:}}): `#figure-<reference>` on the same page, `<page file>#figure-<reference>` on another exported page. If the page of the picture is not exported, I write the label without a link. If the picture does not exist, I write the reference and log a {{gtClass:LeExportUnresolvedAnnotationLogItem}}.
I am a component visitor of {{gtClass:LeHtmlTextSnippetVisitor}}: I register myself in {{gtMethod:LePictureAnnotationHtmlVisitor class>>#initialize}} and deregister in {{gtMethod:LePictureAnnotationHtmlVisitor class>>#obsolete}}, so the core {{gtPackage:Lepiter-HTML}} package does not depend on {{gtPackage:Lepiter-Snippet-Picture}}.
See {{gtExample:LePictureAnnotationExportExamples>>#htmlTextSnippetWithPictureAnnotationOnSamePage}} and {{gtExample:LePictureAnnotationExportExamples>>#htmlTextSnippetWithPictureAnnotationOnOtherPage}}.
"
Class {
	#name : #LePictureAnnotationHtmlVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLePictureParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLePictureParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #initialization }
LePictureAnnotationHtmlVisitor class >> initialize [
	LeHtmlTextSnippetVisitor addComponentVisitorClass: self

]

{ #category : #initialization }
LePictureAnnotationHtmlVisitor class >> obsolete [
	LeHtmlTextSnippetVisitor removeComponentVisitorClass: self.
	^ super obsolete

]

{ #category : #private }
LePictureAnnotationHtmlVisitor >> annotationClass [
	^ 'annotation annotation-label annotation-label-picture'

]

{ #category : #accessing }
LePictureAnnotationHtmlVisitor >> context [
	^ self composite context

]

{ #category : #private }
LePictureAnnotationHtmlVisitor >> hrefFor: aPictureSnippetReference [
	"Answer the href of the picture figure, or nil if the page of the picture is not exported"

	| anElementId aPage |
	anElementId := LeHtmlFigureImageWriter
			elementIdForPictureReference: aPictureSnippetReference reference.
	aPage := aPictureSnippetReference page.
	aPage = self page ifTrue: [ ^ '#' , anElementId ].
	aPage ifNil: [ ^ nil ].

	^ self context pageLinks
		linkForPage: aPage
		ifFound: [ :aPageLink | (self context hrefBuilder hrefFromPageLink: aPageLink) , '#' , anElementId ]
		ifNone: [ nil ]

]

{ #category : #private }
LePictureAnnotationHtmlVisitor >> logUnresolvedPictureAnnotation: aPictureAnnotation [
	^ self context log
		addItem: (LeExportUnresolvedAnnotationLogItem new
				snippet: self snippet;
				annotation: aPictureAnnotation;
				reason: ('Picture reference not found: {1}'
						format: {aPictureAnnotation pictureReference ifNil: [ '' ]}))

]

{ #category : #accessing }
LePictureAnnotationHtmlVisitor >> page [
	"Answer the exported page, or the page of the exported snippet"

	^ self context page ifNil: [ self snippet ifNotNil: [ :aSnippet | aSnippet page ] ]

]

{ #category : #accessing }
LePictureAnnotationHtmlVisitor >> snippet [
	^ self composite snippet

]

{ #category : #visiting }
LePictureAnnotationHtmlVisitor >> visitPictureAnnotation: aPictureAnnotation [
	| aReference aPictureSnippetReference anHref |
	aReference := aPictureAnnotation pictureReference.
	aPictureSnippetReference := LePictureSnippetReference
			forReference: aReference
			inPage: self page.

	aPictureSnippetReference
		ifNil: [ self logUnresolvedPictureAnnotation: aPictureAnnotation.
			^ self context html
				inlineTag: 'span'
				attributes: {'class'.
						self annotationClass , ' annotation-label-missing'}
				with: (aReference ifNil: [ '' ]) ].

	anHref := self hrefFor: aPictureSnippetReference.
	anHref
		ifNil: [ self context html
				inlineTag: 'span'
				attributes: {'class'.
						self annotationClass}
				with: aPictureSnippetReference label ]
		ifNotNil: [ self context html
				inlineTag: 'a'
				attributes: {'class'.
						self annotationClass.
						'href'.
						anHref}
				with: aPictureSnippetReference label ]

]

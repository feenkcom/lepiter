"
I collect the element ids of the picture snippets with a reference in a page (see {{gtMethod:LeHtmlFigureImageWriter class>>#elementIdForPictureReference:}}).
{{gtMethod:LeHtmlVisitor>>#visitPage:}} uses me to reserve these ids before it writes the page. A header whose id would equal a figure id then gets the usual uniqueness suffix ({{gtMethod:LeHtmlElementIdBuilder>>#ensureUniqueId}}), even when the header comes before the picture. Figure ids never change, because `gtPictureReference` links on other pages compute them from the reference only, without seeing the headers of the target page.
I only need the core model visitor protocol ({{gtMethod:TLeModelVisitor>>#visitPictureSnippet:}}), so {{gtPackage:Lepiter-HTML}} does not depend on {{gtPackage:Lepiter-Snippet-Picture}}.
See {{gtExample:LeHtmlVisitorExamples>>#pageWithHeaderMatchingFigureId}}.
"
Class {
	#name : #LeHtmlFigureElementIdsCollector,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'elementIds'
	],
	#category : #'Lepiter-HTML-Support'
}

{ #category : #accessing }
LeHtmlFigureElementIdsCollector >> elementIds [
	^ elementIds ifNil: [ elementIds := OrderedCollection new ]

]

{ #category : #accessing }
LeHtmlFigureElementIdsCollector >> elementIds: aCollection [
	"Set the collection to which I add the figure ids"

	elementIds := aCollection

]

{ #category : #visiting }
LeHtmlFigureElementIdsCollector >> visitPictureSnippet: aLePictureSnippet [
	aLePictureSnippet hasReference
		ifTrue: [ self elementIds
				addIfNotPresent: (LeHtmlFigureImageWriter
						elementIdForPictureReference: aLePictureSnippet reference) ].

	^ self visitContent: aLePictureSnippet

]

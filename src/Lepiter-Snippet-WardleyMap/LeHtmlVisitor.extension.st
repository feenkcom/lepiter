Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
LeHtmlVisitor >> visitWardleyMapSnippet: aLeWardleySnippet [
	| snippetResources caption |
	snippetResources := self resourcesFor: aLeWardleySnippet.
	caption := aLeWardleySnippet title
			ifNotNil: [ :aString | aString trimBoth asString ].

	snippetResources
		ifEmpty: [  "ignore" ]
		ifOne: [ :aResource | 
			LeHtmlFigureImageWriter new
				html: context html;
				imageSrc: aResource pathName;
				caption: caption;
				width: aLeWardleySnippet asSnippetViewModel snippetView desiredSnippetWidth;
				write ]
		ifMore: [  "ignore":aCollection |  ].

	^ self visitContent: aLeWardleySnippet
]

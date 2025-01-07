Trait {
	#name : #TLeHtmlAuthor,
	#category : #'Lepiter-HTML-Support'
}

{ #category : #'api - writing' }
TLeHtmlAuthor >> writeWithContext: aContext [
	"Write the HTML output using a context html stream.
	Called by LeHtmlAuthorPiece>>#writeWithContext:."

	self explicitRequirement
]

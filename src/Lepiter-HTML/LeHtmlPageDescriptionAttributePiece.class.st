Class {
	#name : #LeHtmlPageDescriptionAttributePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlPageDescriptionAttributePiece >> isDescriptionSnippet: aSnippet [
	^ aSnippet isTextSnippet 
		and: [ aSnippet text isNotEmpty 
		and: [ ((aSnippet text at: 1) = $#) not ] ]
]

{ #category : #'api - writing' }
LeHtmlPageDescriptionAttributePiece >> writeWithContext: aContext [
	| aPage |
	aPage := aContext page.
	aPage ifNil: [ ^ self ].
	
	aPage childrenDo: [ :aSnippet | 
		(self isDescriptionSnippet: aSnippet) ifTrue: [ 
			| aVisitor aVisitorContext anHtml |
			anHtml := String streamContents: [ :aStream | 
				aVisitorContext := aContext copyWithNewStream: aStream.
				aVisitor := LeHtmlTextSnippetPostAbstractVisitor new
					context: aVisitorContext;
					snippet: aSnippet.
				aSnippet ast acceptVisitor: aVisitor ]. 
		
			aContext html escapeAttributeValue: anHtml.
			^ self
		]
	].
	
	aContext html escape: aPage title.
]

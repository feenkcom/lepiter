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
		
			"The visitor writes an HTML text that is already escaped (ampersand, less-than),
			so escaping it again would double the escapes. Only the quotes of the attribute value are left."
			aContext html nextPutAll: (anHtml copyReplaceAll: '"' with: '&quot;').
			^ self
		]
	].
	
	aContext html escapeAttributeValue: aPage title
]

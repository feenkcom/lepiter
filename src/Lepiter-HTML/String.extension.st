Extension { #name : #String }

{ #category : #'*Lepiter-HTML' }
String >> asLeHtmlFormatPiece [
	^ LeHtmlStringPiece new string: self
]

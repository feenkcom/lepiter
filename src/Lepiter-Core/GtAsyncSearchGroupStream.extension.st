Extension { #name : #GtAsyncSearchGroupStream }

{ #category : #'*Lepiter-Core' }
GtAsyncSearchGroupStream >> leHighlighters [
	^ filter notNil ifTrue: [ filter leHighlighters ] ifFalse: [ Dictionary new ]
]

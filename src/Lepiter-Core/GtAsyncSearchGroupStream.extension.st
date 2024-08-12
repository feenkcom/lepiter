Extension { #name : #GtAsyncSearchGroupStream }

{ #category : #'*Lepiter-Core' }
GtAsyncSearchGroupStream >> leHighlighter [
	^ filter notNil ifTrue: [ filter leHighlighter ] ifFalse: [ nil ]
]

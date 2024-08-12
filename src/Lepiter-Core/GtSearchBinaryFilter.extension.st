Extension { #name : #GtSearchBinaryFilter }

{ #category : #'*Lepiter-Core' }
GtSearchBinaryFilter >> leHighlighter [
	^ left leHighlighter
		ifNil: [ right leHighlighter ]
		ifNotNil: [ :lh | 
			right leHighlighter
				ifNil: [ lh ]
				ifNotNil:
					[ :rh | GtCompositeHighlighter forHighlighters: (Array with: lh with: rh) ] ]
]

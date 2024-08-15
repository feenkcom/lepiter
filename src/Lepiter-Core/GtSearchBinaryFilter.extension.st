Extension { #name : #GtSearchBinaryFilter }

{ #category : #'*Lepiter-Core' }
GtSearchBinaryFilter >> leHighlighters [
	| highlighters |
	highlighters := left leHighlighters copy.
	right leHighlighters
		keysAndValuesDo: [ :key :value | 
			highlighters
				at: key
				ifPresent: [ :leftValue | 
					GtCompositeHighlighter
						forHighlighters: {leftValue.
								value} ]
				ifAbsentPut: [ value ] ].
	^ highlighters
]

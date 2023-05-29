Extension { #name : #GtResourceReference }

{ #category : #'*Lepiter-Store' }
GtResourceReference >> lepiterDbUrlEquals: anObject [

	^ self fileReference lepiterDbUrlEquals: anObject
]

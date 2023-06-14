Extension { #name : #GtResourceReference }

{ #category : #'*Lepiter-Store' }
GtResourceReference >> asLepiterZnUrl [
	^ self fileReference asLepiterZnUrl
]

{ #category : #'*Lepiter-Store' }
GtResourceReference >> lepiterDbUrlEquals: anObject [

	^ self fileReference lepiterDbUrlEquals: anObject
]

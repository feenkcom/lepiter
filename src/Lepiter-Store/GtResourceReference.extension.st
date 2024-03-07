Extension { #name : #GtResourceReference }

{ #category : #'*Lepiter-Store' }
GtResourceReference >> asLepiterFileReference [
	^ self
]

{ #category : #'*Lepiter-Store' }
GtResourceReference >> asLepiterZnUrl [
	^ self asFileLocator asLepiterZnUrl
]

{ #category : #'*Lepiter-Store' }
GtResourceReference >> lepiterDbUrlEquals: anObject [

	^ self fileReference lepiterDbUrlEquals: anObject
]

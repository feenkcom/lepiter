Extension { #name : #String }

{ #category : #'*Lepiter-Store' }
String >> asLepiterFileReference [

	^ self asZnUrl asLepiterFileReference
]

{ #category : #'*Lepiter-Store' }
String >> lepiterDbUrlEquals: anObject [

	^ self asZnUrl lepiterDbUrlEquals: anObject
]

{ #category : #'*Lepiter-Store' }
String >> lepiterDbUrlEqualsFileReference: anObject [

	^ self asZnUrl lepiterDbUrlEqualsFileReference: anObject
]

{ #category : #'*Lepiter-Store' }
String >> lepiterDbUrlEqualsZnUrl: anObject [

	^ self asZnUrl lepiterDbUrlEqualsZnUrl: anObject
]

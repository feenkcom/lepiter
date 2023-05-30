Extension { #name : #AbstractFileReference }

{ #category : #'*Lepiter-Store' }
AbstractFileReference >> asLepiterFileReference [

	^ self
]

{ #category : #'*Lepiter-Store' }
AbstractFileReference >> asLepiterZnUrl [

	^ self subclassResponsibility
]

{ #category : #'*Lepiter-Store' }
AbstractFileReference >> isLepiterDatabaseFolder [
	| propertiesFile |
	self isDirectory ifFalse: [ ^ false ].
	propertiesFile := self / LepiterCoreDefaults databasePropertiesBasename.
	^ propertiesFile exists 
]

{ #category : #'*Lepiter-Store' }
AbstractFileReference >> lepiterDbUrlEquals: anObject [

	^ anObject lepiterDbUrlEqualsFileReference: self resolve
]

{ #category : #'*Lepiter-Store' }
AbstractFileReference >> lepiterDbUrlEqualsFileReference: anObject [

	^ anObject resolve = self resolve
]

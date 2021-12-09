Extension { #name : #AbstractFileReference }

{ #category : #'*Lepiter-Store' }
AbstractFileReference >> isLepiterDatabaseFolder [
	| propertiesFile |
	self isDirectory ifFalse: [ ^ false ].
	propertiesFile := self / LepiterCoreDefaults databasePropertiesBasename.
	^ propertiesFile exists 
]

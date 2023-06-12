Extension { #name : #LeDatabasesRegistry }

{ #category : #'*Lepiter-Store' }
LeDatabasesRegistry >> loadDefaultLogicalDatabase [

	^ LeLogicalDatabaseProperties default logicalDatabase
]

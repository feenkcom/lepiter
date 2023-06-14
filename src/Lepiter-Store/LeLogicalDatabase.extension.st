Extension { #name : #LeLogicalDatabase }

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> reload [ 

	LeLogicalDatabaseReload new 
		database: self;
		reload
]

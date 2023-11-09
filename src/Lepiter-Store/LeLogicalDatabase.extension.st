Extension { #name : #LeLogicalDatabase }

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> reload [ 
	self reloadWithErrorStrategy: LeDatabaseContentReloadErrorStrategy forkDebuggerOnErrorStrategy
]

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> reloadWithErrorStrategy: aContentReloadErrorStrategy [

	LeLogicalDatabaseReload new 
		database: self;
		contentReloadErrorStrategy: aContentReloadErrorStrategy;
		reload
]

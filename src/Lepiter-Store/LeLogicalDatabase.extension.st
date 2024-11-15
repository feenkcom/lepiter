Extension { #name : #LeLogicalDatabase }

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> fullReload [
	LeReloadOptimization disableDuring: [ self reload ]
]

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> reload [ 
	self reloadWithForkedDebugging
]

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> reloadWithErrorDebugging [
	self reloadWithErrorStrategy: LeDatabaseContentReloadErrorStrategy showDebuggerOnErrorStrategy
]

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> reloadWithErrorStrategy: aContentReloadErrorStrategy [

	LeLogicalDatabaseReload new 
		database: self;
		contentReloadErrorStrategy: aContentReloadErrorStrategy;
		reload
]

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> reloadWithForkedDebugging [
	self reloadWithErrorStrategy: LeDatabaseContentReloadErrorStrategy forkDebuggerOnErrorStrategy
]

{ #category : #'*Lepiter-Store' }
LeLogicalDatabase >> reloadWithNotificationOnError [
	self reloadWithErrorStrategy: LeDatabaseContentReloadErrorStrategy singleNotificationOnErrorStrategy
]

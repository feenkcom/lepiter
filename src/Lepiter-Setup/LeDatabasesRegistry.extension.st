Extension { #name : #LeDatabasesRegistry }

{ #category : #'*Lepiter-Setup' }
LeDatabasesRegistry >> setupWithLogicalDatabaseProperties: aDatabaseProperties [
	"Initialize registry from {{gtClass:LeDatabaseRegistrations}}."

	<return: #LeLogicalDatabase>
	self assert: [ defaultLogicalDatabase isNil ].

	self defaultLogicalDatabase: aDatabaseProperties logicalDatabase.
	^ self currentLoadedDefaultLogicalDatabase
]

"
This is a strategy that controls what happens when an error is encountered during the reload of a piece of content (e.g. page, link) in a database.

Subclasses should decide how to react by implementing {{gtMethod:LeDatabaseContentReloadErrorStrategy>>#executeManaged:|label=#selector}}.  The idea behind this is to wrap the loading of pages, links and any other content though this method, so that it can react to errors. 

It must be possible to continue execution, if for example, errors are just logged. So only the loading of individual pices of content should be done through this strategy. If an error should stop the reload this strategy should not be used.

Subclasses can also make use of two callback methods ({{gtMethod:LeDatabaseContentReloadErrorStrategy>>#actBeforeDatabaseReloadFor:|label=#selector}}, {{gtMethod:LeDatabaseContentReloadErrorStrategy>>#actAfterDatabaseReloadFor:|label=#selector}}) that are called before and after the database reload where this strategy is used. When reloading a logical database, these callbacks methods are called for each individual strategy (the strategy is unaware of logical database).
"
Class {
	#name : #LeDatabaseContentReloadErrorStrategy,
	#superclass : #Object,
	#category : #'Lepiter-Store-Reload'
}

{ #category : #accessing }
LeDatabaseContentReloadErrorStrategy class >> forkDebuggerOnErrorStrategy [
	^ LeForkDebuggerContentReloadErrorStrategy new
]

{ #category : #accessing }
LeDatabaseContentReloadErrorStrategy class >> showDebuggerOnErrorStrategy [
	^ LeShowDebuggerContentReloadErrorStrategy new
]

{ #category : #accessing }
LeDatabaseContentReloadErrorStrategy class >> singleNotificationOnErrorStrategy [
	^ LeSingleNotificationContentReloadErrorStrategy new
]

{ #category : #callbacks }
LeDatabaseContentReloadErrorStrategy >> actAfterDatabaseReloadFor: aDatabase [
	"Callback method called before the database reload where this strategy will be used is started"
]

{ #category : #callbacks }
LeDatabaseContentReloadErrorStrategy >> actBeforeDatabaseReloadFor: aDatabase [
	"Callback method called after the database reload where this strategy will be used is completed"
]

{ #category : #action }
LeDatabaseContentReloadErrorStrategy >> executeManaged: aBlock [
	"Execute the given block by handling errors according to this strategy"
	self subclassResponsibility
]

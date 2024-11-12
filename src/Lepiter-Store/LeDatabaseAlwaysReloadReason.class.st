Class {
	#name : #LeDatabaseAlwaysReloadReason,
	#superclass : #LeDatabaseReloadReason,
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #printing }
LeDatabaseAlwaysReloadReason >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Reload always: '.
	aStream nextPutAll: self database databaseName
]

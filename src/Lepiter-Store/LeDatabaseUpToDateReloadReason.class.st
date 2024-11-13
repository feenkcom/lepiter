Class {
	#name : #LeDatabaseUpToDateReloadReason,
	#superclass : #LeDatabaseReloadReason,
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #printing }
LeDatabaseUpToDateReloadReason >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Up-to-date: '.
	aStream nextPutAll: self database databaseName.
]

{ #category : #testing }
LeDatabaseUpToDateReloadReason >> ifUpToDate: anUpToDateBlock ifOutOfDate: anOutOfDateBlock [
	^ anUpToDateBlock cull: self
]

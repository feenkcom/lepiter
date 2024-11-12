Class {
	#name : #LeDatabaseMissingHashReloadReason,
	#superclass : #LeDatabaseReloadReason,
	#instVars : [
		'model'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #printing }
LeDatabaseMissingHashReloadReason >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Missing hash: '.
	aStream nextPutAll: self database databaseName.
	aStream nextPutAll: ', '.
	self model gtDisplayOn: aStream
]

{ #category : #'gt - extensions' }
LeDatabaseMissingHashReloadReason >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Model';
					value: self model}
]

{ #category : #accessing }
LeDatabaseMissingHashReloadReason >> model [
	^ model
]

{ #category : #accessing }
LeDatabaseMissingHashReloadReason >> model: anObject [
	model := anObject
]

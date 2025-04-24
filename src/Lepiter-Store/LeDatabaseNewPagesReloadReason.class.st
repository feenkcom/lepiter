Class {
	#name : #LeDatabaseNewPagesReloadReason,
	#superclass : #LeDatabaseReloadReason,
	#instVars : [
		'pageUIDs'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #printing }
LeDatabaseNewPagesReloadReason >> gtDisplayOn: aStream [

	aStream
		<< (pageUIDs ifNil: [ 'An unknown number of' ] ifNotNil: [ pageUIDs size asString ]);
		<< ' pages changed in ';
		<< self database databaseName
]

{ #category : #printing }
LeDatabaseNewPagesReloadReason >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Number of pages';
					value: (pageUIDs ifNil: [ 'Unknown' ] ifNotNil: [ pageUIDs size ]). }
]

{ #category : #accessing }
LeDatabaseNewPagesReloadReason >> pageUIDs [
	^ pageUIDs
]

{ #category : #accessing }
LeDatabaseNewPagesReloadReason >> pageUIDs: anObject [
	pageUIDs := anObject
]

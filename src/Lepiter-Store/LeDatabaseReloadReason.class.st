Class {
	#name : #LeDatabaseReloadReason,
	#superclass : #LeReloadReason,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #accessing }
LeDatabaseReloadReason >> database [
	^ database
]

{ #category : #accessing }
LeDatabaseReloadReason >> database: anObject [
	database := anObject
]

{ #category : #'gt - extensions' }
LeDatabaseReloadReason >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Database';
					value: self database}
]

{ #category : #testing }
LeDatabaseReloadReason >> ifUpToDate: anUpToDateBlock ifOutOfDate: anOutOfDateBlock [
	^ anOutOfDateBlock cull: self
]

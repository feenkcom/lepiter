Class {
	#name : #LeDatabaseFileChangedReloadReason,
	#superclass : #LeDatabaseReloadReason,
	#instVars : [
		'model',
		'modelHash',
		'storageHash'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #'gt - extensions' }
LeDatabaseFileChangedReloadReason >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Model';
					value: self model.
				GtPhlowOverviewItem new
					name: 'Model hash';
					value: self modelHash.
				GtPhlowOverviewItem new
					name: 'Storage hash';
					value: self storageHash;
					if: self storageHash isNil
						description: ('Undefined' asRopedText foreground: BrGlamorousColors disabledButtonTextColor)}
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> model [
	^ model
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> model: anObject [
	model := anObject
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> modelHash [
	^ modelHash
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> modelHash: anObject [
	modelHash := anObject
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> storageHash [
	^ storageHash
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> storageHash: anObject [
	storageHash := anObject
]

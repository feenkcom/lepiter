Class {
	#name : #LeDatabaseFileChangedReloadReason,
	#superclass : #LeDatabaseReloadReason,
	#instVars : [
		'model',
		'file',
		'fileHash',
		'modelHash'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> existingHash [
	^ modelHash
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> existingHash: anObject [
	modelHash := anObject
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> file [
	^ file
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> file: anObject [
	file := anObject
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> fileHash [
	^ fileHash
]

{ #category : #accessing }
LeDatabaseFileChangedReloadReason >> fileHash: anObject [
	fileHash := anObject
]

{ #category : #'gt - extensions' }
LeDatabaseFileChangedReloadReason >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Model';
					value: self model.
				GtPhlowOverviewItem new
					name: 'File';
					value: self file.
				GtPhlowOverviewItem new
					name: 'Model hash';
					value: self existingHash.
				GtPhlowOverviewItem new
					name: 'File hash';
					value: self fileHash;
					if: self fileHash isNil
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

Class {
	#name : #LeDatabasePropertiesChangedReloadReason,
	#superclass : #LeDatabaseReloadReason,
	#instVars : [
		'currentProperties',
		'storageProperties'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #accessing }
LeDatabasePropertiesChangedReloadReason >> currentProperties [
	^ currentProperties
]

{ #category : #accessing }
LeDatabasePropertiesChangedReloadReason >> currentProperties: anObject [
	currentProperties := anObject
]

{ #category : #printing }
LeDatabasePropertiesChangedReloadReason >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Properties changed: '.
	aStream nextPutAll: self database databaseName
]

{ #category : #'gt - extensions' }
LeDatabasePropertiesChangedReloadReason >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Database properties';
					value: self currentProperties.
				GtPhlowOverviewItem new
					name: 'Storage properties';
					value: self storageProperties}
]

{ #category : #accessing }
LeDatabasePropertiesChangedReloadReason >> storageProperties [
	^ storageProperties
]

{ #category : #accessing }
LeDatabasePropertiesChangedReloadReason >> storageProperties: anObject [
	storageProperties := anObject
]

Extension { #name : #GtPhlowObjectToSpawn }

{ #category : #'*Lepiter-UI-Snippet' }
GtPhlowObjectToSpawn >> spawnContainer [
	^ self propertyAt: #spawnContainer ifAbsent: [ nil ]
]

{ #category : #'*Lepiter-UI-Snippet' }
GtPhlowObjectToSpawn >> spawnContainer: anElement [
	self propertyAt: #spawnContainer put: anElement
]

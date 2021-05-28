Extension { #name : #LeDatabase }

{ #category : #'*Lepiter-Translator-Roam' }
LeDatabase class >> fromRoamJsonFile: aFileReference [
	^ LeRoamJsonTranslator default databaseFromFile: aFileReference
]

{ #category : #'*Lepiter-Translator-Roam' }
LeDatabase >> toRoamJsonFile: aFileReference [
	LeRoamJsonTranslator default database: self toFile: aFileReference
]

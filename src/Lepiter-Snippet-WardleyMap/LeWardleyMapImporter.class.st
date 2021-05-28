Class {
	#name : #LeWardleyMapImporter,
	#superclass : #GtWardleyMapFromDictionaryImporter,
	#category : #'Lepiter-Snippet-WardleyMap-Exporter / Importer'
}

{ #category : #'api - importer' }
LeWardleyMapImporter >> importIdFrom: aUUID [
	"UUID is instantiated as part of the json -> dictionary lepiter convertion"

	^ aUUID
]

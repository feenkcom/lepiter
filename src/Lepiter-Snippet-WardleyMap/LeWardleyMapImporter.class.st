Class {
	#name : #LeWardleyMapImporter,
	#superclass : #GtWardleyMapFromDictionaryImporter,
	#category : #'Lepiter-Snippet-WardleyMap-Exporter / Importer'
}

{ #category : #'api - importer' }
LeWardleyMapImporter >> importIdFrom: aUUID [
	"UUID is instantiated as part of the json -> dictionary lepiter convertion"

	aUUID isDictionary ifFalse: [ ^ aUUID ].
	
	"When LeSnippetViewModel>>#insertNewSnippet: path execution is used, 
	the given aUUID is a dictionary with __type and uuid keys."
	^ UUID leFromJsonV4Dictionary: aUUID.
]

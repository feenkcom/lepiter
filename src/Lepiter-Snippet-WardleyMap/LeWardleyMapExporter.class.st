Class {
	#name : #LeWardleyMapExporter,
	#superclass : #GtWardleyMapAsDictionaryExporter,
	#category : #'Lepiter-Snippet-WardleyMap-Exporter / Importer'
}

{ #category : #visiting }
LeWardleyMapExporter >> visitWardleyId: aUUID [
	^ OrderedDictionary new
		at: #__type put: 'uuid';
		at: #uuid put: aUUID asString;
		yourself
]

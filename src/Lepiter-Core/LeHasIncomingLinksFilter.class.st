Class {
	#name : #LeHasIncomingLinksFilter,
	#superclass : #LeFilter,
	#category : #'Lepiter-Core-Database - Filters'
}

{ #category : #accessing }
LeHasIncomingLinksFilter class >> filterDescriptorFor: aLeDatabase do: aBlock [
	aBlock
		value:
			(GtFilterDescriptor
				creator: [ :value | self new ]
				named: 'Has incoming links'
				order: 13) valueNotRequired.
	aBlock
		value:
			(GtFilterDescriptor
				creator: [ :value | self new not ]
				named: 'No incoming links'
				order: 13) valueNotRequired
]

{ #category : #testing }
LeHasIncomingLinksFilter >> matches: aLeContent [
	^ aLeContent hasIncomingLinks
]

{ #category : #printing }
LeHasIncomingLinksFilter >> printOn: aStream [
	aStream
		nextPutAll: 'Page is referenced'
]

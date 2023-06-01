Trait {
	#name : #TLeExportContext,
	#category : #'Lepiter-Export-! Core'
}

{ #category : #accessing }
TLeExportContext >> fileStore [
	"Return file store that is used to store resource files"

	<return: #TLeExportFileStore>
	^ self explicitRequirement
]

{ #category : #'api - builders' }
TLeExportContext >> objectSpecificationFor: anObject [
	"Return object specification for a given object"

	<return: #TLeExportObjectSpecification>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportContext >> resources [
	"Return object specification for a given object"

	<return: #TLeExportResources>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportContext >> sequencer [
	"Return sequencer that generates unique IDs"

	<return: #TLeExportSequencer>
	^ self explicitRequirement
]

Trait {
	#name : #TLeExportSequencer,
	#category : #'Lepiter-Export-Sequencers'
}

{ #category : #accessing }
TLeExportSequencer >> nextId [
	<return: #String>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportSequencer >> nextIdFromPage: aLePage [
	"Return next unique id that can be used to identify objects.
	The {{gtClass:LePage}} instance can be used to generate the id."

	<return: #String>
	^ aLePage uid asString36
]

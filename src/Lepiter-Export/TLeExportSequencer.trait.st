Trait {
	#name : #TLeExportSequencer,
	#category : #'Lepiter-Export-Sequencers'
}

{ #category : #accessing }
TLeExportSequencer >> nextId [
	<return: #String>
	^ self explicitRequirement
]

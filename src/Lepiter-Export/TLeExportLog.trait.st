Trait {
	#name : #TLeExportLog,
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #'add / remove' }
TLeExportLog >> addItem: aLogItem [
	self explicitRequirement
]

{ #category : #converting }
TLeExportLog >> asArray [
	<return: #Array>
	^ self explicitRequirement
]

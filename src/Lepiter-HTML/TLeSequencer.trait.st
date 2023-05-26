Trait {
	#name : #TLeSequencer,
	#category : #'Lepiter-HTML-! New - Support'
}

{ #category : #accessing }
TLeSequencer >> nextId [
	<return: #String>
	^ self explicitRequirement
]

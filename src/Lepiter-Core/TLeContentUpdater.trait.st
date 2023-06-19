"
I proved common API for {{gtClass:LeDatabasePageUpdater}} and {{gtClass:LeDatabaseSnippetUpdater}}.

"
Trait {
	#name : #TLeContentUpdater,
	#category : #'Lepiter-Core-Builders'
}

{ #category : #'private - testing' }
TLeContentUpdater >> hasContent [
	<return: #Boolean>
	^ self explicitRequirement
]

{ #category : #'private - updating' }
TLeContentUpdater >> updateCreateTimeAndEmail [
	self createdNowBy: self database userEmail.
]

{ #category : #'private - updating' }
TLeContentUpdater >> updateEditTimeAndEmail [
	self editedNowBy: self database userEmail.
]

{ #category : #'private - updating' }
TLeContentUpdater >> updateTimeAndEmail [
	self hasContent
		ifTrue: [ self updateEditTimeAndEmail ]
		ifFalse: [ self updateCreateTimeAndEmail ].
]

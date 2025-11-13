Extension { #name : #LePage }

{ #category : #'*Lepiter-Utilities' }
LePage >> gtCommitButtonFor: anAction [
	<gtAction>

	(self database isDatabase not or: [ LeDbManualExternalCommitter uniqueInstance hasDbDirs not ]) 
		ifTrue: [ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousVectorIcons savetodisk;
		tooltip: 'Commit Lepiter Db Directory';
		action: [ :aButton |
			aButton phlow spawnObject: LeDbManualExternalCommitter uniqueInstance commitAll ].
]

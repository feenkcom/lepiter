Extension { #name : #AbstractFileReference }

{ #category : #'*Lepiter-UI-Utilities' }
AbstractFileReference >> gtActionLepiterRegisterDbFor: anAction [
	<gtAction>

	(LeRegisterDbDropdown isUnregisteredLepiterDb: self) ifFalse: [ ^ anAction noAction].
	^ anAction explicit stencil: [ LeRegisterDbDropdown directory: self ]
]

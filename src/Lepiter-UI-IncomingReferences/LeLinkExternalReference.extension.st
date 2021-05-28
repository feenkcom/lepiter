Extension { #name : #LeLinkExternalReference }

{ #category : #'*Lepiter-UI-IncomingReferences' }
LeLinkExternalReference >> asPreviewElement [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: self printString
]

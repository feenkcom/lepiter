Extension { #name : #LeLinkExternalReference }

{ #category : #'*Lepiter-UI-IncomingReferences' }
LeLinkExternalReference >> asPreviewElement [
	^ BrLabel new text: self printString
]

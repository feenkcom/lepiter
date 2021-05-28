Extension { #name : #LeLinkContentReference }

{ #category : #'*Lepiter-UI-IncomingReferences' }
LeLinkContentReference >> asIncomingLinkPreviewElement [
	"I return a ${class:BlElement}$ that is used for as a preview in the incoming link"
	<return: #LeContentElement>

	^ self content asIncomingLinkPreviewElement
]

Extension { #name : #LeLinkReference }

{ #category : #'*Lepiter-UI-IncomingReferences' }
LeLinkReference >> asIncomingLinkPreviewElement [
	"I return a ${class:BlElement}$ that is used for as a preview in the incoming link"
	<return: #LeContentElement>

	^ self subclassResponsibility
]

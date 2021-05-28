Extension { #name : #LeContent }

{ #category : #'*Lepiter-UI-IncomingReferences' }
LeContent >> asIncomingLinkPreviewElement [
	"I return a ${class:BlElement}$ that is used for as a preview in the incoming link"
	<return: #LeContentElement>

	^ self subclassResponsibility
]

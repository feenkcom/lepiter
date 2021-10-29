Extension { #name : #LeNullContent }

{ #category : #'*Lepiter-UI' }
LeNullContent >> asContentUIModel [
	^ LeContentViewModel new content: self
]

{ #category : #'*Lepiter-UI' }
LeNullContent >> hasLinkTarget: aNode [

	^ false
]

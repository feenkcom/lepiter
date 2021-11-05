Class {
	#name : #LeExternalImageLinkNode,
	#superclass : #LeExternalLinkNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeExternalImageLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitExternalImageLink: self
]

{ #category : #accessing }
LeExternalImageLinkNode >> label [ 
	| linkString endOfLabel |

	linkString := self link source.
	endOfLabel := linkString indexOf: $].
	self assert: endOfLabel > 0.
	^ linkString copyFrom: 3 to: endOfLabel - 1.
]

{ #category : #accessing }
LeExternalImageLinkNode >> url [
	| linkString endOfLabel |

	linkString := self link source.
	endOfLabel := linkString indexOfSubCollection: ']('.
	self assert: endOfLabel > 0.
	^ linkString copyFrom: endOfLabel + 2 to: linkString size - 1.
]

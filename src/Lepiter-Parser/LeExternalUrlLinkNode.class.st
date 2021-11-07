Class {
	#name : #LeExternalUrlLinkNode,
	#superclass : #LeExternalLinkNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeExternalUrlLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitExternalUrlLink: self
]

{ #category : #accessing }
LeExternalUrlLinkNode >> url [ 
	| linkString |

	linkString := self link source.
	^ linkString copyFrom: 2 to: linkString size - 1
]

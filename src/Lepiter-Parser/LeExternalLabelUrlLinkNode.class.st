Class {
	#name : #LeExternalLabelUrlLinkNode,
	#superclass : #LeExternalLinkNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeExternalLabelUrlLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitExternalLabelUrlLink: self
]

{ #category : #accessing }
LeExternalLabelUrlLinkNode >> displayLabel [
	"Answer the string that should be used to display the receiver.
	If a label is present, use that, otherwise the URL"

	^ self label ifEmpty: [ self url ]
]

{ #category : #accessing }
LeExternalLabelUrlLinkNode >> label [ 
	| linkString endOfLabel |

	linkString := self link source.
	endOfLabel := linkString indexOf: $].
	self assert: endOfLabel > 0.
	^ linkString copyFrom: 2 to: endOfLabel - 1.
]

{ #category : #accessing }
LeExternalLabelUrlLinkNode >> url [
	| linkString endOfLabel |

	linkString := self link source.
	endOfLabel := linkString indexOfSubCollection: ']('.
	self assert: endOfLabel > 0.
	^ linkString copyFrom: endOfLabel + 2 to: linkString size - 1.
]

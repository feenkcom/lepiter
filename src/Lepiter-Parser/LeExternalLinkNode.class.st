Class {
	#name : #LeExternalLinkNode,
	#superclass : #LeContentNode,
	#instVars : [
		'link'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeExternalLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitExternalLink: self
]

{ #category : #accessing }
LeExternalLinkNode >> displayLabel [
	"Answer the string that should be used to display the receiver"

	^ self label
]

{ #category : #accessing }
LeExternalLinkNode >> label [
	"If no other label is available, display the URL"

	^ self url
]

{ #category : #generated }
LeExternalLinkNode >> link [
	^ link
]

{ #category : #generated }
LeExternalLinkNode >> link: aSmaCCToken [
	link := aSmaCCToken
]

{ #category : #generated }
LeExternalLinkNode >> tokenVariables [
	^ #(#link)
]

{ #category : #accessing }
LeExternalLinkNode >> url [ 
	"Answer the URL string.
	This will typically be overridden by subclasses."

	^ self link source
]

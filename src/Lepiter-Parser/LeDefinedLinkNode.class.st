Class {
	#name : #LeDefinedLinkNode,
	#superclass : #LeLinkNode,
	#instVars : [
		'link'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeDefinedLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitDefinedLink: self
]

{ #category : #generated }
LeDefinedLinkNode >> link [
	^ link
]

{ #category : #generated }
LeDefinedLinkNode >> link: aSmaCCToken [
	link := aSmaCCToken
]

{ #category : #'api - accessing' }
LeDefinedLinkNode >> linkLabel [
	^ self linkUID
]

{ #category : #'api - accessing' }
LeDefinedLinkNode >> linkUID [
	"Return UID that represents a page or part"
	^ self subclassResponsibility
]

{ #category : #generated }
LeDefinedLinkNode >> tokenVariables [
	^ #(#link)
]

Class {
	#name : #LeKeywordLinkNode,
	#superclass : #LePageLinkNode,
	#instVars : [
		'colon'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeKeywordLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitKeywordLink: self
]

{ #category : #generated }
LeKeywordLinkNode >> colon [
	^ colon
]

{ #category : #generated }
LeKeywordLinkNode >> colon: aSmaCCToken [
	colon := aSmaCCToken
]

{ #category : #accessing }
LeKeywordLinkNode >> linkUID [
	<return: #String>
	^ self link source
]

{ #category : #generated }
LeKeywordLinkNode >> tokenVariables [
	^ #(#colon #link)
]

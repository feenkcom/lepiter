Class {
	#name : #LeIncomingPageToPageLink,
	#superclass : #LeIncomingPageLink,
	#instVars : [
		'referencingPage'
	],
	#category : 'Lepiter-Core-IncomingReferences'
}

{ #category : #testing }
LeIncomingPageToPageLink >> isFromPage [
	"Return true if the page link is coming from some page"
	<reutrn: #Boolean>
	
	^ true
]

{ #category : #testing }
LeIncomingPageToPageLink >> isFromPage: aLePage [
	"Return true if the page link is coming from a given page"
	<reutrn: #Boolean>
	
	^ self referencingPage = aLePage
]

{ #category : #accessing }
LeIncomingPageToPageLink >> referencingPage [
	^ referencingPage
]

{ #category : #accessing }
LeIncomingPageToPageLink >> referencingPage: anObject [
	referencingPage := anObject
]

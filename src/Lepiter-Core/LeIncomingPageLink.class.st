Class {
	#name : #LeIncomingPageLink,
	#superclass : #LeModel,
	#instVars : [
		'referencedPage',
		'link'
	],
	#category : 'Lepiter-Core-IncomingReferences'
}

{ #category : #'api - accessing' }
LeIncomingPageLink >> editTime [ 
	"Answer the edit time of the receiver's link"
	<return: #LeTime>

	^ link editTime
]

{ #category : #testing }
LeIncomingPageLink >> isFromPage [
	"Return true if the page link is coming from some page"
	<reutrn: #Boolean>
	
	^ false
]

{ #category : #testing }
LeIncomingPageLink >> isFromPage: aLePage [
	"Return true if the page link is coming from a given page"
	<reutrn: #Boolean>
	
	^ false
]

{ #category : #accessing }
LeIncomingPageLink >> link [
	^ link
]

{ #category : #accessing }
LeIncomingPageLink >> link: anObject [
	link := anObject
]

{ #category : #accessing }
LeIncomingPageLink >> originReference [
	<return: #LeLinkReference>

	^ self link originReference
]

{ #category : #accessing }
LeIncomingPageLink >> referencedPage [
	^ referencedPage
]

{ #category : #accessing }
LeIncomingPageLink >> referencedPage: anObject [
	referencedPage := anObject
]

Class {
	#name : #LeLinkPageTextualTitleReference,
	#superclass : #LeLinkPageReference,
	#instVars : [
		'pageTitle'
	],
	#category : #'Lepiter-Core-Links'
}

{ #category : #'instance creation' }
LeLinkPageTextualTitleReference class >> forPageTitle: aPageTitle [
	^ self new
		pageTitle: aPageTitle
]

{ #category : #accessing }
LeLinkPageTextualTitleReference >> content: aPage [
	self pageTitle: aPage title.
	super content: aPage.
]

{ #category : #accessing }
LeLinkPageTextualTitleReference >> description [
	^ 'Page Title Reference: ', self pageTitle
]

{ #category : #testing }
LeLinkPageTextualTitleReference >> isExistingPage [
	^ self explicitLink database hasPageNamed: self pageTitle
]

{ #category : #testing }
LeLinkPageTextualTitleReference >> isReferencingContent: aLeContent [ 
	self assert: [ aLeContent notNil ].
	
	^ (super isReferencingContent: aLeContent) and: [
			aLeContent isPage and: [
				aLeContent title sameContentAs: self pageTitle ] ]
]

{ #category : #accessing }
LeLinkPageTextualTitleReference >> pageTitle [
	^ pageTitle
]

{ #category : #accessing }
LeLinkPageTextualTitleReference >> pageTitle: aString [
	self assert: [ aString notNil ].
	self assert: [ pageTitle isNil ].
	self assert: [ self page isNil ].
	
	pageTitle := aString
]

{ #category : #actions }
LeLinkPageTextualTitleReference >> resolveInDatabase: aDatabase [
	
	self assert: [ aDatabase notNil ].
	self assert: [ self pageTitle notNil ].
	self assert: [ self content isNil ].
	self assert: [ self explicitLink notNil ].
	
	aDatabase 
		pageNamed: self pageTitle
		ifPresent: [ :aPage |
			self basicContent: aPage.
			self explicitLink onTargetChanged ]
		ifAbsent: [ 
			"Ignore the fast the the page is not found.
			The link will remain unresolved. " ].
	
]

{ #category : #accessing }
LeLinkPageTextualTitleReference >> status [
	self isResolved ifTrue: [ ^ LeLinkReferenceStatus exists ].

	^ self isExistingPage
		ifTrue: [ LeLinkReferenceStatus exists ]
		ifFalse: [ LeLinkReferenceStatus notFound ]
]

{ #category : #accessing }
LeLinkPageTextualTitleReference >> targetId [
	^ self pageTitle
]

{ #category : #actions }
LeLinkPageTextualTitleReference >> unlink [	
	| previousContent |
	previousContent := self content.
	super unlink.
	previousContent ifNotNil: [ 
		self explicitLink onTargetRemoved: previousContent ]
]

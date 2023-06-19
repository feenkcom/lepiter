"
# Incoming page links
Represents the incoming links whose target is a page

"
Class {
	#name : #LeIncomingPageLinksGroup,
	#superclass : #LeModel,
	#instVars : [
		'page',
		'links'
	],
	#category : 'Lepiter-Core-IncomingReferences'
}

{ #category : #'instance creation' }
LeIncomingPageLinksGroup class >> forPage: aLePage [
	^ self new
		initializeForPage: aLePage;
		yourself
]

{ #category : #enumerating }
LeIncomingPageLinksGroup >> groupedByOrigin [
	| theGroupedLinks |

	theGroupedLinks := Dictionary new.

	self links do: [ :eachIncomingPageLink |
		| eachLinkOrigin |
		eachLinkOrigin := eachIncomingPageLink isFromPage
			ifTrue: [ eachIncomingPageLink referencingPage ]
			ifFalse: [ eachIncomingPageLink originReference ].

		(theGroupedLinks at: eachLinkOrigin ifAbsentPut: [
			eachIncomingPageLink isFromPage
				ifTrue: [ LeIncomingPageLinksGroupedByPage new referencingPage: eachLinkOrigin ]
				ifFalse: [ LeIncomingPageLinksGroupedByOrigin new origin: eachLinkOrigin ] ]) addIncomingPageLink: eachIncomingPageLink ].

	theGroupedLinks := theGroupedLinks values sorted: #latestEditDateAndTime descending.
	theGroupedLinks do: [ :eachGroup | eachGroup privateSetReferencedPage: self referencedPage ].
	^ theGroupedLinks
]

{ #category : #initialization }
LeIncomingPageLinksGroup >> initialize [
	super initialize.
	
	links := OrderedCollection new
]

{ #category : #initialization }
LeIncomingPageLinksGroup >> initializeForPage: aLePage [
	page := aLePage
]

{ #category : #initialization }
LeIncomingPageLinksGroup >> initializeWithLinks: aCollectionOfLeLinks [
	links := (aCollectionOfLeLinks select: [ :eachLink | 
		"simply add everything which is not content (e.g. external links) without page comparison"
		eachLink originReference isLeContentReference not
			or: [ eachLink originReference content page ~= self referencedPage ] ])
			collect: [ :eachLink |
				eachLink originReference isLeContentReference
					ifTrue: [
						LeIncomingPageToPageLink new
							referencedPage: self referencedPage;
							referencingPage: eachLink originReference content page;
							link: eachLink ]
					ifFalse: [
						LeIncomingPageLink new
							referencedPage: self referencedPage;
							link: eachLink ] ] as: OrderedCollection
]

{ #category : #testing }
LeIncomingPageLinksGroup >> isExplicit [
	^ false
]

{ #category : #testing }
LeIncomingPageLinksGroup >> isImplicit [
	^ false
]

{ #category : #'api - accessing' }
LeIncomingPageLinksGroup >> latestEditDateAndTime [ 
	"Answer the latest edit time of the receiver's links"
	<return: #DateAndTime>

	^ (links collect: #editTime) max time
]

{ #category : #'api - accessing' }
LeIncomingPageLinksGroup >> latestEditTime [ 
	"Answer the latest edit time of the receiver's links"
	<return: #LeTime>

	^ (links collect: #editTime) max
]

{ #category : #accessing }
LeIncomingPageLinksGroup >> links [
	<return: #Collection of: #LeIncomingPageLink>

	^ links
]

{ #category : #private }
LeIncomingPageLinksGroup >> privateSetLinks: aCollectionOfIncomingPageLinks [
	links := aCollectionOfIncomingPageLinks
]

{ #category : #private }
LeIncomingPageLinksGroup >> privateSetReferencedPage: aLePage [
	page := aLePage
]

{ #category : #accessing }
LeIncomingPageLinksGroup >> referencedPage [
	"Return a page which is a target of all #links"
	<return: #LePage>

	^ page
]

{ #category : #enumerating }
LeIncomingPageLinksGroup >> select: aBlockClosure [
	| theLinks |
	
	theLinks := self links select: aBlockClosure.

	^ self copy
		privateSetLinks: theLinks;
		yourself
]

{ #category : #accessing }
LeIncomingPageLinksGroup >> size [
	^ self links size
]

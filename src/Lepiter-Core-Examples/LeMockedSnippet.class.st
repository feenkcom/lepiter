Class {
	#name : #LeMockedSnippet,
	#superclass : #LeSnippet,
	#traits : 'TLeUnlinkedReferencesUpdate',
	#classTraits : 'TLeUnlinkedReferencesUpdate classTrait',
	#instVars : [
		'contentString',
		'textualLinks'
	],
	#category : #'Lepiter-Core-Examples-Mocks'
}

{ #category : #factory }
LeMockedSnippet class >> empty [
	"Return a content (page or block) with empty values (title or text).
	Required by ${method:LeContent>>#addBlockOfClass:after:}$"
	^ self new
]

{ #category : #accessing }
LeMockedSnippet class >> string: aString [
	^ self new string: aString
]

{ #category : #initialization }
LeMockedSnippet >> initialize [
	super initialize.

	contentString := ''.
	textualLinks := #().
]

{ #category : #'private - hooks' }
LeMockedSnippet >> onAddedToDatabase [ 
	super onAddedToDatabase.
	
	self textualLinks: textualLinks
]

{ #category : #'private - hooks' }
LeMockedSnippet >> onRemovedFromDatabase: aDatabase [
	super onRemovedFromDatabase: aDatabase.
	
	self removeUnlinkedReferencesFromDatabase: aDatabase.
]

{ #category : #'api - links' }
LeMockedSnippet >> outgoingTextualLinks [
	<return: #Collection of: #LeTextualLink>

	^ self outgoingExplicitLinks select: [ :each | each isTextualLink ]
]

{ #category : #'api - accessing' }
LeMockedSnippet >> string [
	<return: #String>

	^ contentString
]

{ #category : #'api - accessing' }
LeMockedSnippet >> string: aString [
	contentString := aString.
	self updateUnlinkedReferences.
]

{ #category : #'api - links' }
LeMockedSnippet >> textualLinkToPageNamed: aPageName [
	self textualLinksToPagesNamed: { aPageName }
]

{ #category : #'api - links' }
LeMockedSnippet >> textualLinks [
	^ textualLinks
]

{ #category : #'api - links' }
LeMockedSnippet >> textualLinks: aCollectionOfTextualLinks [
	(aCollectionOfTextualLinks allSatisfy: [ :eachLink | eachLink isTextualLink ])
		ifFalse: [ self error: 'All links must be textual' ].

	textualLinks := aCollectionOfTextualLinks.

	self databaseDo: [ :aDatabase | 
		"Set the origin of the links only when they are actually added to the database"
		aCollectionOfTextualLinks do: [ :eachLink | 
			eachLink origin: self ].
		aDatabase addExplicitLinks: aCollectionOfTextualLinks ]
]

{ #category : #'api - links' }
LeMockedSnippet >> textualLinksToPagesNamed: aCollectionOfPageNames [
	| theTextualLinks |

	theTextualLinks := aCollectionOfPageNames collect: [ :eachPageName |
		(LeTextualPageLink new 
			node: nil; 
			targetPageTitle: eachPageName) ].
		
	self textualLinks: theTextualLinks
]

{ #category : #updating }
LeMockedSnippet >> updateUnlinkedReferences [
	"Update unlinked references the receiver may have to other pages.
	Subclasses that support unlinked references should call this when they are updated."

	LeUnlinkedReferenceMaintenance submitForBlock: self.
]

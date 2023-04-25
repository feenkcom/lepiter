Class {
	#name : #LeBookPageLinksBuilder,
	#superclass : #Object,
	#instVars : [
		'tocPage',
		'tocNodes',
		'pages',
		'idGenerator',
		'fileExtension',
		'tocFileName',
		'links'
	],
	#category : #'Lepiter-HTML-Book Helpers'
}

{ #category : #'api - building' }
LeBookPageLinksBuilder >> build [
	self pages ifNil: [ ^ self ].

	links := LeBookPageLinks withAll: (self pages 
		collect: [ :aPage | self buildPageLink: aPage ])
]

{ #category : #'api - building' }
LeBookPageLinksBuilder >> buildPageLink: aPage [
	| aTitle anId aFileName aResult |
	aPage == self tocPage
		ifTrue: [ ^ LeHtmlBookToCPageLink new 
			page: aPage;
			fileName: self tocFileName ].
	
	aTitle := GtFileUtility
			secureFileName: aPage title asString
			extension: nil
			maxLenght: XdConstants xdocFileNameMaxLenght.
	anId := self idGenerator nextId.

	aFileName := String
			streamContents: [ :aStream | 
				aStream
					nextPutAll: aTitle;
					nextPut: $-;
					nextPutAll: anId.

				self fileExtension
					ifNotNil: [ :anExtension | 
						aStream
							nextPut: $.;
							nextPutAll: anExtension ] ].
							
	aResult := LeHtmlBookPageLink new 
		page: aPage;
		fileName: aFileName;
		id: anId.
		
	^ aResult
]

{ #category : #'api - initialization' }
LeBookPageLinksBuilder >> database: aLeDatabase [
	self tocPage: aLeDatabase  tableOfContents.
	self tocNodes: aLeDatabase tableOfContentsNodes.
	self pages: aLeDatabase pages.
]

{ #category : #accessing }
LeBookPageLinksBuilder >> defaultIdGenerator [
	^ XdUUIDGenerator new
]

{ #category : #accessing }
LeBookPageLinksBuilder >> defaultTocFileName [
	^ 'index.html'
]

{ #category : #accessing }
LeBookPageLinksBuilder >> fileExtension [
	^ fileExtension
]

{ #category : #accessing }
LeBookPageLinksBuilder >> fileExtension: anObject [
	fileExtension := anObject
]

{ #category : #'gt - extensions' }
LeBookPageLinksBuilder >> gtLinksFor: aView [
	<gtView>
	links ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Links';
		priority: 10;
		items: [ self sortedLinks ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Page Title' text: #pageTitle;
		column: 'File Name' text: #fileName
]

{ #category : #'gt - extensions' }
LeBookPageLinksBuilder >> gtViewTableOfContentsNodesFor: aView [
	<gtView>
	tocNodes ifNil: [ ^ aView empty ].
	
	^ aView tree
		title: 'Table of Content Nodes';
		priority: 50;
		items: [ tocNodes ifNil: [ #() ] ];
		children: #children
]

{ #category : #'api - initialization' }
LeBookPageLinksBuilder >> html [
	self fileExtension: 'html'.
	self tocFileName: 'index.html'
]

{ #category : #accessing }
LeBookPageLinksBuilder >> idGenerator [
	^ idGenerator ifNil: [ idGenerator := self defaultIdGenerator ]
]

{ #category : #accessing }
LeBookPageLinksBuilder >> idGenerator: anObject [
	idGenerator := anObject
]

{ #category : #accessing }
LeBookPageLinksBuilder >> links [
	<return: #LeBookPageLinks or: nil>
	^ links
]

{ #category : #accessing }
LeBookPageLinksBuilder >> pages [
	^ pages
]

{ #category : #accessing }
LeBookPageLinksBuilder >> pages: anObject [
	pages := anObject
]

{ #category : #accessing }
LeBookPageLinksBuilder >> sortedLinks [
	^ links sortedLinks
]

{ #category : #accessing }
LeBookPageLinksBuilder >> tocFileName [
	^ tocFileName ifNil: [ tocFileName := self defaultTocFileName ]
]

{ #category : #accessing }
LeBookPageLinksBuilder >> tocFileName: anObject [
	tocFileName := anObject
]

{ #category : #accessing }
LeBookPageLinksBuilder >> tocNodes [
	^ tocNodes
]

{ #category : #accessing }
LeBookPageLinksBuilder >> tocNodes: anObject [
	tocNodes := anObject
]

{ #category : #accessing }
LeBookPageLinksBuilder >> tocPage [
	^ tocPage
]

{ #category : #accessing }
LeBookPageLinksBuilder >> tocPage: aPage [
	tocPage := aPage.
]

{ #category : #'api - initialization' }
LeBookPageLinksBuilder >> uuidGenerator [
	self idGenerator: XdUUIDGenerator new
]

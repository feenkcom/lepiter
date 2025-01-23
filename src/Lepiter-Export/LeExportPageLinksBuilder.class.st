Class {
	#name : #LeExportPageLinksBuilder,
	#superclass : #Object,
	#instVars : [
		'tocPage',
		'tocNodes',
		'pages',
		'fileExtension',
		'links',
		'mainPage',
		'mainFileName',
		'sequencer'
	],
	#category : #'Lepiter-Export-Page Links - Builders'
}

{ #category : #'api - building' }
LeExportPageLinksBuilder >> build [
	self pages ifNil: [ ^ self ].

	links := LeExportPageLinks withAll: (self pages 
		collect: [ :aPage | self buildPageLink: aPage ])
]

{ #category : #'api - building' }
LeExportPageLinksBuilder >> buildPageLink: aPage [
	| aTitle anId aFileName aResult |
	aPage == self mainPage
		ifTrue: [ ^ LeExportBookMainPageLink new
				page: aPage;
				fileName: self mainFileName;
				fileExtension: self fileExtension ].

	aTitle := GtFileUtility
			secureFileName: aPage title asString
			extension: nil
			maxLength: XdConstants xdocFileNameMaxLength.
	anId := self sequencer nextIdFromPage: aPage.

	aFileName := String
			streamContents: [ :aStream | 
				aStream
					nextPutAll: aTitle;
					nextPut: $-;
					nextPutAll: anId ].

	aResult := LeExportBookPageLink new
			page: aPage;
			fileName: aFileName;
			fileExtension: self fileExtension;
			id: anId.

	^ aResult
]

{ #category : #'api - initialization' }
LeExportPageLinksBuilder >> database: aLeDatabase [
	self tocPage: aLeDatabase  tableOfContents.
	self tocNodes: aLeDatabase tableOfContentsNodes.
	self pages: aLeDatabase pages.
]

{ #category : #accessing }
LeExportPageLinksBuilder >> defaultMainFileName [
	^ 'index'
]

{ #category : #accessing }
LeExportPageLinksBuilder >> defaultSequencer [
	^ LeExportUUIDSequencer new
]

{ #category : #accessing }
LeExportPageLinksBuilder >> fileExtension [
	^ fileExtension
]

{ #category : #accessing }
LeExportPageLinksBuilder >> fileExtension: anObject [
	fileExtension := anObject
]

{ #category : #'gt - extensions' }
LeExportPageLinksBuilder >> gtLinksFor: aView [
	<gtView>
	links ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Links';
		priority: 10;
		items: [ self sortedLinks ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Page Title' text: #pageTitle;
		column: 'File Name' text: #fileNameWithExtension
]

{ #category : #'gt - extensions' }
LeExportPageLinksBuilder >> gtViewTableOfContentsNodesFor: aView [
	<gtView>
	tocNodes ifNil: [ ^ aView empty ].
	
	^ aView tree
		title: 'Table of content nodes';
		priority: 50;
		items: [ tocNodes ifNil: [ #() ] ];
		children: #children
]

{ #category : #'api - initialization' }
LeExportPageLinksBuilder >> html [
	self fileExtension: 'html'.
	self mainFileName: 'index'
]

{ #category : #'api - initialization' }
LeExportPageLinksBuilder >> integerSequencer [
	self sequencer: LeExportIntegerSequencer new
]

{ #category : #accessing }
LeExportPageLinksBuilder >> links [
	<return: #LeExportPageLinks or: nil>
	^ links
]

{ #category : #accessing }
LeExportPageLinksBuilder >> mainFileName [
	^ mainFileName ifNil: [ mainFileName := self defaultMainFileName ]
]

{ #category : #accessing }
LeExportPageLinksBuilder >> mainFileName: anObject [
	mainFileName := anObject
]

{ #category : #accessing }
LeExportPageLinksBuilder >> mainPage [
	"Return a {{gtClass:LePage}} instance that should be displayed 
	by default, e.g., as `index.html` in case of the HTML export."

	<return: #LePage>
	^ mainPage ifNil: [ mainPage := self tocPage ]
]

{ #category : #accessing }
LeExportPageLinksBuilder >> mainPage: aLePage [
	"Set a {{gtClass:LePage}} instance that should be displayed 
	by default, e.g., as `index.html` in case of the HTML export."

	mainPage := aLePage
]

{ #category : #accessing }
LeExportPageLinksBuilder >> pages [
	^ pages
]

{ #category : #accessing }
LeExportPageLinksBuilder >> pages: anObject [
	pages := anObject
]

{ #category : #accessing }
LeExportPageLinksBuilder >> sequencer [
	^ sequencer ifNil: [ sequencer := self defaultSequencer ]
]

{ #category : #accessing }
LeExportPageLinksBuilder >> sequencer: anObject [
	sequencer := anObject
]

{ #category : #accessing }
LeExportPageLinksBuilder >> sortedLinks [
	^ links sortedLinks
]

{ #category : #accessing }
LeExportPageLinksBuilder >> tocNodes [
	^ tocNodes
]

{ #category : #accessing }
LeExportPageLinksBuilder >> tocNodes: anObject [
	tocNodes := anObject
]

{ #category : #accessing }
LeExportPageLinksBuilder >> tocPage [
	^ tocPage
]

{ #category : #accessing }
LeExportPageLinksBuilder >> tocPage: aPage [
	tocPage := aPage.
]

{ #category : #'api - initialization' }
LeExportPageLinksBuilder >> uuidSequencer [
	self sequencer: LeExportUUIDSequencer new
]

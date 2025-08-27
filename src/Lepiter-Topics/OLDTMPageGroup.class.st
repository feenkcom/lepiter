"
Deprecated. Use TMPageGroup instead.
"
Class {
	#name : #OLDTMPageGroup,
	#superclass : #Object,
	#instVars : [
		'topicMap',
		'pages'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
OLDTMPageGroup class >> for: aTopicMap [
	self deprecated: 'Use TMPageGroup instead.'.
	^ self new
		topicMap: aTopicMap;
		yourself
]

{ #category : #'instance creation' }
OLDTMPageGroup class >> for: aTopicMap with: aPageCollection [
	self deprecated: 'Use TMPageGroup instead.'.
	^ self new
		topicMap: aTopicMap;
		pages: aPageCollection;
		yourself
]

{ #category : #accessing }
OLDTMPageGroup >> database [
	^ self topicMap database
]

{ #category : #searching }
OLDTMPageGroup >> gtSpotterForPageContent: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page content';
		priority: 25;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #asMarkdownPage;
		sendCategory: [ :aCategory :aStep :thisSearch | self class for: self topicMap with: aCategory items contents ];
		filterBySubstring
]

{ #category : #searching }
OLDTMPageGroup >> gtSpotterForPageTitles: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page titles';
		priority: 20;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #title;
		sendCategory: [ :aCategory :aStep :thisSearch | self class for: self topicMap with: aCategory items contents ];
		filterBySubstring
]

{ #category : #views }
OLDTMPageGroup >> gtTreeFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Tree';
		priority: 10;
		items: [ self pageNodes];
		children: #children;
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Node'
			text: [ :each | each name ]
			width: 300;
		column: '# Children'
			text: [ :each | each children size ]
			width: 100;
		column: '# Pages'
			text: [ :each | each pages size ]
			width: 100;
		column: 'Info'
			text: [ :each | each relatedInfo ]
			width: 300;
		send: [ :each | each ];
		actionUpdateButton
]

{ #category : #navigation }
OLDTMPageGroup >> pageNodes [
	^ self pages collect: [ :aPage | TMPageNode for: aPage in: self topicMap ]
]

{ #category : #accessing }
OLDTMPageGroup >> pageView [
	"Instead of leveraging dictionaries, we should just make our our tree nodes that have tree nodes as children.
	What are the children of a page group?"


	^ ((self topicMap json at: 'pages')
		select: [ :d | self database hasPageNamed: (d at: 'page') ]
		thenCollect: [ :d | 
			(self database pageNamed: (d at: 'page'))
				-> {'category' -> (d at: 'category').
						'topics' -> (d at: 'topics')} asDictionary ]) asDictionary
]

{ #category : #accessing }
OLDTMPageGroup >> pages [
	^ pages ifNil: [ pages := self topicMap pages ]
]

{ #category : #accessing }
OLDTMPageGroup >> pages: aPageCollection [
	pages := aPageCollection
]

{ #category : #printing }
OLDTMPageGroup >> printOn: aStream [
super printOn: aStream.
	aStream
		nextPut: $(;
		print: self pages size;
		nextPutAll: ' pages';
		nextPut: $)
]

{ #category : #accessing }
OLDTMPageGroup >> topicMap [
	^ topicMap
]

{ #category : #accessing }
OLDTMPageGroup >> topicMap: aTopicMap [
	topicMap := aTopicMap
]

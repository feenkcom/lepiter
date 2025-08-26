Class {
	#name : #TMPageGroup,
	#superclass : #Object,
	#instVars : [
		'topicMap',
		'pages'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMPageGroup class >> for: aTopicMap [
	^ self new
		topicMap: aTopicMap;
		yourself
]

{ #category : #'instance creation' }
TMPageGroup class >> for: aTopicMap with: aPageCollection [
	^ self new
		topicMap: aTopicMap;
		pages: aPageCollection;
		yourself
]

{ #category : #accessing }
TMPageGroup >> database [
	^ self topicMap database
]

{ #category : #views }
TMPageGroup >> gtPagesFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Pages';
		items: [ self pageNodes ];
		children: #children;
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Page'
			text: [ :each | each name ]
			width: 300;
		column: 'Style'
			text: [ :each | each isPageNode ifTrue: [ each style ] ifFalse: [ '-' ] ]
			width: 300;
		send: [ :each | each sendTo ];
		actionUpdateButton
]

{ #category : #searching }
TMPageGroup >> gtSpotterForPageContent: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page content';
		priority: 25;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #asMarkdownPage;
		sendCategory: [ :aCategory :aStep :thisSearch | TMPageGroup for: self topicMap with: aCategory items contents ];
		filterBySubstring
]

{ #category : #searching }
TMPageGroup >> gtSpotterForPageTitles: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page titles';
		priority: 20;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #title;
		sendCategory: [ :aCategory :aStep :thisSearch | TMPageGroup for: self topicMap with: aCategory items contents ];
		filterBySubstring
]

{ #category : #navigation }
TMPageGroup >> pageNodes [
	^ self pages collect: [ :aPage | TMPageNode for: aPage in: self topicMap ]
]

{ #category : #accessing }
TMPageGroup >> pageView [
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
TMPageGroup >> pages [
	^ pages ifNil: [ pages := self topicMap pages ]
]

{ #category : #accessing }
TMPageGroup >> pages: aPageCollection [
	pages := aPageCollection
]

{ #category : #printing }
TMPageGroup >> printOn: aStream [
super printOn: aStream.
	aStream
		nextPut: $(;
		print: self pages size;
		nextPutAll: ' page';
		nextPut: $)
]

{ #category : #accessing }
TMPageGroup >> topicMap [
	^ topicMap
]

{ #category : #accessing }
TMPageGroup >> topicMap: aTopicMap [
	topicMap := aTopicMap
]

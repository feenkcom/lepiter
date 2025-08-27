"
I am like my parent, but specifically contain just pages.
"
Class {
	#name : #TMPageGroup,
	#superclass : #TMNodeCollectionNode,
	#traits : 'TGtGroup',
	#classTraits : 'TGtGroup classTrait',
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMPageGroup class >> for: aTopicMap [
	^ self for: aTopicMap with: aTopicMap pages
]

{ #category : #'instance creation' }
TMPageGroup class >> for: aTopicMap with: aPageCollection [
	^ self new
		topicMap: aTopicMap;
		pages: aPageCollection;
		yourself
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
		sendCategory: [ :aCategory :aStep :thisSearch | self class for: self topicMap with: aCategory items contents ];
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
		sendCategory: [ :aCategory :aStep :thisSearch | self class for: self topicMap with: aCategory items contents ];
		filterBySubstring
]

{ #category : #accessing }
TMPageGroup >> items [
	^ nodes
]

{ #category : #accessing }
TMPageGroup >> pageNodes [
	^ self nodes
]

{ #category : #accessing }
TMPageGroup >> pages [
	"Each node is a TMPageNode"

	^ nodes collect: #page
]

{ #category : #accessing }
TMPageGroup >> pages: aPageCollection [
	"Wrap the pages as nodes."

	^ self
		nodes: (aPageCollection collect: [ :aPage | TMPageNode for: aPage in: self topicMap ])
]

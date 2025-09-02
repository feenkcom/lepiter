"
I am a common superclass for TopicMaps and TopicMap nodes to enable sharing of common behavior, such as spotter searches.
"
Class {
	#name : #TMAbstractEntity,
	#superclass : #Object,
	#category : #'Lepiter-Topics-Model'
}

{ #category : #searching }
TMAbstractEntity >> gtSpotterForPageContent: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page content';
		priority: 25;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #asMarkdownPage;
		sendCategory: [ :aCategory :aStep :thisSearch | self pageGroupFor: aCategory items contents ];
		filterBySubstring
]

{ #category : #searching }
TMAbstractEntity >> gtSpotterForPageTitles: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page titles';
		priority: 20;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #title;
		sendCategory: [ :aCategory :aStep :thisSearch | self pageGroupFor: aCategory items contents ];
		filterBySubstring
]

{ #category : #testing }
TMAbstractEntity >> isAbstract [
	^ self == TMAbstractEntity
]

{ #category : #utility }
TMAbstractEntity >> nodeGroupFor: aNodeCollection [
	^ TMNodeGroup for: aNodeCollection in: self topicMap
]

{ #category : #navigation }
TMAbstractEntity >> pageGroup [
	^ self pageGroupFor: self pages
]

{ #category : #utility }
TMAbstractEntity >> pageGroupFor: aPageCollection [
	^ TMPageGroup for: aPageCollection in: self topicMap
]

{ #category : #querying }
TMAbstractEntity >> pages [
	self subclassResponsibility
]

{ #category : #querying }
TMAbstractEntity >> topicMap [
	self subclassResponsibility
]

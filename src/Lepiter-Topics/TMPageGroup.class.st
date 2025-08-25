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
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Page'
			text: [ :each | each name ]
			width: 300;
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #navigation }
TMPageGroup >> pageNodes [
	^ self pages collect: [ :aPage | TMPageNode for: aPage within: self ]
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
TMPageGroup >> pages: anObject [
	pages := anObject
]

{ #category : #accessing }
TMPageGroup >> topicMap [
	^ topicMap
]

{ #category : #accessing }
TMPageGroup >> topicMap: aTopicMap [
	topicMap := aTopicMap
]

Class {
	#name : #TMPageNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMPageNode class >> for: aPage [
	^ self new
		page: aPage;
		topicMap: aPage topicMap;
		yourself
]

{ #category : #'instance creation' }
TMPageNode class >> for: aPage in: aTopicMap [
	"Use this for testing if the topic map to use is not necessarily
	the default one, but a special test map."

	^ self new
		page: aPage;
		topicMap: aTopicMap;
		yourself
]

{ #category : #navigation }
TMPageNode >> children [
	^ self topics collect: [ :each | TMTopicNode for: each in: self topicMap ]
]

{ #category : #accessing }
TMPageNode >> name [
	^ 'Page: ', self page title
]

{ #category : #accessing }
TMPageNode >> page [
	^ page
]

{ #category : #accessing }
TMPageNode >> page: aPage [
	page := aPage
]

{ #category : #accessing }
TMPageNode >> pages [
	^ {self page}
]

{ #category : #accessing }
TMPageNode >> relatedInfo [
	^ 'Style:', self style
]

{ #category : #accessing }
TMPageNode >> relatedTitle [
	^ 'Style'
]

{ #category : #accessing }
TMPageNode >> style [
	^ self topicMap style4Page: self page
]

{ #category : #querying }
TMPageNode >> topics [
	^ self topicMap topics4Page: self page
]

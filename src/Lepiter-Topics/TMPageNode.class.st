Class {
	#name : #TMPageNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMPageNode class >> for: aPage in: aTopicMap [
^ self new
	page: aPage;
	topicMap: aTopicMap;
	yourself 
]

{ #category : #navigation }
TMPageNode >> children [
	^ self topics collect: [ :each | TMTopicNode for: each in: self topicMap ]
]

{ #category : #testing }
TMPageNode >> isPageNode [
	^ true
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

{ #category : #navigation }
TMPageNode >> sendTo [
	^ self page
]

{ #category : #accessing }
TMPageNode >> style [
	^ self topicMap page2Style at: self page
]

{ #category : #querying }
TMPageNode >> topics [
	^ self topicMap page2Topics at: self page
]

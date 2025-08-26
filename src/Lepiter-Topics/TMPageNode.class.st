Class {
	#name : #TMPageNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMPageNode class >> for: aPage within: aPageGroup [
^ self new
	pageGroup: aPageGroup;
	page: aPage;
	yourself 
]

{ #category : #accessing }
TMPageNode >> children [
	^ self topics collect: [ :each | TMTopicNode for: each within: self pageGroup ]
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
TMPageNode >> page: anObject [
	page := anObject
]

{ #category : #querying }
TMPageNode >> topics [
	^ self topicMap page2Topics at: self page
]

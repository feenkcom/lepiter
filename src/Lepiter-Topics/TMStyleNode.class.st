Class {
	#name : #TMStyleNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'style',
		'context'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMStyleNode class >> for: aString in: aTopicMap within: aPageGroup [
^ self new
	style: aString;
	topicMap: aTopicMap;
	context: aPageGroup;
	yourself 
]

{ #category : #navigation }
TMStyleNode >> children [
	^ self pages collect: [ :aPage | TMPageNode for: aPage in: self topicMap ]
]

{ #category : #accessing }
TMStyleNode >> context [
	^ context
]

{ #category : #accessing }
TMStyleNode >> context: aPageGroup [
	context := aPageGroup
]

{ #category : #accessing }
TMStyleNode >> name [
	^ 'Style: ' , self style
]

{ #category : #querying }
TMStyleNode >> pages [
	"NB: We only want the pages in *this* page group with this style."

	^ self context pages
		select: [ :aPage | (self topicMap page2Style at: aPage) = self style ]
]

{ #category : #'as yet unclassified' }
TMStyleNode >> sendTo [
	^ TMPageGroup for: self topicMap with: self pages
]

{ #category : #accessing }
TMStyleNode >> style [
	^ style
]

{ #category : #accessing }
TMStyleNode >> style: anObject [
	style := anObject
]

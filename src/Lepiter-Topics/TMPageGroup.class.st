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

{ #category : #views }
TMPageGroup >> gtPagesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pages';
		items: [ self pages ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Page'
			text: [ :each | each title ]
			width: 400;
		column: 'Category'
			text: [ :each | self topicMap page2Category at: each ]
			width: 100;
		"children: [ :aPage | self topicMap page2Topics at: aPage ];"
		actionUpdateButton
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

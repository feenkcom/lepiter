"
I am like my parent, but specifically contain just pages.
"
Class {
	#name : #TMPageGroup,
	#superclass : #TMNodeGroup,
	#instVars : [
		'queryString'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMPageGroup class >> for: aPageCollection in: aTopicMap [
	^ self new
		topicMap: aTopicMap;
		pages: aPageCollection;
		yourself
]

{ #category : #testing }
TMPageGroup >> isTMPageGroup [
	^ true
]

{ #category : #accessing }
TMPageGroup >> name [
	^ 'Page group', self queryString
]

{ #category : #navigation }
TMPageGroup >> pageGroup [
	^ self
]

{ #category : #navigation }
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

{ #category : #accessing }
TMPageGroup >> queryString [
	^ queryString ifNil: [ queryString := '' ]
]

{ #category : #accessing }
TMPageGroup >> queryString: aString [
	queryString := ' query: ', aString
]

{ #category : #treemaps }
TMPageGroup >> treeMapChildren [
	"^ self styleNodes
		collect: [ :n | 
			n
				treeMapParent: self;
				yourself ]"
	^ self topicNodes
		collect: [ :n | 
			n
				treeMapParent: self;
				yourself ]
]

{ #category : #treemaps }
TMPageGroup >> treeMapLeaves [
	^ self
]

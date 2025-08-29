"
I am like my parent, but specifically contain just pages.
"
Class {
	#name : #TMPageGroup,
	#superclass : #TMNodeGroup,
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

{ #category : #treemaps }
TMPageGroup >> treeMapLeaves [
	^ self
]

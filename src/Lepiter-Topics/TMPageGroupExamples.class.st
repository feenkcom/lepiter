Class {
	#name : #TMPageGroupExamples,
	#superclass : #Object,
	#category : #'Lepiter-Topics-Examples'
}

{ #category : #examples }
TMPageGroupExamples >> gtBookPageGroup [
	"PageGroup for all pages from the test file."

	<gtExample>
	| pageGroup topicMap |
	topicMap := self gtBookTopicMap.
	pageGroup := TMPageGroup for: topicMap.
	self assert: pageGroup pages size equals: topicMap pages size.
	^ pageGroup
]

{ #category : #examples }
TMPageGroupExamples >> gtBookTopicMap [
	"TopicMap for all pages from the test file."

	<gtExample>
	^ TopicMapExamples new topicMap
]

{ #category : #examples }
TMPageGroupExamples >> pageGroup [
	<gtExample>
	| pageNodes |
	pageNodes := self gtBookPageGroup pageGroup.
	self assert: pageNodes size equals: self gtBookPageGroup pages size.
	^ pageNodes
]

{ #category : #examples }
TMPageGroupExamples >> projectDiaryPageNode [
	<gtExample>
	| projectDiaryPageNode |
	projectDiaryPageNode := self pageGroup
			detect: [ :n | n page title = 'Project Diary' ].
	self assert: projectDiaryPageNode page title equals: 'Project Diary'.
	self assert: projectDiaryPageNode style equals: 'Pattern'.
	self
		assert: projectDiaryPageNode topics asSet
		equals: #('Using Lepiter' 'Live Documentation' 'Moldable Development Practices' 'Examples and Documentation')
				asSet.
	^ projectDiaryPageNode
]

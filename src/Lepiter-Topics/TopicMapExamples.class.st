Class {
	#name : #TopicMapExamples,
	#superclass : #Object,
	#category : #'Lepiter-Topics-Examples'
}

{ #category : #example }
TopicMapExamples >> page2Category [
	<gtExample>
	| page2Category |
	page2Category := self topicMap page2Category.
	self
		assert: page2Category size
		equals: self page2Topics size.
	^ page2Category
]

{ #category : #example }
TopicMapExamples >> page2Topics [
	<gtExample>
	| page2Topics |
	page2Topics := self topicMap page2Topics.
	self
		assert: page2Topics size
		equals: (self topicMap json at: 'pages') size - self topicMap missingPages size.
	^ page2Topics
]

{ #category : #example }
TopicMapExamples >> topicMap [
	<gtExample>
	| topicMap |
	topicMap := TopicMap forJson: self topicMapTestFile.
	self assert: topicMap database equals: LeDatabase gtBook.
	self assert: topicMap missingPages notNil.
	^ topicMap
]

{ #category : #example }
TopicMapExamples >> topicMapTestFile [
	"NB: This test file forthe GT Book is a frozne snapshop. 
	It is *not* intended to match the current state of the book. 
	In fact, some tests depend on mismatches existing between the pages in the book and version of the topic map."

	<gtExample>
	^ FileLocator gtResource / 'feenkcom/lepiter/data/topicMapTestExample.json'
]

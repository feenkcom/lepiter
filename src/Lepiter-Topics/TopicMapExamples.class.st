Class {
	#name : #TopicMapExamples,
	#superclass : #Object,
	#category : #'Lepiter-Topics-Examples'
}

{ #category : #example }
TopicMapExamples >> topicMapFromTestFile [
	<gtExample>
	| topicMap |
	topicMap := TopicMap forJson: self topicMapTestFile.
	self assert: topicMap database equals: LeDatabase gtBook databaseName.
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

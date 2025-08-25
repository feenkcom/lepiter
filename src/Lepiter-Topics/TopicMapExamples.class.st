"
I contain TopicMap examples based on a a frozen state of the GT book topic map, containing some missing (renamed) pages for testing purposes.
The main instance is `TopicMapExamples new topicMap`.

The other examples test that the various derived maps and queries work as expected.
"
Class {
	#name : #TopicMapExamples,
	#superclass : #Object,
	#category : #'Lepiter-Topics-Examples'
}

{ #category : #example }
TopicMapExamples >> categories [
	<gtExample>
	| categories |
	categories := self topicMap categories.
	self assert: categories size equals: 11.
	^ categories
]

{ #category : #example }
TopicMapExamples >> category2Page [
	<gtExample>
	| category2Page topicMap |
	topicMap := self topicMap.
	category2Page := topicMap category2Page.
	self assert: category2Page size equals: topicMap categories size.
	^ category2Page
]

{ #category : #example }
TopicMapExamples >> database [
	<gtExample>
	| database |
	database := self topicMap database.
	self
		assert: database 
		equals: LeDatabase gtBook.
	^ database
]

{ #category : #example }
TopicMapExamples >> json [
	"Verify that this is the commented test topicFile."

	<gtExample>
	| json |
	json := self topicMap json.
	self assert: (json includesKey: 'comment').
	^ json
]

{ #category : #example }
TopicMapExamples >> missingPages [
	<gtExample>
	| missingPages topicMap |
	topicMap := self topicMap.
	missingPages := topicMap missingPages.
	self assert: missingPages size + topicMap pages size equals: (topicMap json at: 'pages') size.
	^ missingPages
]

{ #category : #example }
TopicMapExamples >> page2Category [
	<gtExample>
	| page2Category |
	page2Category := self topicMap page2Category.
	self assert: page2Category size equals: self page2Topics size.
	^ page2Category
]

{ #category : #example }
TopicMapExamples >> page2Topics [
	<gtExample>
	| page2Topics topicMap |
	topicMap := self topicMap.
	page2Topics := topicMap page2Topics.
	self
		assert: page2Topics size
		equals: (topicMap json at: 'pages') size - topicMap missingPages size.
	^ page2Topics
]

{ #category : #example }
TopicMapExamples >> pages [
	"NB: missing pages are filtered out."

	<gtExample>
	| pages |
	pages := self topicMap pages.
	self assert: pages size equals: self page2Topics size.
	^ pages
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

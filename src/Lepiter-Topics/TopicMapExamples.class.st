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
TopicMapExamples >> fields2Topics [
	<gtExample>
	| fields2Topics topicMap |
	topicMap := self topicMap.
	fields2Topics := topicMap fields2Topics.
	self assert: fields2Topics size equals: 5.
	^ fields2Topics
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
TopicMapExamples >> page2Style [
	<gtExample>
	| page2Style |
	page2Style := self topicMap page2Style.
	self assert: page2Style size equals: self page2Topics size.
	^ page2Style
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
TopicMapExamples >> style2Pages [
	<gtExample>
	| category2Page topicMap |
	topicMap := self topicMap.
	category2Page := topicMap style2Pages.
	self assert: category2Page size equals: topicMap styles size.
	^ category2Page
]

{ #category : #example }
TopicMapExamples >> styles [
	<gtExample>
	| categories |
	categories := self topicMap styles.
	self assert: categories size equals: 11.
	^ categories
]

{ #category : #example }
TopicMapExamples >> topic2Pages [
	<gtExample>
	| topicMap topic2Pages page2Topics |
	topicMap := self topicMap.
	topic2Pages := topicMap topic2Pages.
	page2Topics := topicMap page2Topics.
	self pages
		do: [ :aPage | 
			(page2Topics at: aPage)
				do: [ :aTopic | self assert: ((topic2Pages at: aTopic) includes: aPage) ] ].
	^ topic2Pages
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

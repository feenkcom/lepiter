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
TopicMapExamples >> databaseNode [
	<gtExample>
	| databaseNode |
	databaseNode := self topicMap databaseNode.
	self assert: databaseNode fields size equals: 5.
	self assert: databaseNode children isTMNodeGroup.
	self assert: databaseNode children isTMPageGroup not.
	^ databaseNode
]

{ #category : #example }
TopicMapExamples >> field2Topics [
	<gtExample>
	| fields2Topics topicMap |
	topicMap := self topicMap.
	fields2Topics := topicMap field2Topics.
	self assert: fields2Topics size equals: 5.
	^ fields2Topics
]

{ #category : #example }
TopicMapExamples >> fieldNodeGtBasics [
	"NB: Fragile test, #topics could change in book."

	<gtExample>
	| fieldNodeGtBasics |
	fieldNodeGtBasics := self databaseNode fieldNodes nodes
			detect: [ :n | n field = 'Glamorous Toolkit Basics' ].
	self assert: fieldNodeGtBasics topics size equals: 10.
	self assert: fieldNodeGtBasics styles size equals: 11.
	self assert: fieldNodeGtBasics pages size < fieldNodeGtBasics database pages size.
	self assert: fieldNodeGtBasics children isTMTreeNode.
	self assert: fieldNodeGtBasics children isTMPageGroup not.
	^ fieldNodeGtBasics
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
TopicMapExamples >> nodeGroupChildrenOfFieldNodeGtBasics [
	"NB: Fragile test, #topics could change in book."

	<gtExample>
	| nodeGroup |
	nodeGroup := self fieldNodeGtBasics children.
	self assert: nodeGroup size equals: 10.
	self assert: nodeGroup isTMTreeNode.
	self assert: nodeGroup isTMNodeGroup.
	self assert: nodeGroup isTMPageGroup not.
	self assert: nodeGroup children isTMNodeGroup.
	self assert: nodeGroup children isTMPageGroup not.
	^ nodeGroup
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
TopicMapExamples >> pageGroupChildrenOfStylesWithinAboutGt [
	<gtExample>
	| pageGroup |
	pageGroup := self styleNodeIntroductionWithinAboutGtTopic children.
	self assert: pageGroup size equals: 6.
	self assert: pageGroup isTMTreeNode.
	self assert: pageGroup isTMNodeGroup.
	self assert: pageGroup isTMPageGroup.
	self assert: pageGroup children isTMNodeGroup.
	self assert: pageGroup children isTMPageGroup not.
	^ pageGroup
]

{ #category : #example }
TopicMapExamples >> pageGroupFromTopicMap [
	<gtExample>
	| pageGroup |
	pageGroup := self topicMap pageGroup.
	self assert: pageGroup isTMPageGroup.
	^ pageGroup
]

{ #category : #example }
TopicMapExamples >> pageNodeWhatIsGt [
	"NB: Fragile test, #topics, styles could change. Page title could change."

	<gtExample>
	| pageNodeWhatIsGt |
	pageNodeWhatIsGt := self styleNodeIntroductionWithinAboutGtTopic pageGroup nodes
			detect: [ :n | n page title = 'What is Glamorous Toolkit?' ].
	self assert: pageNodeWhatIsGt fields size equals: 3.
	self assert: pageNodeWhatIsGt topics size equals: 5.
	self assert: pageNodeWhatIsGt styles size equals: 1.
	self assert: pageNodeWhatIsGt pages size equals: 1.
	self assert: pageNodeWhatIsGt children isTMNodeGroup.
	self assert: pageNodeWhatIsGt children isTMPageGroup not.
	^ pageNodeWhatIsGt
]

{ #category : #example }
TopicMapExamples >> pages [
	"NB: missing pages are filtered out."

	<gtExample>
	| pages |
	pages := self topicMap pages.
	self assert: pages size equals: self page2Topics size.
	self assert: pages isTMPageGroup not.
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
TopicMapExamples >> styleNodeIntroductionWithinAboutGtTopic [
	"NB: Since pages can have multiple topics, a style within 
	a topic can branch to multiple other topics and fields,
	as is the case here."

	<gtExample>
	| aboutGtStyleNode |
	aboutGtStyleNode := self topicNodeAboutGt styleNodes nodes
			detect: [ :n | n style = 'Introduction' ].
	self assert: aboutGtStyleNode fields size equals: 3.
	self assert: aboutGtStyleNode topics size equals: 10.
	self assert: aboutGtStyleNode styles size equals: 1.
	self assert: aboutGtStyleNode pages size < aboutGtStyleNode database pages size.
	self assert: aboutGtStyleNode children isTMNodeGroup.
	self assert: aboutGtStyleNode children isTMPageGroup.
	^ aboutGtStyleNode
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
	| topicMap topic2Pages |
	topicMap := self topicMap.
	topic2Pages := self topicMap topic2Pages.
	self pages
		do: [ :aPage | 
			(topicMap topics4Page: aPage)
				do: [ :aTopic | self assert: ((topicMap pages4Topic: aTopic) includes: aPage) ] ].
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

{ #category : #example }
TopicMapExamples >> topicNodeAboutGt [
	"NB: Fragile test, #styles could change in book."

	<gtExample>
	| topicNodeaAboutGt |
	topicNodeaAboutGt := self fieldNodeGtBasics topicNodes nodes
			detect: [ :n | n topic = 'About Glamorous Toolkit' ].
	self assert: topicNodeaAboutGt fields size equals: 1.
	self assert: topicNodeaAboutGt topics size equals: 1.
	self assert: topicNodeaAboutGt styles size equals: 5.
	self assert: topicNodeaAboutGt pages size < topicNodeaAboutGt database pages size.
	self assert: topicNodeaAboutGt children isTMNodeGroup.
	self assert: topicNodeaAboutGt children isTMPageGroup not.
	^ topicNodeaAboutGt
]

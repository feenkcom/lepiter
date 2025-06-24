Class {
	#name : #LeSnippetExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #'examples - basic' }
LeSnippetExamples >> basicDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := LeDatabase new.
	self assert: aDatabase size equals: 0.
	^ aDatabase
]

{ #category : #'examples - basic' }
LeSnippetExamples >> exampleMergingPage [
	"Answer a page with blocks that will be used to demonstrate and test merging"

	<gtExample>
	<return: #LePage>
	| db page |
	db := self basicDatabase.
	page := db pageBuilder
			title: 'Merging';
			add.
	page snippetBuilder
		string: 'One';
		add.
	page snippetBuilder
		string: 'Two';
		add.
	page snippetBuilder
		string: 'Three';
		add.
	page snippetBuilder
		string: 'Four';
		add.
	page snippetBuilder
		string: 'Five';
		add.
	page snippetBuilder
		string: 'Six';
		add.
	self assert: page childrenCount equals: 6.
	^ page
]

{ #category : #'examples - basic' }
LeSnippetExamples >> exampleSplittingPage [
	"Answer a page with blocks that will be used to demonstrate and test merging"

	<gtExample>
	<return: #LePage>
	| db page |
	db := self basicDatabase.
	page := db pageBuilder
			title: 'Splitting';
			add.
	page snippetBuilder
		string: 'OneTwoThree';
		add.
	self assert: page childrenCount equals: 1.
	^ page
]

{ #category : #'examples - indent' }
LeSnippetExamples >> indentSnippetInPage [
	<gtExample>
	<return: #LePage>
	| database page firstSnippet secondSnippet |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #Snippet2.
	page addSnippet: secondSnippet.

	self assert: firstSnippet canBeIndented not.
	self assert: secondSnippet canBeIndented.
	self assert: page childrenCount equals: 2.

	secondSnippet indent.
	self assert: firstSnippet canBeIndented not.
	self assert: secondSnippet canBeIndented not.
	self assert: firstSnippet childrenCount equals: 1.
	self assert: page childrenCount equals: 1.

	^ page
]

{ #category : #'examples - indent' }
LeSnippetExamples >> indentSnippetWithinParentWithChild [
	<gtExample>
	<return: #LePage>
	| database page firstSnippet secondSnippet |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	firstSnippet addSnippet: (LeTextSnippet string: #SnippetC).
	page addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #Snippet3.
	page addSnippet: secondSnippet.

	self assert: firstSnippet canBeIndented not.
	self assert: secondSnippet canBeIndented.
	self assert: page childrenCount equals: 2.

	secondSnippet indent.
	self assert: firstSnippet canBeIndented not.
	self assert: secondSnippet canBeIndented.
	self assert: firstSnippet childrenCount equals: 2.
	self assert: page childrenCount equals: 1.

	^ page
]

{ #category : #'examples - indent' }
LeSnippetExamples >> indentedPage [
	"Answer a page with blocks three and four indented"

	<gtExample>
	<return: #LePage>
	| page snippetTwo snippetThree snippetFour snippetFive snippetSix |
	page := self exampleMergingPage.
	self assert: page childrenCount equals: 6.
	self assert: (page children at: 2) childrenCount equals: 0.

	snippetTwo := page children at: 2.
	snippetThree := page children at: 3.
	snippetFour := page children at: 4.
	snippetFive := page children at: 5.
	snippetSix := page children at: 6.
	snippetFour indent.
	snippetThree indent.
	snippetSix indent.

	self assert: page childrenCount equals: 3.
	self assert: snippetTwo childrenCount equals: 1.
	self assert: snippetTwo children first string equals: 'Three'.
	self assert: snippetThree children first string equals: 'Four'.
	self assert: snippetFive children first string equals: 'Six'.
	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> indentedPage_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetFour addAnnouncements removeAnnouncements |
	page := self exampleMergingPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeAdded
		send: #add:
		to: addAnnouncements.
	page database weak
		when: LeContentTreeRemoved
		send: #add:
		to: removeAnnouncements.

	snippetFour := page children at: 4.
	snippetFour indent.

	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> indentedPage_triggersMoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetFour moveAnnouncements |
	page := self exampleMergingPage.

	moveAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeMoved
		send: #add:
		to: moveAnnouncements.

	snippetFour := page children at: 4.
	snippetFour indent.

	self assert: moveAnnouncements size equals: 1.

	^ page
]

{ #category : #'examples - merging' }
LeSnippetExamples >> mergeNextInChildren [
	"Demonstrate merging two snippets where both have a common parent"

	<gtExample>
	<return: #LeSnippetExamples>
	| page snippetTwo snippetThree snippetFour |
	page := self exampleMergingPage.
	self assert: page childrenCount equals: 6.
	snippetTwo := page children at: 2.
	self assert: snippetTwo childrenCount equals: 0.
	snippetThree := page children at: 3.
	snippetFour := page children at: 4.
	snippetFour indent.
	snippetTwo mergeWithNext.
	self assert: page childrenCount equals: 4.
	self assert: snippetTwo childrenCount equals: 1.
	self assert: snippetTwo string equals: 'TwoThree'.
	self assert: snippetTwo children first string equals: 'Four'
]

{ #category : #'examples - merging' }
LeSnippetExamples >> mergeNextInSelf [
	"Demonstrate merging two snippets where the child is being merged in to the parent"

	<gtExample>
	<return: #LeSnippetExamples>
	| page snippetTwo snippetThree snippetFour |
	page := self exampleMergingPage.
	self assert: page childrenCount equals: 6.
	self assert: (page children at: 2) childrenCount equals: 0.
	snippetTwo := page children at: 2.
	snippetThree := page children at: 3.
	snippetFour := page children at: 4.
	snippetFour indent.
	snippetThree indent.
	snippetTwo mergeWithNext.

	self assert: page childrenCount equals: 4.
	self assert: snippetTwo childrenCount equals: 1.
	self assert: snippetTwo string equals: 'TwoThree'.
	self assert: snippetTwo children first string equals: 'Four'
]

{ #category : #'examples - merging' }
LeSnippetExamples >> mergePreviousInChildren [
	"Demonstrate merging two snippets where both have a common parent"

	<gtExample>
	<return: #LePage>
	| page snippetTwo snippetThree snippetFour |
	page := self exampleMergingPage.
	self assert: page childrenCount equals: 6.
	snippetTwo := page children at: 2.
	self assert: snippetTwo childrenCount equals: 0.
	snippetThree := page children at: 3.
	snippetFour := page children at: 4.
	snippetFour indent.
	snippetThree mergeWithPrevious.
	self assert: page childrenCount equals: 4.
	self assert: snippetTwo childrenCount equals: 1.
	self assert: snippetTwo string equals: 'TwoThree'.
	self assert: snippetTwo children first string equals: 'Four'.
	^ page
]

{ #category : #'examples - merging' }
LeSnippetExamples >> mergePreviousInSelf [
	"Demonstrate merging two snippets where the child is being merged in to the parent"

	<gtExample>
	<return: #LeSnippetExamples>
	| page snippetTwo snippetThree snippetFour |
	page := self exampleMergingPage.
	self assert: page childrenCount equals: 6.
	self assert: (page children at: 2) childrenCount equals: 0.
	snippetTwo := page children at: 2.
	snippetThree := page children at: 3.
	snippetFour := page children at: 4.
	snippetFour indent.
	snippetThree indent.
	snippetThree mergeWithPrevious.
	self assert: page childrenCount equals: 4.
	self assert: snippetTwo childrenCount equals: 1.
	self assert: snippetTwo string equals: 'TwoThree'.
	self assert: snippetTwo children first string equals: 'Four'
]

{ #category : #'examples - moveDown' }
LeSnippetExamples >> moveDownSnippetInPage [
	<gtExample>
	<return: #LePage>
	| database page firstSnippet secondSnippet moveResult |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #Snippet2.
	page addSnippet: secondSnippet.

	self assert: firstSnippet canBeMovedDown.
	self assert: secondSnippet canBeMovedDown not.
	self assert: page childrenCount equals: 2.

	moveResult := firstSnippet moveDown.
	self assert: moveResult.
	self assert: secondSnippet isFirstChild.
	self assert: firstSnippet isLastChild.

	^ page
]

{ #category : #'examples - moveDown' }
LeSnippetExamples >> moveDownSnippetInPage_moveDownAgain [
	<gtExample>
	<return: #LePage>
	| page targetSnippet |
	page := self moveDownSnippetInPage.
	targetSnippet := page children last.

	self assert: targetSnippet moveDown not.

	^ page
]

{ #category : #'examples - moveDown' }
LeSnippetExamples >> moveDownSnippetInSnippetChildren [
	<gtExample>
	<return: #LePage>
	| database page targetSnippet firstSnippet secondSnippet moveResult |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	targetSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: targetSnippet.

	firstSnippet := LeTextSnippet string: #SnippetA.
	targetSnippet addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #SnippetB.
	targetSnippet addSnippet: secondSnippet.

	self assert: firstSnippet canBeMovedDown.
	self assert: secondSnippet canBeMovedDown not.
	self assert: targetSnippet childrenCount equals: 2.

	moveResult := firstSnippet moveDown.
	self assert: moveResult.
	self assert: secondSnippet isFirstChild.
	self assert: firstSnippet isLastChild.
	self assert: secondSnippet canBeMovedDown.
	self assert: firstSnippet canBeMovedDown not.

	^ page
]

{ #category : #'examples - moveDown' }
LeSnippetExamples >> moveDownSnippetToDifferentParentWithChildren [
	<gtExample>
	<return: #LePage>
	| database page childSnippet firstSnippet secondSnippet moveResult |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: firstSnippet.

	secondSnippet := LeTextSnippet string: #Snippet3.
	secondSnippet addSnippet: (LeTextSnippet string: #Snippet4).
	page addSnippet: secondSnippet.

	childSnippet := LeTextSnippet string: #Snippet2.
	firstSnippet addSnippet: childSnippet.

	self assert: childSnippet canBeMovedDown.
	self assert: childSnippet isFirstChild.
	self assert: firstSnippet childrenCount equals: 1.
	self assert: secondSnippet childrenCount equals: 1.

	moveResult := childSnippet moveDown.
	self assert: moveResult.
	self assert: childSnippet canBeMovedDown.
	self assert: childSnippet isFirstChild.
	self assert: childSnippet isLastChild not.
	self assert: firstSnippet childrenCount equals: 0.
	self assert: secondSnippet childrenCount equals: 2.

	self assert: childSnippet parent == secondSnippet.

	^ page
]

{ #category : #'examples - moveUp' }
LeSnippetExamples >> moveDownSnippetToDifferentParentWithoutChildren [
	<gtExample>
	<return: #LePage>
	| database page childSnippet firstSnippet secondSnippet moveResult |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #Snippet3.
	page addSnippet: secondSnippet.

	childSnippet := LeTextSnippet string: #Snippet2.
	firstSnippet addSnippet: childSnippet.

	self assert: childSnippet canBeMovedDown.
	self assert: childSnippet isLastChild.
	self assert: firstSnippet childrenCount equals: 1.
	self assert: secondSnippet childrenCount equals: 0.

	moveResult := childSnippet moveDown.
	self assert: moveResult.
	self assert: childSnippet canBeMovedDown not.
	self assert: childSnippet isLastChild.
	self assert: firstSnippet childrenCount equals: 0.
	self assert: secondSnippet childrenCount equals: 1.

	self assert: childSnippet parent == secondSnippet.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetDownInDifferentParent_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo snippetThree addAnnouncements removeAnnouncements |
	page := self indentedPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeAdded
		send: #add:
		to: addAnnouncements.
	page database weak
		when: LeContentTreeRemoved
		send: #add:
		to: removeAnnouncements.

	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree moveDown.

	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetDownInDifferentParent_triggersMoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo snippetThree moveAnnouncements |
	page := self indentedPage.

	moveAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeMoved
		send: #add:
		to: moveAnnouncements.

	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree moveDown.

	self assert: moveAnnouncements size equals: 1.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetDownInPage_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo addAnnouncements removeAnnouncements |
	page := self exampleMergingPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeAdded
		send: #add:
		to: addAnnouncements.
	page database weak
		when: LeContentTreeRemoved
		send: #add:
		to: removeAnnouncements.

	snippetTwo := page children at: 2.
	snippetTwo moveDown.

	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetDownInPage_triggersMoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo moveAnnouncements |
	page := self exampleMergingPage.

	moveAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeMoved
		send: #add:
		to: moveAnnouncements.

	snippetTwo := page children at: 2.
	snippetTwo moveDown.

	self assert: moveAnnouncements size equals: 1.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetUpInDifferentParent_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo snippetThree addAnnouncements removeAnnouncements |
	page := self indentedPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeAdded
		send: #add:
		to: addAnnouncements.
	page database weak
		when: LeContentTreeRemoved
		send: #add:
		to: removeAnnouncements.

	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree moveUp.

	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetUpInDifferentParent_triggersMoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo snippetThree moveAnnouncements |
	page := self indentedPage.

	moveAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeMoved
		send: #add:
		to: moveAnnouncements.

	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree moveUp.

	self assert: moveAnnouncements size equals: 1.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetUpInPage_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo addAnnouncements removeAnnouncements |
	page := self exampleMergingPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeAdded
		send: #add:
		to: addAnnouncements.
	page database weak
		when: LeContentTreeRemoved
		send: #add:
		to: removeAnnouncements.

	snippetTwo := page children at: 2.
	snippetTwo moveUp.

	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetUpInPage_triggersMoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo moveAnnouncements |
	page := self exampleMergingPage.

	moveAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeMoved
		send: #add:
		to: moveAnnouncements.

	snippetTwo := page children at: 2.
	snippetTwo moveUp.

	self assert: moveAnnouncements size equals: 1.

	^ page
]

{ #category : #'examples - basic' }
LeSnippetExamples >> moveSnippetWithChildren [
	"Demonstrate that moving a snippet between pages keeps the snippet's children"

	<gtExample>
	<return: #LeDatabase>
	| db1 page1 page2 snippet |
	db1 := self basicDatabase.
	page1 := LePage named: #Page1.
	db1 addPage: page1.
	page2 := LePage named: #Page2.
	db1 addPage: page2.

	snippet := LeTextSnippet string: #Snippet1.
	snippet addSnippet: (LeTextSnippet string: #Snippet2).
	page1 addSnippet: snippet.

	self assert: page1 childrenCount equals: 1.
	self assert: page2 childrenCount equals: 0.
	self assert: snippet childrenCount equals: 1.

	snippet removeSelf.
	page2 addSnippet: snippet.

	self assert: page1 childrenCount equals: 0.
	self assert: page2 childrenCount equals: 1.
	self assert: snippet childrenCount equals: 1.

	^ db1
]

{ #category : #'examples - moveUp' }
LeSnippetExamples >> moveUpSnippetInPage [
	"Demonstrate that moving a snippet between pages keeps the snippet's children"

	<gtExample>
	<return: #LePage>
	| database page firstSnippet secondSnippet moveResult |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #Snippet2.
	page addSnippet: secondSnippet.

	self assert: firstSnippet canBeMovedUp not.
	self assert: secondSnippet canBeMovedUp.
	self assert: page childrenCount equals: 2.

	moveResult := secondSnippet moveUp.
	self assert: moveResult.
	self assert: secondSnippet isFirstChild.
	self assert: firstSnippet isFirstChild not.

	^ page
]

{ #category : #'examples - moveUp' }
LeSnippetExamples >> moveUpSnippetInSnippetChildren [
	<gtExample>
	<return: #LePage>
	| database page targetSnippet firstSnippet secondSnippet moveResult |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	targetSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: targetSnippet.

	firstSnippet := LeTextSnippet string: #SnippetA.
	targetSnippet addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #SnippetB.
	targetSnippet addSnippet: secondSnippet.

	self assert: firstSnippet canBeMovedUp not.
	self assert: secondSnippet canBeMovedUp.
	self assert: targetSnippet childrenCount equals: 2.

	moveResult := secondSnippet moveUp.
	self assert: moveResult.
	self assert: secondSnippet isFirstChild.
	self assert: firstSnippet isFirstChild not.
	self assert: firstSnippet canBeMovedUp.
	self assert: secondSnippet canBeMovedUp not.

	^ page
]

{ #category : #'examples - moveUp' }
LeSnippetExamples >> moveUpSnippetToDifferentParentWithChildren [
	<gtExample>
	<return: #LePage>
	| database page childSnippet firstSnippet secondSnippet moveResult |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	firstSnippet addSnippet: (LeTextSnippet string: #Snippet2).
	page addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #Snippet3.
	page addSnippet: secondSnippet.

	childSnippet := LeTextSnippet string: #Snippet4.
	secondSnippet addSnippet: childSnippet.

	self assert: childSnippet canBeMovedUp.
	self assert: childSnippet isFirstChild.
	self assert: firstSnippet childrenCount equals: 1.
	self assert: secondSnippet childrenCount equals: 1.

	moveResult := childSnippet moveUp.
	self assert: moveResult.
	self assert: childSnippet canBeMovedUp.
	self assert: childSnippet isFirstChild not.
	self assert: firstSnippet childrenCount equals: 2.
	self assert: secondSnippet childrenCount equals: 0.

	self assert: childSnippet parent == firstSnippet.

	^ page
]

{ #category : #'examples - moveUp' }
LeSnippetExamples >> moveUpSnippetToDifferentParentWithoutChildren [
	<gtExample>
	<return: #LePage>
	| database page childSnippet firstSnippet secondSnippet moveResult |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #Snippet2.
	page addSnippet: secondSnippet.

	childSnippet := LeTextSnippet string: #Snippet3.
	secondSnippet addSnippet: childSnippet.

	self assert: childSnippet canBeMovedUp.
	self assert: childSnippet isFirstChild.
	self assert: firstSnippet childrenCount equals: 0.
	self assert: secondSnippet childrenCount equals: 1.

	moveResult := childSnippet moveUp.
	self assert: moveResult.
	self assert: childSnippet canBeMovedUp not.
	self assert: childSnippet isFirstChild.
	self assert: firstSnippet childrenCount equals: 1.
	self assert: secondSnippet childrenCount equals: 0.

	self assert: childSnippet parent == firstSnippet.

	^ page
]

{ #category : #'examples - basic' }
LeSnippetExamples >> pageWithTwoChildren [
	"Answer a page with two not intended snippets"

	<gtExample>
	<return: #LePage>
	| db page |
	db := self basicDatabase.
	page := db pageBuilder
			title: 'Merging';
			add.
	page snippetBuilder
		string: 'One';
		add.
	page snippetBuilder
		string: 'Two';
		add.
	self assert: page childrenCount equals: 2.

	^ page
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetFiveNext [
	"Check that the previous snippet of snippet five is snippet six"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet nextSnippet |
	page := self indentedPage.
	startSnippet := page children at: 3.
	self assert: startSnippet string equals: 'Five'.
	nextSnippet := startSnippet nextSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: nextSnippet isNotNil.
	self assert: nextSnippet string equals: 'Six'.
	^ nextSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetFivePrevious [
	"Check that the previous snippet of snippet five is snippet four"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet previousSnippet |
	page := self indentedPage.
	startSnippet := page children at: 3.
	self assert: startSnippet string equals: 'Five'.
	previousSnippet := startSnippet previousSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: previousSnippet isNotNil.
	self assert: previousSnippet string equals: 'Four'.
	^ previousSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetFourNext [
	"Check that the previous snippet of snippet four is snippet five"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet nextSnippet |
	page := self indentedPage.
	startSnippet := (page children at: 2) lastChildOrSelf.
	self assert: startSnippet string equals: 'Four'.
	nextSnippet := startSnippet nextSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: nextSnippet isNotNil.
	self assert: nextSnippet string equals: 'Five'.
	^ nextSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetFourPrevious [
	"Check that the previous snippet of snippet four is snippet three"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet previousSnippet |
	page := self indentedPage.
	startSnippet := (page children at: 2) lastChildOrSelf.
	self assert: startSnippet string equals: 'Four'.
	previousSnippet := startSnippet previousSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: previousSnippet isNotNil.
	self assert: previousSnippet string equals: 'Three'.
	^ previousSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetOnePrevious [
	"Check that the previous snippet of snippet one raises an Error"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet previousSnippet |
	page := self indentedPage.
	startSnippet := page children at: 1.
	self assert: startSnippet string equals: 'One'.
	startSnippet previousSnippetDo: [ :b | previousSnippet := b ] ifNone: [ nil ].
	self assert: previousSnippet isNil.

	^ startSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetOnePrevious_pageWithTwoChildren [
	"Check that the previous snippet of the first snippet does not exist"

	<gtExample>
	<return: #LePage>
	| page startSnippet previousSnippet |
	page := self pageWithTwoChildren.
	startSnippet := page children at: 1.
	self assert: startSnippet string equals: 'One'.
	previousSnippet := startSnippet previousSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: previousSnippet isNil.

	^ page
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetSixNext [
	"Check that the next snippet of the last snippet raises an Error"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet nextSnippet |
	page := self indentedPage.
	startSnippet := page children last children last.
	self assert: startSnippet string equals: 'Six'.
	startSnippet nextSnippetDo: [ :b | nextSnippet := b ] ifNone: [ nil ].
	self assert: nextSnippet isNil.

	^ startSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetThreeNext [
	"Check that the previous snippet of snippet two is snippet three"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet nextSnippet |
	page := self indentedPage.
	startSnippet := (page children at: 2) children first.
	self assert: startSnippet string equals: 'Three'.
	nextSnippet := startSnippet nextSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: nextSnippet isNotNil.
	self assert: nextSnippet string equals: 'Four'.
	^ nextSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetThreePrevious [
	"Check that the previous block of block three is block two"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet previousSnippet |
	page := self indentedPage.
	startSnippet := (page children at: 2) children first.
	self assert: startSnippet string equals: 'Three'.
	previousSnippet := startSnippet previousSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: previousSnippet isNotNil.
	self assert: previousSnippet string equals: 'Two'.
	^ previousSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetTwoNext [
	"Check that the previous snippet of snippet two is snippet three"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet nextSnippet |
	page := self indentedPage.
	startSnippet := page children at: 2.
	self assert: startSnippet string equals: 'Two'.
	nextSnippet := startSnippet nextSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: nextSnippet isNotNil.
	self assert: nextSnippet string equals: 'Three'.
	^ nextSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetTwoNext_pageWithTwoChildren [
	"Check that the next snippet of the last snippet does not exist"

	<gtExample>
	<return: #LePage>
	| page startSnippet nextSnippet |
	page := self pageWithTwoChildren.
	startSnippet := page children at: 2.
	self assert: startSnippet string equals: 'Two'.
	nextSnippet := startSnippet nextSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: nextSnippet isNil.

	^ page
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetTwoPrevious [
	"Check that the previous snippet of snippet two is snippet one"

	<gtExample>
	<return: #LeTextSnippet>
	| page startSnippet previousSnippet |
	page := self indentedPage.
	startSnippet := page children at: 2.
	self assert: startSnippet string equals: 'Two'.
	previousSnippet := startSnippet previousSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: previousSnippet isNotNil.
	self assert: previousSnippet string equals: 'One'.
	^ previousSnippet
]

{ #category : #'examples - merging' }
LeSnippetExamples >> splitFirstSnippet [
	<gtExample>
	<return: #LePage>
	| page snippetOne snippetTwo splitCommand splitResult |
	page := self exampleSplittingPage.
	snippetOne := page children at: 1.
	self assert: snippetOne childrenCount equals: 0.
	splitCommand := snippetOne splitSnippetCommandAtPosition: 3.
	splitResult := splitCommand execute.
	self assert: page childrenCount equals: 2.
	snippetOne := page children at: 1.
	snippetTwo := page children at: 2.
	self assert: snippetOne string equals: 'One'.
	self assert: snippetTwo string equals: 'TwoThree'.

	self assert: (snippetOne createEmail isKindOf: LeEmail).
	self assert: (snippetTwo createEmail isKindOf: LeEmail).
	^ page
]

{ #category : #'examples - unindent' }
LeSnippetExamples >> unindentChildSnippet [
	<gtExample>
	<return: #LePage>
	| database page firstSnippet secondSnippet |
	database := self basicDatabase.
	page := LePage named: #Page1.
	database addPage: page.

	firstSnippet := LeTextSnippet string: #Snippet1.
	page addSnippet: firstSnippet.
	secondSnippet := LeTextSnippet string: #Snippet2.
	firstSnippet addSnippet: secondSnippet.

	self assert: firstSnippet canBeUnindented not.
	self assert: secondSnippet canBeUnindented.
	self assert: page childrenCount equals: 1.

	secondSnippet unindent.
	self assert: firstSnippet canBeUnindented not.
	self assert: secondSnippet canBeUnindented not.
	self assert: firstSnippet childrenCount equals: 0.
	self assert: page childrenCount equals: 2.

	self assert: secondSnippet parent == page.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> unindentSnippet_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo snippetThree addAnnouncements removeAnnouncements |
	page := self indentedPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeAdded
		send: #add:
		to: addAnnouncements.
	page database weak
		when: LeContentTreeRemoved
		send: #add:
		to: removeAnnouncements.

	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree unindent.

	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.

	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> unindentSnippet_triggersMoveAnnouncement [
	<gtExample>
	<return: #LePage>
	| page snippetTwo snippetThree moveAnnouncements |
	page := self indentedPage.

	moveAnnouncements := OrderedCollection new.
	page database weak
		when: LeContentTreeMoved
		send: #add:
		to: moveAnnouncements.

	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree unindent.

	self assert: moveAnnouncements size equals: 1.

	^ page
]

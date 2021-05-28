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
	| aDatabase |
	aDatabase := LeDatabase new.
	self assert: aDatabase size equals: 0.
	^ aDatabase
]

{ #category : #'examples - basic' }
LeSnippetExamples >> examplePage [
	"Answer a page with blocks that will be used to demonstrate and test merging"
	<gtExample>
	| db page |

	db := self basicDatabase.
	page := db pageBuilder title: 'Merging'; add.
	page snippetBuilder string: 'One'; add.
	page snippetBuilder string: 'Two'; add.
	page snippetBuilder string: 'Three'; add.
	page snippetBuilder string: 'Four'; add.
	page snippetBuilder string: 'Five'; add.
	page snippetBuilder string: 'Six'; add.
	self assert: page childrenCount equals: 6.
	^ page

]

{ #category : #'examples - basic' }
LeSnippetExamples >> indentedPage [
	"Answer a page with blocks three and four indented"
	<gtExample>
	| page snippetTwo snippetThree snippetFour snippetFive snippetSix |

	page := self examplePage.
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
	| page snippetFour addAnnouncements removeAnnouncements |

	page := self examplePage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database when: LeContentTreeAdded do: [ :anAddAnnouncement | 
		addAnnouncements add: anAddAnnouncement ].
	page database when: LeContentTreeRemoved do: [ :aRemoveAnnouncement | 
		removeAnnouncements add: aRemoveAnnouncement ].
	
	snippetFour := page children at: 4.
	snippetFour indent.
	
	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.
	
	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> indentedPage_triggersMoveAnnouncement [
	<gtExample>
	| page snippetFour moveAnnouncements |

	page := self examplePage.

	moveAnnouncements := OrderedCollection new.
	page database when: LeContentTreeMoved do: [ :aMoveAnnouncement | 
		moveAnnouncements add: aMoveAnnouncement ].
	
	snippetFour := page children at: 4.
	snippetFour indent.
	
	self assert: moveAnnouncements size equals: 1.
	
	^ page
]

{ #category : #'examples - merging' }
LeSnippetExamples >> mergeNextInChildren [
	"Demonstrate merging two snippets where both have a common parent"
	<gtExample>
	| page snippetTwo snippetThree snippetFour |

	page := self examplePage.
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
	self assert: snippetTwo children first string equals: 'Four'.
]

{ #category : #'examples - merging' }
LeSnippetExamples >> mergeNextInSelf [
	"Demonstrate merging two snippets where the child is being merged in to the parent"
	<gtExample>
	| page snippetTwo snippetThree snippetFour |

	page := self examplePage.
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
	self assert: snippetTwo children first string equals: 'Four'.
]

{ #category : #'examples - merging' }
LeSnippetExamples >> mergePreviousInChildren [
	"Demonstrate merging two snippets where both have a common parent"
	<gtExample>
	| page snippetTwo snippetThree snippetFour |

	page := self examplePage.
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
]

{ #category : #'examples - merging' }
LeSnippetExamples >> mergePreviousInSelf [
	"Demonstrate merging two snippets where the child is being merged in to the parent"
	<gtExample>
	| page snippetTwo snippetThree snippetFour |

	page := self examplePage.
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
	self assert: snippetTwo children first string equals: 'Four'.
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetDownInDifferentParent_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	| page snippetTwo snippetThree addAnnouncements removeAnnouncements |

	page := self indentedPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database when: LeContentTreeAdded do: [ :anAddAnnouncement | 
		addAnnouncements add: anAddAnnouncement ].
	page database when: LeContentTreeRemoved do: [ :aRemoveAnnouncement | 
		removeAnnouncements add: aRemoveAnnouncement ].
	
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
	| page snippetTwo snippetThree moveAnnouncements |

	page := self indentedPage.

	moveAnnouncements := OrderedCollection new.
	page database when: LeContentTreeMoved do: [ :aMoveAnnouncement | 
		moveAnnouncements add: aMoveAnnouncement ].
	
	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree moveDown.
	
	self assert: moveAnnouncements size equals: 1.
	
	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetDownInPage_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	| page snippetTwo addAnnouncements removeAnnouncements |

	page := self examplePage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database when: LeContentTreeAdded do: [ :anAddAnnouncement | 
		addAnnouncements add: anAddAnnouncement ].
	page database when: LeContentTreeRemoved do: [ :aRemoveAnnouncement | 
		removeAnnouncements add: aRemoveAnnouncement ].
	
	snippetTwo := page children at: 2.
	snippetTwo moveDown.
	
	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.
	
	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetDownInPage_triggersMoveAnnouncement [
	<gtExample>
	| page snippetTwo moveAnnouncements |

	page := self examplePage.

	moveAnnouncements := OrderedCollection new.
	page database when: LeContentTreeMoved do: [ :aMoveAnnouncement | 
		moveAnnouncements add: aMoveAnnouncement ].
	
	snippetTwo := page children at: 2.
	snippetTwo moveDown.
	
	self assert: moveAnnouncements size equals:  1.
	
	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetUpInDifferentParent_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	| page snippetTwo snippetThree addAnnouncements removeAnnouncements |

	page := self indentedPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database when: LeContentTreeAdded do: [ :anAddAnnouncement | 
		addAnnouncements add: anAddAnnouncement ].
	page database when: LeContentTreeRemoved do: [ :aRemoveAnnouncement | 
		removeAnnouncements add: aRemoveAnnouncement ].
	
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
	| page snippetTwo snippetThree moveAnnouncements |

	page := self indentedPage.

	moveAnnouncements := OrderedCollection new.
	page database when: LeContentTreeMoved do: [ :aMoveAnnouncement | 
		moveAnnouncements add: aMoveAnnouncement ].
	
	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree moveUp.
	
	self assert: moveAnnouncements size equals: 1.
	
	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetUpInPage_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	| page snippetTwo addAnnouncements removeAnnouncements |

	page := self examplePage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database when: LeContentTreeAdded do: [ :anAddAnnouncement | 
		addAnnouncements add: anAddAnnouncement ].
	page database when: LeContentTreeRemoved do: [ :aRemoveAnnouncement | 
		removeAnnouncements add: aRemoveAnnouncement ].
	
	snippetTwo := page children at: 2.
	snippetTwo moveUp.
	
	self assert: addAnnouncements size equals: 0.
	self assert: removeAnnouncements size equals: 0.
	
	^ page
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> moveSnippetUpInPage_triggersMoveAnnouncement [
	<gtExample>
	| page snippetTwo moveAnnouncements |

	page := self examplePage.

	moveAnnouncements := OrderedCollection new.
	page database when: LeContentTreeMoved do: [ :aMoveAnnouncement | 
		moveAnnouncements add: aMoveAnnouncement ].
	
	snippetTwo := page children at: 2.
	snippetTwo moveUp.
	
	self assert: moveAnnouncements size equals:  1.
	
	^ page
]

{ #category : #'examples - basic' }
LeSnippetExamples >> moveSnippetWithChildren [
	"Demonstrate that moving a snippet between pages keeps the snippet's children"
	<gtExample>
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

{ #category : #'examples - basic' }
LeSnippetExamples >> pageWithTwoChildren [
	"Answer a page with two not intended snippets"
	<gtExample>
	| db page |

	db := self basicDatabase.
	page := db pageBuilder title: 'Merging'; add.
	page snippetBuilder string: 'One'; add.
	page snippetBuilder string: 'Two'; add.
	self assert: page childrenCount equals: 2.

	^ page
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetFiveNext [
	"Check that the previous snippet of snippet five is snippet six"
	<gtExample>
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
	| page startSnippet previousSnippet |

	page := self indentedPage.
	startSnippet := (page children at: 1).
	self assert: startSnippet string equals: 'One'.
	startSnippet previousSnippetDo: [ :b | previousSnippet := b ] ifNone: [ nil ].
	self assert: previousSnippet isNil.

	^ startSnippet
]

{ #category : #'examples - previous / next' }
LeSnippetExamples >> snippetOnePrevious_pageWithTwoChildren [
	"Check that the previous snippet of the first snippet does not exist"
	<gtExample>
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
	| page startSnippet nextSnippet |

	page := self indentedPage.
	startSnippet := (page children at: 2).
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
	| page startSnippet previousSnippet |

	page := self indentedPage.
	startSnippet := (page children at: 2).
	self assert: startSnippet string equals: 'Two'.
	previousSnippet := startSnippet previousSnippetDo: [ :b | b ] ifNone: [ nil ].
	self assert: previousSnippet isNotNil.
	self assert: previousSnippet string equals: 'One'.
	^ previousSnippet
]

{ #category : #'examples - announcements' }
LeSnippetExamples >> unindentSnippet_doesNotTriggerAddAndRemoveAnnouncement [
	<gtExample>
	| page snippetTwo snippetThree addAnnouncements removeAnnouncements |

	page := self indentedPage.

	addAnnouncements := OrderedCollection new.
	removeAnnouncements := OrderedCollection new.
	page database when: LeContentTreeAdded do: [ :anAddAnnouncement | 
		addAnnouncements add: anAddAnnouncement ].
	page database when: LeContentTreeRemoved do: [ :aRemoveAnnouncement | 
		removeAnnouncements add: aRemoveAnnouncement ].
	
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
	| page snippetTwo snippetThree moveAnnouncements |

	page := self indentedPage.

	moveAnnouncements := OrderedCollection new.
	page database when: LeContentTreeMoved do: [ :aMoveAnnouncement | 
		moveAnnouncements add: aMoveAnnouncement ].
	
	snippetTwo := page children at: 2.
	snippetThree := snippetTwo children first.
	snippetThree unindent.
	
	self assert: moveAnnouncements size equals: 1.
	
	^ page
]

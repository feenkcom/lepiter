"
I exemplify {{gtClass:LeElement}}.


"
Class {
	#name : #LeUIExamples,
	#superclass : #Object,
	#traits : 'TLeSpaceExamples',
	#classTraits : 'TLeSpaceExamples classTrait',
	#category : #'Lepiter-UI-Examples'
}

{ #category : #'examples - database - tree' }
LeUIExamples >> basicDatabaseFilteredTreeElement [
	<gtExample>
	<return: #LeDatabaseFilteredTreeElement>
	| anElement |
	anElement := LeDatabaseFilteredTreeElement new.
	anElement matchParent.
	self assert: anElement hasDatabase not.
	^ anElement
]

{ #category : #'examples - database - header' }
LeUIExamples >> basicDatabaseHeaderElement [
	<gtExample>
	<return: #LeDatabaseHeaderElement>
	| anElement |
	anElement := LeDatabaseHeaderElement new.
	anElement matchParent.
	self assert: anElement hasDatabase not.
	^ anElement
]

{ #category : #'examples - database - sidebar' }
LeUIExamples >> basicDatabaseSidebarElement [
	<gtExample>
	<return: #LeDatabaseSidebarElement>
	| anElement |
	anElement := LeDatabaseSidebarElement new.
	anElement show.
	self assert: anElement hasDatabase not.
	^ anElement
]

{ #category : #'examples - database - tool' }
LeUIExamples >> basicDatabaseToolElement [
	<gtExample>
	<return: #LeDatabaseToolElement>
	| anElement |
	anElement := LeDatabaseToolElement new.
	anElement matchParent.
	self assert: anElement hasDatabase not.
	^ anElement
]

{ #category : #'examples - database - tree' }
LeUIExamples >> basicDatabaseTreeElement [
	<gtExample>
	<return: #LeDatabaseTreeElement>
	| anElement |
	anElement := LeDatabaseTreeElement new.
	anElement matchParent.
	self assert: anElement hasDatabase not.
	^ anElement
]

{ #category : #'examples - page - block tree' }
LeUIExamples >> basicPageBlockTreeElement [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement |
	anElement := LePageToolContentTreeElement new.
	self assert: anElement hasPage not.

	^ anElement
]

{ #category : #'examples - page - title and edit info' }
LeUIExamples >> basicPageTitleAndEditInfoElement [
	<gtExample>
	<return: #LePageTitleAndSummaryElement>
	| anElement |
	anElement := LePageTitleAndSummaryElement new.
	self assert: anElement hasPage not.
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> basicPageToolContentElement [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement |
	anElement := LePageToolContentTreeElement new.
	self assert: anElement hasPage not.
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> basicPageToolElement [
	<gtExample>
	<return: #LePageToolElement>
	| anElement |
	anElement := LePageToolElement new.
	self assert: anElement hasPage not.
	^ anElement
]

{ #category : #'examples - toolbar' }
LeUIExamples >> basicToolbar [
	<gtExample>
	<return: #LeToolbarElement>
	| anElement |
	anElement := LeToolbarElement new matchParent.
	^ anElement
]

{ #category : #'examples - model' }
LeUIExamples >> blockWithLinkToPage [
	<gtExample>
	<return: #LeTextSnippet>
	| aPage aSnippet |
	aPage := self database pageBuilder
			title: 'one';
			add.
	aSnippet := aPage snippetBuilder
			string: (String loremIpsum: 100) allButLast , ' [[two]] ' , (String loremIpsum: 100);
			add.
	self assert: aSnippet isTextSnippet.
	^ aSnippet
]

{ #category : #'examples - support' }
LeUIExamples >> buttonIcon: anIcon tooltip: aTooltip [
	<gtExample>
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: anIcon;
		label: aTooltip
]

{ #category : #'examples - model' }
LeUIExamples >> database [
	<gtExample>
	<return: #LeDatabase>
	| database folderReference localStore |
	folderReference := FileSystem memory / 'storage-main'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad current.
	localStore localRoot: folderReference.
	database := localStore loadAndMonitorFrom: folderReference.
	self assert: database explicitLinks size equals: 0.
	^ database
]

{ #category : #'examples - database - tree' }
LeUIExamples >> databaseFilteredTreeElement [
	<gtExample>
	<return: #LeDatabaseFilteredTreeElement>
	| anElement aDatabase |
	anElement := self basicDatabaseFilteredTreeElement.
	aDatabase := self databaseWithTwoPagesAndTwoDailyNotes.
	anElement databaseViewModel: aDatabase asContentUIModel.
	self assert: anElement database equals: aDatabase.
	^ anElement
]

{ #category : #'examples - database - header' }
LeUIExamples >> databaseHeaderElement [
	<gtExample>
	<return: #LeDatabaseHeaderElement>
	| anElement aDatabase |
	anElement := self basicDatabaseHeaderElement.
	aDatabase := self databaseWithTwoPagesAndTwoDailyNotes.

	anElement databaseViewModel: aDatabase asContentUIModel.

	self assert: anElement database equals: aDatabase.

	^ anElement
]

{ #category : #'examples - database - sidebar' }
LeUIExamples >> databaseSidebarElement [
	<gtExample>
	<return: #LeDatabaseSidebarElement>
	| anElement aDatabase aValue |
	anElement := self basicDatabaseSidebarElement.

	aDatabase := self databaseWithTwoPagesAndTwoDailyNotes.
	anElement databaseViewModel: aDatabase asContentUIModel.

	self assert: anElement database equals: aDatabase.

	aValue := nil.
	self assert: anElement tabGroupElement tabs size equals: 1.
	^ anElement
]

{ #category : #'examples - database - sidebar' }
LeUIExamples >> databaseSidebarElementWithTableOfContents [
	<gtExample>
	"should be rewritten to use Scripter"
	<noTest>
	| anElement aDatabase aValue |
	anElement := self basicDatabaseSidebarElement.
	aDatabase := self databaseWithTableOfContents.
	anElement databaseViewModel: aDatabase asContentUIModel.
	self assert: anElement database equals: aDatabase.
	self assert: anElement pagesElement items size equals: 9.
	self assert: anElement dailyNotesGroupElement items size equals: 1.
	
	self assert: anElement tableOfContentsTab isNotNil.
	self assert: anElement tabGroupElement tabs size equals: 3.
	self assert: anElement tableOfContentsTab viewModel isSelected.

	aValue := nil.
	anElement tableOfContentsElementDo: [ :tocElement | aValue := tocElement ].
	self assert: aValue isNotNil.
	
	^ anElement
]

{ #category : #'examples - database - sidebar' }
LeUIExamples >> databaseSidebarElement_AddPage [
	<gtExample>
	<return: #LeDatabaseSidebarElement>
	| anElement aDatabase |
	anElement := self databaseSidebarElement.
	aDatabase := anElement database.
	aDatabase pageBuilder
		title: 'newly added';
		add.
	^ anElement
]

{ #category : #'examples - database - tool' }
LeUIExamples >> databaseToolElement [
	<gtExample>
	<return: #LeDatabaseToolElement>
	| anElement aDatabase |
	anElement := self basicDatabaseToolElement.
	aDatabase := self databaseWithTwoPagesAndTwoDailyNotes.
	anElement databaseViewModel: aDatabase asContentUIModel.
	self assert: anElement database equals: aDatabase.
	^ anElement
]

{ #category : #'examples - database - tree' }
LeUIExamples >> databaseTreeElement [
	<gtExample>
	<return: #LeDatabaseTreeElement>
	| anElement aDatabase |
	anElement := self basicDatabaseTreeElement.
	aDatabase := self databaseWithTwoPagesAndTwoDailyNotes.
	anElement databaseViewModel: aDatabase asContentUIModel.
	self assert: anElement database equals: aDatabase.
	^ anElement
]

{ #category : #'examples - model' }
LeUIExamples >> databaseWithLinkedReferencesAmongPages [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage |
	aDatabase := self database.	"one"
	aPage := aDatabase pageBuilder
			title: 'one';
			add.
	aPage snippetBuilder
		string: 'one > one';
		add.
	aPage snippetBuilder
		string: 'one > two [[three]]';
		add.
	aPage snippetBuilder
		string: 'one > three [[four]]';
		add.	"two"
	aPage := aDatabase pageBuilder
			title: 'two';
			add.
	aPage snippetBuilder
		string: 'two > one';
		add.
	aPage snippetBuilder
		string: 'two > two [[three]]';
		add.	"three"
	aPage := aDatabase pageBuilder
			title: 'three';
			add.
	aPage snippetBuilder
		string: 'three > one';
		add.
	aPage snippetBuilder
		string: 'three > two';
		add.	"four"
	aPage := aDatabase pageBuilder
			title: 'four';
			add.
	aPage snippetBuilder
		string: 'four > one [[four]]';
		add.
	aPage snippetBuilder
		string: 'four > two';
		add.

	^ aDatabase
]

{ #category : #'examples - model' }
LeUIExamples >> databaseWithPageAAndLinkToPageB [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self database.
	aDatabase pageBuilder
		title: 'b';
		add.
	(aDatabase pageBuilder
		title: 'a';
		add) snippetBuilder
		string: '[[b]]';
		add.
	^ aDatabase
]

{ #category : #'examples - model' }
LeUIExamples >> databaseWithTableOfContents [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aFile |
	aFile := GtResourceReference path: Path * 'feenkcom/lepiter/test-data/toc'.
	aDatabase := LeLocalStoreLoad current loadAndMonitorFrom: aFile fileReference.
	^ aDatabase
]

{ #category : #'examples - model' }
LeUIExamples >> databaseWithTableOfContentsDuplicatePage [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aFile |
	aFile := GtResourceReference path: Path * 'feenkcom/lepiter/test-data/toc'.
	aDatabase := LeLocalStoreLoad current loadAndMonitorFrom: aFile fileReference.
	aDatabase stopMonitoring.
	aDatabase tableOfContents
		addSnippet: (LeTextSnippet string: aDatabase tableOfContents children last text).
	^ aDatabase
]

{ #category : #'examples - model' }
LeUIExamples >> databaseWithTwoPagesAndTwoDailyNotes [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self titledPageWithBlockHierachy database.
	aDatabase pageBuilder
		title: 'two';
		add.
	aDatabase pageBuilder
		noteOf: Date today;
		add.
	aDatabase pageBuilder
		noteOf: Date yesterday;
		add.
	^ aDatabase
]

{ #category : #'examples - model' }
LeUIExamples >> linkedReferences_PageThree [
	<gtExample>
	<return: #LeIncomingExplicitPageLinksGroup>
	| aPage aReference |
	aPage := self pageThreeOfDatabaseWithLinkedReferencesAmongPages.
	aReference := (LeLinksSelector default rootsFor: aPage) first.

	^ aReference
]

{ #category : #'examples - page - block tree' }
LeUIExamples >> pageBlockTreeElement_Hierarchy [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement aPage |
	aPage := self titledPageWithBlockHierachy.

	anElement := self basicPageBlockTreeElement.
	anElement pageViewModel: aPage asContentUIModel.

	self assert: anElement treeElement viewModel itemCount equals: 6.

	^ anElement
]

{ #category : #'examples - page - block tree' }
LeUIExamples >> pageBlockTreeElement_NoHierarchy [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement aPage |
	aPage := self titledPage.

	anElement := self basicPageBlockTreeElement.
	anElement pageViewModel: aPage asContentUIModel.

	self assert: anElement treeElement viewModel itemCount equals: 1.

	^ anElement
]

{ #category : #'examples - model' }
LeUIExamples >> pageThreeOfDatabaseWithLinkedReferencesAmongPages [
	<gtExample>
	<return: #LePage>
	| aDatabase aPage |
	aDatabase := self databaseWithLinkedReferencesAmongPages.
	aPage := aDatabase pageNamed: 'three'.
	^ aPage
]

{ #category : #'examples - page - title and edit info' }
LeUIExamples >> pageTitleAndEditInfoElement [
	<gtExample>
	<return: #LePageTitleAndSummaryElement>
	| anElement aPage aPageViewModel |
	anElement := self basicPageTitleAndEditInfoElement.
	aPage := self titledPage.
	aPageViewModel := aPage asContentUIModel.
	anElement pageViewModel: aPageViewModel.
	self assert: anElement titleElement text asString equals: aPage title.	"self assert: anElement dateElement text asString equals: aPage editTime asDate asString.
	self assert: anElement emailElement text asString equals: aPage editEmail email asString."
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> pageToolContentElement_Hierarchy [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement aPage |
	anElement := self basicPageToolContentElement.
	aPage := self titledPageWithBlockHierachy.
	anElement pageViewModel: aPage asContentUIModel.
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> pageToolContentElement_NoHierarchy [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement aPage |
	anElement := self basicPageToolContentElement.
	aPage := self titledPage.
	anElement pageViewModel: aPage asContentUIModel.
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> pageToolContentElement_RemovePage [
	<gtExample>
	<return: #BlScripter>
	| anElement aRemovedPage aNewPage aScripter aDatabase |
	aScripter := BlScripter new.
	anElement := self pageToolContentElement_Hierarchy.
	aScripter element: anElement.

	aRemovedPage := anElement pageViewModel pageModel.
	aDatabase := aRemovedPage database.

	aScripter do
		block: [ anElement pageViewModel removePage ];
		play.

	aNewPage := anElement pageViewModel pageModel.	"See https://github.com/feenkcom/gtoolkit/issues/4186
	We do not create new pages anymore.
	Instead, the page widget indicates that page is deleted."
	self assert: aNewPage == aRemovedPage.
	self assert: aNewPage ~= LePage null.
	self assert: aNewPage class equals: LePage.
	self assert: aDatabase pageCount equals: 0.
	^ aScripter
]

{ #category : #'examples - page - toolbar' }
LeUIExamples >> pageToolContentElement_TitleAndAllActionButtons [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement anItem |
	anElement := self pageToolContentElement_Hierarchy.
	anElement withTitleOnly.
	anItem := anElement headerElement childAt: 1.
	self assert: anItem equals: anElement titleElement.
	^ anElement
]

{ #category : #'examples - page - toolbar' }
LeUIExamples >> pageToolContentElement_TitleAndInspectButton [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement anItem |
	anElement := self pageToolContentElement_Hierarchy.
	anElement withTitleAndButtons.
	anItem := anElement headerElement childAt: 1.
	self assert: anItem equals: anElement titleElement.
	^ anElement
]

{ #category : #'examples - page - toolbar' }
LeUIExamples >> pageToolContentElement_TitleOnly [
	<gtExample>
	<return: #LePageToolContentTreeElement>
	| anElement anItem |
	anElement := self pageToolContentElement_Hierarchy.
	anElement withTitleOnly.
	anItem := anElement headerElement childAt: 1.
	self assert: anItem equals: anElement titleElement.
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> pageToolElement_Hierarchy [
	<gtExample>
	<return: #LePageToolElement>
	| anElement aPage |
	anElement := self basicPageToolElement.
	aPage := self titledPageWithBlockHierachy.
	anElement pageViewModel: aPage asContentUIModel.
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> pageToolElement_Hierarchy_Maximized [
	<gtExample>
	<return: #BrWidgetContainer>
	| anElement aContainer |
	aContainer := BrWidgetContainer new matchParent.
	aContainer states addState: GtPhlowToolDetailState detailed.

	anElement := self pageToolElement_Hierarchy.
	anElement matchParent.

	aContainer addChild: anElement.

	^ aContainer
]

{ #category : #'examples - page - tool' }
LeUIExamples >> pageToolElement_Hierarchy_Normal [
	<gtExample>
	<return: #BrWidgetContainer>
	| anElement aContainer |
	aContainer := BrWidgetContainer new matchParent.
	aContainer states addState: GtPhlowToolDetailState normal.

	anElement := self pageToolElement_Hierarchy.
	anElement matchParent.

	aContainer addChild: anElement.
	^ aContainer
]

{ #category : #'examples - page - tool' }
LeUIExamples >> pageToolElement_Hierarchy_TitleFocused [
	<gtExample>
	<return: #LePageToolElement>
	| anElement |
	anElement := self pageToolElement_Hierarchy.
	anElement contentElement selectTitle.
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> pageToolElement_NoHierarchy [
	<gtExample>
	<return: #LePageToolElement>
	| anElement aPage |
	anElement := self basicPageToolElement.
	aPage := self titledPage.
	anElement pageViewModel: aPage asContentUIModel.
	^ anElement
]

{ #category : #'examples - page - tool' }
LeUIExamples >> scripterOnPageToolElementWithTitleFocused [
	<gtExample>
	<return: #BlScripter>
	| scripter anElement |
	scripter := BlScripter new.
	anElement := self pageToolElement_Hierarchy_TitleFocused.
	scripter element: anElement.

	scripter
		checkStep: [ :s | 
			s
				label: 'Check title element is focused';
				satisfies: [ :element | element contentElement titleElement hasFocus ] ].

	^ scripter
]

{ #category : #'examples - model' }
LeUIExamples >> titledPage [
	<gtExample>
	<return: #LePage>
	^ self database pageBuilder
		title: 'one';
		add
]

{ #category : #'examples - model' }
LeUIExamples >> titledPageWithBlock [
	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := self database pageBuilder
			title: 'one';
			add.
	aPage snippetBuilder
		string: '[[two]]';
		add.
	^ aPage
]

{ #category : #'examples - model' }
LeUIExamples >> titledPageWithBlockHierachy [
	<gtExample>
	<return: #LePage>
	| aPage aSnippetOne aSnippetTwo |
	aPage := self database pageBuilder
			title: 'one';
			add.
	aSnippetOne := aPage snippetBuilder
			string: 'block one > one';
			add.
	aSnippetTwo := aPage snippetBuilder
			string: 'block one > two';
			add.
	aSnippetOne snippetBuilder
		string: 'block one > one > one';
		add.
	aSnippetOne snippetBuilder
		string: 'block one > one > two';
		add.
	aSnippetTwo snippetBuilder
		string: 'block one > two > one';
		add.
	aSnippetTwo snippetBuilder
		string: 'block one > two > two';
		add.
	^ aPage
]

{ #category : #'examples - model' }
LeUIExamples >> titledPageWithPharoCodeHierarchy [
	<gtExample>
	<return: #LePage>
	| aPage aSnippetOne otherSnippets |
	aPage := self database pageBuilder
			title: 'Shared variable a';
			add.
	aSnippetOne := aPage snippetBuilder
			pharo: 'a := Array with: 42';
			add.
	otherSnippets := 50
			timesRepeat: [ aPage snippetBuilder
					pharo: 'a';
					add ].
	^ aPage
]

{ #category : #'examples - model' }
LeUIExamples >> titledPageWithPharoCodeHierarchy_assignments [
	<gtExample>
	<return: #LePage>
	| aPage aNumber |
	aPage := self database pageBuilder
			title: 'Shared variable a';
			add.
	aNumber := 0.
	10
		timesRepeat: [ aNumber := aNumber + 1.
			aPage snippetBuilder
				pharo: 'a := Array with: ' , aNumber asString;
				add.
			aPage snippetBuilder
				pharo: 'a';
				add ].
	^ aPage
]

{ #category : #'examples - model' }
LeUIExamples >> titledPageWithPharoCodeHierarchy_numbers [
	<gtExample>
	<return: #LePage>
	| aPage aNumber |
	aPage := self database pageBuilder
			title: 'Enumerated pharo snippets';
			add.
	aNumber := 0.
	42
		timesRepeat: [ aNumber := aNumber + 1.
			aPage snippetBuilder
				pharo: aNumber asString;
				add ].
	^ aPage
]

{ #category : #'examples - model' }
LeUIExamples >> titledPageWithTextSnippets_numbers [
	<gtExample>
	<return: #LePage>
	| aPage aNumber |
	aPage := self database pageBuilder
			title: 'Enumerated pharo snippets';
			add.
	aNumber := 0.
	42
		timesRepeat: [ aNumber := aNumber + 1.
			aPage snippetBuilder
				string: aNumber asString;
				add ].
	^ aPage
]

{ #category : #'examples - toolbar' }
LeUIExamples >> toolbarWithButton [
	<gtExample>
	<return: #LeToolbarElement>
	| anElement aButton |
	anElement := self basicToolbar.
	aButton := self buttonIcon: BrGlamorousIcons inspect tooltip: 'Inspect'.
	anElement addItem: aButton.
	^ anElement
]

{ #category : #'examples - toolbar' }
LeUIExamples >> toolbarWithTwoButtons [
	<gtExample>
	<return: #LeToolbarElement>
	| anElement aButton |
	anElement := self toolbarWithButton.
	aButton := self buttonIcon: BrGlamorousIcons browse tooltip: 'Browse'.
	anElement addItem: aButton.
	^ anElement
]

{ #category : #'examples - toolbar' }
LeUIExamples >> toolbarWithTwoButtonsAndFixedSeparator [
	<gtExample>
	<return: #LeToolbarElement>
	| anElement aButton |
	anElement := self toolbarWithButton.
	anElement addFixedSeparator.
	aButton := self buttonIcon: BrGlamorousIcons browse tooltip: 'Browse'.
	anElement addItem: aButton.
	^ anElement
]

{ #category : #'examples - model' }
LeUIExamples >> untitledPage [
	<gtExample>
	<return: #LePage>
	^ self database pageBuilder addOnlyAfterSettingTitle
]

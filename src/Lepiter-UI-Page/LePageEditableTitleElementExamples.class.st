Class {
	#name : #LePageEditableTitleElementExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Page-Examples'
}

{ #category : #'examples - page - editable title' }
LePageEditableTitleElementExamples >> basicPageEditableTitleElement [
	<gtExample>
	<return: #LePageEditableTitleElement>
	| anElement |
	anElement := LePageEditableTitleElement new.
	self assert: anElement hasPage not.
	^ anElement
]

{ #category : #'private - instance creation' }
LePageEditableTitleElementExamples >> database [
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

{ #category : #'private - instance creation' }
LePageEditableTitleElementExamples >> databaseWithPageAAndLinkToPageB [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self database.
	(aDatabase pageBuilder
		title: 'a';
		add) snippetBuilder
		string: '[[b]]';
		add.
	^ aDatabase
]

{ #category : #'private - instance creation' }
LePageEditableTitleElementExamples >> databaseWithTwoPagesAndTwoDailyNotes [
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

{ #category : #'examples - page - editable title' }
LePageEditableTitleElementExamples >> pageEditableTitleElement_ApprovedTitleRename [
	<gtExample>
	<return: #LePageEditableTitleElement>
	| anElement aPage aDatabase |
	anElement := self basicPageEditableTitleElement.
	aDatabase := self databaseWithTwoPagesAndTwoDailyNotes.
	aPage := aDatabase pageBuilder
			title: 'one';
			ensure.
	anElement pageViewModel: aPage asContentUIModel.
	anElement titleElement text: 'three'.
	anElement acceptPageTitle.
	self assert: anElement titleElement text asString equals: aPage title.
	self assert: anElement titleElement text asString equals: 'three'.
	^ anElement
]

{ #category : #'examples - page - editable title' }
LePageEditableTitleElementExamples >> pageEditableTitleElement_DisapprovedTitleRename [
	<gtExample>
	<return: #LePageEditableTitleElement>
	| anElement aPage aDatabase |
	anElement := self basicPageEditableTitleElement.
	aDatabase := self databaseWithTwoPagesAndTwoDailyNotes.
	aPage := aDatabase pageBuilder
			title: 'one';
			ensure.
	anElement pageViewModel: aPage asContentUIModel.
	anElement titleElement text: 'two'.
	anElement acceptPageTitle.
	self assert: anElement titleElement text asString equals: 'two'.
	self assert: aPage title equals: 'one'.
	^ anElement
]

{ #category : #'examples - page - editable title' }
LePageEditableTitleElementExamples >> pageEditableTitleElement_LongTitle [
	<gtExample>
	<return: #LePageEditableTitleElement>
	| anElement aPage aScripter |
	anElement := self basicPageEditableTitleElement.
	aPage := self titledPage.
	aScripter := BlScripter new element: anElement.

	aPage updateTitle: (String loremIpsum: 108).

	aScripter
		doStep: [ :s | 
			s
				label: 'Reset page view model';
				block: [ anElement pageViewModel: aPage asContentUIModel ] ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that page title changes';
				satisfies: [ :element | element titleElement text asString = aPage title ] ].
	^ anElement
]

{ #category : #'examples - page - editable title' }
LePageEditableTitleElementExamples >> pageEditableTitleElement_RenamePageBToC [
	<gtExample>
	<return: #LePageEditableTitleElement>
	| anElement aPage aDatabase |
	anElement := self basicPageEditableTitleElement.
	aDatabase := self databaseWithPageAAndLinkToPageB.
	aPage := aDatabase pageBuilder
			title: 'b';
			add.

	anElement pageViewModel: aPage asContentUIModel.
	anElement titleElement text: 'c'.
	anElement acceptPageTitle.
	self assert: aPage database equals: aDatabase.
	self assert: anElement titleElement text asString equals: aPage title.
	self assert: anElement titleElement text asString equals: 'c'.
	^ anElement
]

{ #category : #'examples - page - editable title' }
LePageEditableTitleElementExamples >> pageEditableTitleElement_TitledPage [
	<gtExample>
	<return: #LePageEditableTitleElement>
	| anElement aPage aScripter |
	anElement := self basicPageEditableTitleElement.
	aPage := self titledPage.
	aScripter := BlScripter new element: anElement.

	aScripter
		doStep: [ :s | 
			s
				label: 'Reset page view model';
				block: [ anElement pageViewModel: aPage asContentUIModel ] ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that page title changes';
				satisfies: [ :element | element titleElement text asString = aPage title ] ].
	^ anElement
]

{ #category : #'examples - page - editable title' }
LePageEditableTitleElementExamples >> pageEditableTitleElement_UntitledPage [
	<gtExample>
	<return: #LePageEditableTitleElement>
	| anElement aPage |
	anElement := self basicPageEditableTitleElement.
	aPage := self untitledPage.
	anElement pageViewModel: aPage asContentUIModel.
	self assert: anElement titleElement text asString equals: ''.
	^ anElement
]

{ #category : #'private - instance creation' }
LePageEditableTitleElementExamples >> titledPage [
	<gtExample>
	<return: #LePage>
	^ self database pageBuilder
		title: 'one';
		add
]

{ #category : #'private - instance creation' }
LePageEditableTitleElementExamples >> titledPageWithBlockHierachy [
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

{ #category : #'private - instance creation' }
LePageEditableTitleElementExamples >> untitledPage [
	<gtExample>
	<return: #LePage>
	^ self database pageBuilder addOnlyAfterSettingTitle
]

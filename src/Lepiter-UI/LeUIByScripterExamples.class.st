"
I exemplify lepiter using {{gtClass:BlScripter}}.
I provide basic setups and support methods to simplify {{gtClass:LePageToolElement}} and {{gtClass:LeSnippetElement}} (sub-)instances.
#Add Snippet Support
The following method adds a snippet of a given name: {{gtMethod:LeUIByScripterExamples class>>#addSnippetNamed:step: | label=#selector}}.
#Initial Page
The following example displays a default (empty) page: {{gtExample:LeUIByScripterExamples>>#emptyPageElement}}

"
Class {
	#name : #LeUIByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Lepiter-UI-Examples'
}

{ #category : #'examples - support' }
LeUIByScripterExamples class >> addNewSnippetShortcut [
	<gtExample>
	^ BlKeyCombination builder
		shift;
		primary;
		key: BlKeyboardKey return;
		build
]

{ #category : #'examples - support' }
LeUIByScripterExamples class >> addSnippetNamed: aSnippetName step: aParentStep [
	"I add a new snippet to a page as a second page child.
	I assume that the there is a {{gtClass:LePageToolElement}} instance.
	I assume that the lepiter database has at least one snippet.
	I assume that the first page snippet is a text snippet."

	<gtExample>
	| aSnippetsCount |
	aParentStep
		substeps: ('Add new {1} snippet' format: {aSnippetName})
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Find out the number of snippets';
						block: [ :aPageElement | aSnippetsCount := aPageElement pageViewModel pageModel children size ];
						onBreadthFirstChildOfClass: LePageToolElement ].

			aStep shortcut
				label: 'Open add snippet spotter';
				combination: self addNewSnippetShortcut;
				in: [ :theStep | self targetPageInfiniteElement: theStep ];
				onChildAt: 1;
				id: GtSourceCoderEditorId;
				play.

			aStep
				typeStep: [ :s | 
					s
						text: aSnippetName;
						onSpaceRoot;
						onBreadthFirstChildOfClass: GtStreamingSpotterSearchField ].

			aStep
				keyPressStep: [ :s | 
					s
						label: ('Insert {1} snippet' format: {aSnippetName});
						key: BlKeyboardKey return ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Page has two snippets';
						value: [ :aPageElement | aPageElement pageViewModel pageModel children size ]
							equals: [ aSnippetsCount + 1 ];
						onBreadthFirstChildOfClass: LePageToolElement ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert picture widget is inserted';
						value: [ :anInfiniteElement | anInfiniteElement childrenCount ]
							equals: [ 2 ];
						in: [ :theStep | self targetPageInfiniteElement: theStep ] ] ]
]

{ #category : #utilities }
LeUIByScripterExamples class >> inExample: aBlock [
	^ aBlock cull: self new
]

{ #category : #'examples - support' }
LeUIByScripterExamples class >> targetPageInfiniteElement: aStep [
	aStep
		onBreadthFirstChildOfClass: LePageToolElement;
		id: #content;
		id: LePageSnippetsTreeElementId;
		id: #scrollable
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> addEmptyPageNamed: aPageTitle into: aDatabase [
	<gtExample>
	| aPage aPageCount aLinkCount |
	aPageCount := aDatabase pages size.
	aLinkCount := aDatabase explicitLinks size.

	aPage := aDatabase pageBuilder
			title: aPageTitle;
			add.

	self assert: aDatabase pages size equals: 1 + aPageCount.
	self assert: aDatabase explicitLinks size equals: aLinkCount.

	self assert: (aDatabase pageNamed: aPageTitle) == aPage.

	^ aPage
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> addEmptyPageOneInto: database [
	<gtExample>
	^ self addEmptyPageNamed: self pageOneTitle into: database
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> addEmptyPageTwoInto: database [
	<gtExample>
	^ self addEmptyPageNamed: self pageTwoTitle into: database
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> databaseOneIn: aLogicalDatabase [
	"Find Database One"

	<gtExample>
	| aDatabase |
	aDatabase := aLogicalDatabase databaseNamed: self databaseOneName.

	self assert: aDatabase isNotNil.
	self assert: aDatabase databaseName equals: self databaseOneName.

	^ aDatabase
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> databaseOneName [
	^ 'Database One'
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> databaseTwoIn: aLogicalDatabase [
	"Find Database Two"

	<gtExample>
	| aDatabase |
	aDatabase := aLogicalDatabase databaseNamed: self databaseTwoName.

	self assert: aDatabase isNotNil.
	self assert: aDatabase databaseName equals: self databaseTwoName.

	^ aDatabase
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> databaseTwoName [
	^ 'Database Two'
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> databaseWithPageOne [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self emptyDatabase.

	self addEmptyPageOneInto: database.

	^ database
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> databaseWithPageTwo [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self emptyDatabase.

	self addEmptyPageTwoInto: database.

	^ database
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> emptyDatabase [
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

{ #category : #'examples - ui' }
LeUIByScripterExamples >> emptyPageElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			pageOneElementUsingDatabaseModel: [ self databaseWithPageOne ]
			extra: [ :anElement | anElement ].

	^ aScripter
]

{ #category : #'examples - ui' }
LeUIByScripterExamples >> emptyPageElementInPager [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			pageOneElementUsingDatabaseModel: [ self databaseWithPageOne ]
			extra: [ :anElement | GtPager createWrappedOn: anElement ].

	^ aScripter
]

{ #category : #'examples - ui' }
LeUIByScripterExamples >> emptyPageElementInPagerMaximized [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			pageOneElementUsingDatabaseModel: [ self databaseWithPageOne ]
			extra: [ :anElement | (GtPager createWrappedOn: anElement) maximized ].

	^ aScripter
]

{ #category : #'examples - ui' }
LeUIByScripterExamples >> logicalDatabasePageOneElementInPager [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			pageOneElementUsingDatabaseModel: [ self logicalDatabaseWithEmptyPage ]
			extra: [ :anElement | GtPager createWrappedOn: anElement ].

	^ aScripter
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> logicalDatabaseWithEmptyPage [
	<gtExample>
	<return: #LeLogicalDatabase>
	| database |
	database := self logicalDatabaseWithTwoEmptyDatabases.

	self addEmptyPageOneInto: database primaryDB.
	self assert: database pages size equals: 1.
	self
		assert: (database pageNamed: self pageOneTitle)
				== (database primaryDB pageNamed: self pageOneTitle).

	^ database
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> logicalDatabaseWithTwoEmptyDatabases [
	<gtExample>
	<return: #LeLogicalDatabase>
	| databaseOne databaseTwo database |
	databaseOne := self emptyDatabase.
	databaseTwo := self emptyDatabase.

	databaseOne databaseName: self databaseOneName.
	databaseTwo databaseName: self databaseTwoName.

	self assert: databaseOne databaseName equals: self databaseOneName.
	self assert: databaseTwo databaseName equals: self databaseTwoName.
	self assert: databaseOne uuidString isNotNil.
	self assert: databaseOne uuidString isNotEmpty.
	self assert: databaseTwo uuidString isNotNil.
	self assert: databaseTwo uuidString isNotEmpty.

	database := LeLogicalDatabase primaryDB: databaseOne.
	database addDB: databaseTwo.

	self assert: database databases size equals: 2.
	self assert: database pages size equals: 0.

	^ database
]

{ #category : #'examples - elements' }
LeUIByScripterExamples >> pageInPager: aPage [
	<gtExample>
	| aPageElement |
	aPageElement := aPage asLepiterPagePhlowTool 
		asElementDo: [ :anElement | 
			GtPager createWrappedOn: anElement ].

	^ aPageElement
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> pageOne [
	<gtExample>
	<return: #LePage>
	| aDatabase aPageOne |
	aDatabase := self databaseWithPageOne.
	aPageOne := self pageOneIn: aDatabase.

	^ aPageOne
]

{ #category : #'examples - elements' }
LeUIByScripterExamples >> pageOneElementInPager [
	<gtExample>
	<return: #GtPager>
	| aDatabase aPageOne aPageElement |
	aDatabase := self databaseWithPageOne.
	aPageOne := self pageOneIn: aDatabase.
	aPageElement := self pageInPager: aPageOne.

	^ aPageElement
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> pageOneElementUsingDatabaseModel: aModelBlock extra: anElementBlock [
	"I open a page element using #asLepiterPagePhlowTool
	aModelBlock is evaluated to get a database instance (that includes Pate One).
	anElementBlock is evaluated to, for example, wrap the page element into a pager."

	<gtExample>
	| aScripter |
	aScripter := self scripter.

	aScripter
		substeps: 'Prepare database'
		do: [ :aStep | 
			self
				scripter: aStep
				withModel: aModelBlock
				element: [ :aDatabase | 
					(self pageOneIn: aDatabase) asLepiterPagePhlowTool
						asElementDo: (anElementBlock ifNil: [ [ :anElement | anElement ] ]) ].

			aStep
				assertStep: [ :s | 
					s
						label: self pageOneTitle , ' element has one snippet widget';
						value: [ :anInfiniteElement | anInfiniteElement children size ]
							equals: [ 1 ];
						in: [ :theStep | self class targetPageInfiniteElement: theStep ] ].

			aStep
				assertStep: [ :s | 
					s
						label: self pageOneTitle , ' has one snippet';
						value: [ :aDatabase | (self pageOneIn: aDatabase) children size ]
							equals: [ 1 ];
						onModel ] ].

	^ aScripter
]

{ #category : #'examples - removed page' }
LeUIByScripterExamples >> pageOneFromDatabaseWithOnlyOnePage [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ LeModelExamples new pageOneFromDatabaseWithOnlyOnePage ]
			element: [ :aPageHolder | 
				GtPager
					createWrappedOn: (aPageHolder page asLepiterPagePhlowTool asElementDo: [ :anElement | anElement ]) ].

	aScripter assert
		label: 'Assert page snippet tree widget exists';
		// LePageSnippetsTreeElementId;
		exists;
		play.

	^ aScripter
]

{ #category : #'examples - removed page' }
LeUIByScripterExamples >> pageOneFromDatabaseWithOnlyOnePage_RemoveLastPage [
	"See https://github.com/feenkcom/gtoolkit/issues/4186"

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageOneFromDatabaseWithOnlyOnePage.

	aScripter click
		label: 'Click on the remove page button';
		// LePageRemoveActionId;
		play.
	aScripter click
		label: 'Confirm page removal';
		onSpaceRoot;
		// LePageConfirmationActionId;
		play.

	aScripter assert
		label: 'Assert page snippet tree widget does not exist';
		// LePageSnippetsTreeElementId;
		notExists;
		play.

	^ aScripter
]

{ #category : #'examples - removed page' }
LeUIByScripterExamples >> pageOneFromDatabaseWithOnlyOnePage_RemoveLastPage_CheckSidebar [
	"See https://github.com/feenkcom/gtoolkit/issues/4186"

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageOneFromDatabaseWithOnlyOnePage_RemoveLastPage.

	aScripter click
		label: 'Maximize page';
		// GtPagerMaximizeButtonElementId;
		play.

	aScripter assert
		// LeDatabaseSidebarGroupedListElement;
		// #scrollable;
		value: [ :anInfiniteElement | anInfiniteElement childrenCount ] equals: 0;
		label: 'Assert sidebar has no pages';
		play.

	^ aScripter
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> pageOneIn: aDatabase [
	"Find Page One"

	<gtExample>
	| aPage |
	aPage := aDatabase pageNamed: self pageOneTitle.

	self assert: aPage isNotNil.
	self assert: aPage title equals: self pageOneTitle.

	^ aPage
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> pageOneTitle [
	^ 'Page One'
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> pageTwoIn: aDatabase [
	"Find Page Two"

	<gtExample>
	| aPage |
	aPage := aDatabase pageNamed: self pageTwoTitle.

	self assert: aPage isNotNil.
	self assert: aPage title equals: self pageTwoTitle.

	^ aPage
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> pageTwoTitle [
	^ 'Page Two'
]

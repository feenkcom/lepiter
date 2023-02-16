"
I exemplify lepiter using {{gtClass:BlScripter}}.
I provide basic setups and support methods to simplify {{gtClass:LePageToolElement}} and {{gtClass:LeSnippetElement}} (sub-)instances.
#Add Snippet Support
The following method adds a snippet of a given name: {{gtMethod:LeUIByScripterExamples>>#addSnippetNamed:step: | label=#selector}}.
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
LeUIByScripterExamples >> addNewSnippetShortcut [
	<gtExample>
	^ BlKeyCombination builder
		shift;
		primary;
		key: BlKeyboardKey return;
		build
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> addSnippetNamed: aSnippetName step: aParentStep [ 
	"I add a new snippet to a page as a second page child.
	I assume that the there is a {{gtClass:LePageToolElement}} instance.
	I assume that the lepiter database has at least one snippet.
	I assume that the first page snippet is a text snippet."
	<gtExample>
	
	| aSnippetsCount |
	aParentStep substeps: ('Add new {1} snippet' format: { aSnippetName }) do: [ :aStep |
	
		aStep do
			label: 'Find out the number of snippets';
			block: [ :aPageElement | aSnippetsCount := aPageElement pageViewModel pageModel children size ];
			onBreadthFirstChildOfClass: LePageToolElement;
			play.
			
		aStep shortcut
			label: 'Open add snippet spotter';
			combination: self addNewSnippetShortcut;
			in: [ :theStep | self targetPageInfiniteElement: theStep ];
			onChildAt: 1;
			id: GtSourceCoderEditorId;
			play.
			
		aStep type 
			text: aSnippetName;
			onSpaceRoot;
			onBreadthFirstChildOfClass: GtStreamingSpotterSearchField;
			play.
			
		aStep keyClick 
			label: ('Insert {1} snippet' format: { aSnippetName });
			key: BlKeyboardKey return;
			play.
			
		aStep assert 
			label: 'Page has two snippets';
			value: [ :aPageElement | aPageElement pageViewModel pageModel children size ] 
				equals: [ aSnippetsCount + 1 ];
			onBreadthFirstChildOfClass: LePageToolElement;
			play.
		
		aStep assert
			label: 'Assert picture widget is inserted';
			value: [ :anInfiniteElement | anInfiniteElement childrenCount  ] equals: [ 2 ];
			in: [ :theStep | self targetPageInfiniteElement: theStep ];
			play.
	]
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> databaseWithEmptyPage [
	<gtExample>
	| database page |
	database := self emptyDatabase.
	
	page := database pageBuilder title: self pageOneTitle; add.
	
	self assert: database pages size equals: 1.
	self assert: database explicitLinks size equals: 0.
	
	self assert: (database pageNamed: self pageOneTitle) == page.
	
	^ database 
]

{ #category : #'examples - database' }
LeUIByScripterExamples >> emptyDatabase [
	<gtExample>
	| database folderReference localStore  |
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
	| aScripter |
	aScripter := self scripter.


	aScripter
		substeps: 'Prepare database'
		do: [ :aStep | 
			self
				scripter: aStep
				withModel: [ self databaseWithEmptyPage ]
				element: [ :aDatabase | 
					(self pageOneIn: aDatabase) asLepiterPagePhlowTool
						asElementDo: [ :anElement | anElement ] ].

			aStep assert
				label: self pageOneTitle , ' element has one snippet widget';
				value: [ :anInfiniteElement | anInfiniteElement children size ]
					equals: [ 1 ];
				in: [ :theStep | self targetPageInfiniteElement: theStep ];
				play.

			aStep assert
				label: self pageOneTitle , ' has one snippet';
				value: [ :aDatabase | (self pageOneIn: aDatabase) children size ]
					equals: [ 1 ];
				onModel;
				play ].

	^ aScripter
]

{ #category : #'examples - support' }
LeUIByScripterExamples >> pageOneIn: aDatabase [
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
LeUIByScripterExamples >> targetPageInfiniteElement: aStep [
	aStep
		onBreadthFirstChildOfClass: LePageToolElement;
		id: #content;
		id: #snippetsTree;
		id: #scrollable
]

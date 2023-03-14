Class {
	#name : #LePageListByScripterExamples,
	#superclass : #LeUIByScripterExamples,
	#category : #'Lepiter-UI-Examples'
}

{ #category : #'examples - database - page list' }
LePageListByScripterExamples >> basicDatabasePageListElement [
	<gtExample>
	| anElement |

	anElement := LeDatabaseSidebarListElement new selectionBlock: [:aNavigationModel | 
				aNavigationModel hasDatabase
					ifTrue: [ aNavigationModel database pagesByDateToShow
							collect: [ :aPage | LePageTreeNodeModel forPage: aPage ] ]
					ifFalse: [ {} ]].

	self assert: anElement hasDatabase not.
	self assert: anElement hasSelection not.

	^ anElement
]

{ #category : #'examples - database - page list' }
LePageListByScripterExamples >> databasePageListElement_DailyNotes [
	<gtExample>
	| aScripter |
	
	aScripter := self 
		scripterWithModel: [ LeUIExamples new databaseWithTwoPagesAndTwoDailyNotes ]
		element: [ :aDatabase | self basicDatabasePageListElement navigationModel: (self simpleNavigationModelWith: aDatabase); selectionBlock: [:aNavigationModel | aNavigationModel database dailyNotes  ]  ].

	aScripter wait forEmptySpaceTaskQueue; play.
	
	aScripter assert
		value: [ :anElement | anElement treeElement viewModel itemCount ] 
			equals: [ :anElement | anElement database dailyNotes size ];
		play.

	^ aScripter
]

{ #category : #'examples - database - page list' }
LePageListByScripterExamples >> databasePageListElement_Pages [
	<gtExample>
	| aScripter |
	
	aScripter := self 
		scripterWithModel: [ LeUIExamples new databaseWithTwoPagesAndTwoDailyNotes ]
		element: [ :aDatabase | self basicDatabasePageListElement navigationModel: (self simpleNavigationModelWith: aDatabase) ].

	aScripter wait forEmptySpaceTaskQueue; play.
	
	aScripter assert
		value: [ :anElement | anElement treeElement viewModel itemCount ] 
			equals: [ :anElement | anElement database pages size ];
		play.

	^ aScripter
]

{ #category : #'examples - database - page list' }
LePageListByScripterExamples >> databasePageListElement_Pages_AddNewPage [
	<gtExample>
	| aScripter aPage |
	aScripter := self databasePageListElement_Pages.

	aScripter do
		action: [ :aDatabase | 
			aPage := aDatabase pageBuilder
					title: 'newly added';
					add ];
		onModel;
		play.

	aScripter wait
		forEmptySpaceTaskQueue;
		play.

	aScripter assert
		value: [ :anElement | anElement treeElement viewModel itemCount ]
			equals: [ :anElement | anElement database pages size ];
		play.

	aScripter assert
		value: [ :anElement | anElement treeElement viewModel root childrenValues first page ]
			equals: [ aPage ];
		play.

	^ aScripter
]

{ #category : #'examples - database - page list' }
LePageListByScripterExamples >> databasePageListElement_Pages_RemovePageTwo [
	<gtExample>
	| aScripter aPage anInitialPageCount |

	aScripter := self databasePageListElement_Pages.
	
	aScripter do
		action: [ :aDatabase | anInitialPageCount := aDatabase pages size ];
		onModel;
		play.
	
	aScripter do
		action: [ :aDatabase |
			aPage := aDatabase pageNamed: 'two'.
			aDatabase removePage: aPage ];
		onModel;
		play.

	aScripter wait forEmptySpaceTaskQueue; play.
	
	aScripter assert
		value: [ :anElement | anElement treeElement viewModel itemCount ] 
			equals: [ :anElement | anElement database pages size ];
		play.
	
	aScripter assert
		value: [ :anElement | anElement treeElement viewModel itemCount ] 
			equals: [ anInitialPageCount - 1 ];
		play.
		
	aScripter assert
		value: [ :anElement | anElement treeElement viewModel root childrenValues first page ] 
			equals: [ :anElement | anElement database sortedPages first];
		play.

	^ aScripter
]

{ #category : #'examples - database - page list' }
LePageListByScripterExamples >> databasePageListElement_Pages_Selection [
	<gtExample>
	<noTest>
	| anElement |
	
	anElement := self databasePageListElement_Pages.
	anElement selection: anElement database sortedPages second.

	self assert: anElement listElement selectedIndices first equals: 2.

	^ anElement
]

{ #category : #'examples - database - page list' }
LePageListByScripterExamples >> simpleNavigationModelWith: aDatabase [ 
	^ LeDatabaseNavigationModel new database: aDatabase
]

Class {
	#name : #LeUIByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : 'Lepiter-UI-Examples'
}

{ #category : #'examples - database - page list' }
LeUIByScripterExamples >> basicDatabasePageListElement [
	<gtExample>
	| anElement |

	anElement := LeDatabasePageListElement new.

	self assert: anElement hasDatabase not.
	self assert: anElement selection content equals: LePage null.

	^ anElement
]

{ #category : #'examples - database - page list' }
LeUIByScripterExamples >> databasePageListElement_DailyNotes [
	<gtExample>
	| aScripter |
	
	aScripter := self 
		scripterWithModel: [ LeUIExamples new databaseWithTwoPagesAndTwoDailyNotes ]
		element: [ :aDatabase | self basicDatabasePageListElement showDailyNotes databaseViewModel: aDatabase asContentUIModel ].

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		value: [ :anElement | anElement listElement items size ] equals: [ :anElement | anElement database dailyNotes size ].

	^ aScripter
]

{ #category : #'examples - database - page list' }
LeUIByScripterExamples >> databasePageListElement_Pages [
	<gtExample>
	| aScripter |
	
	aScripter := self 
		scripterWithModel: [ LeUIExamples new databaseWithTwoPagesAndTwoDailyNotes ]
		element: [ :aDatabase | self basicDatabasePageListElement databaseViewModel: aDatabase asContentUIModel ].

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		value: [ :anElement | anElement listElement items size ] equals: [ :anElement | anElement database pages size ].

	^ aScripter syncContinue
]

{ #category : #'examples - database - page list' }
LeUIByScripterExamples >> databasePageListElement_Pages_AddNewPage [
	<gtExample>
	| aScripter aPage |

	aScripter := self databasePageListElement_Pages.
	
	aScripter do
		action: [ :aDatabase | aPage := aDatabase pageBuilder title: 'newly added'; add. ];
		onModel.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		value: [ :anElement | anElement listElement items size ] equals: [ :anElement | anElement database pages size ].
		
	aScripter check
		value: [ :anElement | anElement listElement items first pageModel ] equals: [ aPage ].

	^ aScripter syncContinue
]

{ #category : #'examples - database - page list' }
LeUIByScripterExamples >> databasePageListElement_Pages_RemovePageTwo [
	<gtExample>
	| aScripter aPage anInitialPageCount |

	aScripter := self databasePageListElement_Pages.
	
	aScripter do
		action: [ :aDatabase | anInitialPageCount := aDatabase pages size ];
		onModel.
	
	aScripter do
		action: [ :aDatabase |
			aPage := aDatabase pageNamed: 'two'.
			aDatabase removePage: aPage ];
		onModel.

	aScripter wait forEmptySpaceTaskQueue.
	
	aScripter check
		value: [ :anElement | anElement listElement items size ] equals: [ :anElement | anElement database pages size ];
		value: [ :anElement | anElement listElement items size ] equals: [ anInitialPageCount - 1 ].
		
	aScripter check
		value: [ :anElement | anElement listElement items first pageModel ] equals: [ :anElement | anElement database sortedPages first].

	^ aScripter syncContinue
]

{ #category : #'examples - database - page list' }
LeUIByScripterExamples >> databasePageListElement_Pages_Selection [
	<gtExample>
	<noTest>
	| anElement |
	
	anElement := self databasePageListElement_Pages.
	anElement selection: anElement database sortedPages second.

	self assert: anElement listElement selectedIndices first equals: 2.

	^ anElement
]

Class {
	#name : #LeDatabaseByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Lepiter-UI-Examples'
}

{ #category : #accessing }
LeDatabaseByScripterExamples >> databaseWithTwoPages [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := LeUIByScripterExamples new emptyDatabase.

	LeUIByScripterExamples new addEmptyPageOneInto: database.
	LeUIByScripterExamples new addEmptyPageTwoInto: database.

	^ database
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterOnDatabaseTool [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self
			scripterWithModel: [ :aTarget :theScripter | self databaseWithTwoPages ]
			element: [ :aDatabase | (self toolFor: aDatabase) asElement createInPager maximized ].
	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterOnDatabaseToolWithToC [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := GtWorldByScripterExamples new tabElementInScripter.

	scripter
		doStep: [ :s | 
			s
				label: 'Show Coder space';
				block: [ :aTabElement | 
					| aStencil |
					aStencil := [ (self toolFor: LeUIExamples new databaseWithTableOfContents)
							asElement createInPager maximized ] asStencil.
					BlSpace new
						icon: BrGlamorousVectorIcons transparent;
						title: 'Lepiter Page';
						addChild: aStencil asElement;
						withSceneDriller;
						showFrom: aTabElement ] ].
	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterOnDatabaseToolWithToCDuplicatePage [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self
			scripterWithModel: [ :aTarget :theScripter | LeUIExamples new databaseWithTableOfContentsDuplicatePage ]
			element: [ :aDatabase | (self toolFor: aDatabase) asElement createInPager maximized ].
	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithLinkClicked [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self scripterWithToCNavigated.

	scripter
		clickStep: [ :s | 
			s
				label: 'Click link container';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Click link';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check that page was spawned';
				id: #content;
				onChildAt: 1;
				onChildAt: 1;
				satisfies: [ :aPager | aPager pages size = 2 ] ].

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithLinkPrimaryClicked [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self scripterWithToCNavigated.

	scripter
		clickStep: [ :s | 
			s
				label: 'Click link container';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Click link';
				modifiers: BlKeyModifiers primary;
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check that tab was spawned';
				satisfies: [ :aWorld | aWorld tabs tabs size = 3 ] ].

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithOtherPageNavigated [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self scripterOnDatabaseTool.

	scripter
		checkStep: [ :s | 
			s
				label: 'Ensure page is correct';
				id: #content;
				id: #title;
				value: [ :anElement | anElement text asString ] equals: 'Page One' ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Select other page';
				id: #sidebar;
				id: #content;
				id: #title ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Ensure page has changed';
				id: #content;
				id: #title;
				value: [ :anElement | anElement text asString ] equals: 'Page Two' ].

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithToCDuplicateNavigated [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self scripterOnDatabaseToolWithToCDuplicatePage.

	scripter
		checkStep: [ :s | 
			s
				label: 'Ensure page is correct';
				id: #content;
				id: #title;
				value: [ :anElement | anElement text asString ]
					equals: scripter model pages last title ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Select other page';
				id: #sidebar;
				id: #content;
				id: #scrollable;
				onChildAt: scripter model pages size ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Ensure page has changed';
				id: #content;
				id: #title;
				value: [ :anElement | anElement text asString ] equals: 'Summary' ].

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithToCNavigated [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self scripterOnDatabaseToolWithToC.

	scripter
		checkStep: [ :s | 
			s
				label: 'Ensure page is correct';
				id: #content;
				id: #title;
				value: [ :anElement | anElement text asString ] equals: 'Charts' ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Select other page';
				id: #sidebar;
				id: #content;
				id: #title ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Ensure page has changed';
				id: #content;
				id: #title;
				value: [ :anElement | anElement text asString ]
					equals: 'Visualizing with Glamorous Toolkit' ].

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithToCNavigatedAndOtherTabClicked [
	<gtExample>
	<return: #BlScripter>
	| scripter check |
	scripter := self scripterWithToCNavigated.

	scripter
		clickStep: [ :s | 
			s
				label: 'Select other tab';
				id: #sidebar;
				id: #content;
				id: #header;
				id: #tabbar;
				onChildAt: 2 ].	"somehow the selection is only picked up on re-render"
	scripter
		clickStep: [ :s | 
			s
				label: 'Select first tab';
				id: #sidebar;
				id: #content;
				id: #header;
				id: #tabbar;
				onChildAt: 1 ].

	scripter
		clickStep: [ :s | 
			s
				label: 'Select other tab again';
				id: #sidebar;
				id: #content;
				id: #header;
				id: #tabbar;
				onChildAt: 2 ].

	scripter
		checkStep: [ :s | 
			s
				label: 'Check that element is selected';
				id: #sidebar;
				id: #content;
				id: #content;
				id: #list;
				satisfies: [ :aList | 
					aList
						selectedEntityDo: [ :aGroup | check := aGroup itemObject title = 'Visualizing with Glamorous Toolkit' ].
					check ] ].

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> toolFor: aDatabase [
	^ LePagePhlowTool new page: aDatabase pages last
]

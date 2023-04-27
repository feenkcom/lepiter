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
	| database |
	database := LeUIByScripterExamples new emptyDatabase.

	LeUIByScripterExamples new addEmptyPageOneInto: database.
	LeUIByScripterExamples new addEmptyPageTwoInto: database.

	^ database
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterOnDatabaseTool [
	<gtExample>
	| scripter |
	scripter := self
			scripterWithModel: [ :aTarget :theScripter | self databaseWithTwoPages ]
			element: [ :aDatabase | (self toolFor: aDatabase) asElement createInPager maximized ].
	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterOnDatabaseToolWithToC [
	<gtExample>
	| scripter |
	scripter := GtWorldByScripterExamples new tabElementInScripter.

	scripter do
		label: 'Show Coder space';
		block: [ :aTabElement | 
			| aStencil |
			aStencil := [ (self toolFor: LeUIExamples new databaseWithTableOfContents)
					asElement createInPager maximized ] asStencil.

			GtWorldUtility
				showSpaceWithIcon: BrGlamorousVectorIcons transparent
				title: 'Lepiter Page'
				with: aStencil
				from: aTabElement ];
		play.
	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterOnDatabaseToolWithToCDuplicatePage [
	<gtExample>
	| scripter |
	scripter := self
			scripterWithModel: [ :aTarget :theScripter | LeUIExamples new databaseWithTableOfContentsDuplicatePage ]
			element: [ :aDatabase | (self toolFor: aDatabase) asElement createInPager maximized ].
	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithLinkClicked [
	<gtExample>
	| scripter |
	scripter := self scripterWithToCNavigated.

	scripter click
		label: 'Click link container';
		id: #content;
		id: #scrollable;
		onChildAt: 1;
		play.

	scripter click
		label: 'Click link';
		id: #content;
		id: #scrollable;
		onChildAt: 1;
		play.

	scripter check
		label: 'Check that page was spawned';
		id: #content;
		onChildAt: 1;
		onChildAt: 1;
		satisfies: [ :aPager | aPager pages size = 2 ];
		play.

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithLinkPrimaryClicked [
	<gtExample>
	| scripter |
	scripter := self scripterWithToCNavigated.

	scripter click
		label: 'Click link container';
		id: #content;
		id: #scrollable;
		onChildAt: 1;
		play.

	scripter click
		label: 'Click link';
		modifiers: BlKeyModifiers primary;
		id: #content;
		id: #scrollable;
		onChildAt: 1;
		play.

	scripter check
		label: 'Check that tab was spawned';
		satisfies: [ :aWorld | aWorld tabs tabs size = 3 ];
		play.

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithOtherPageNavigated [
	<gtExample>
	| scripter |
	scripter := self scripterOnDatabaseTool.

	scripter check
		label: 'Ensure page is correct';
		id: #content;
		id: #title;
		value: [ :anElement | anElement text asString ] equals: 'Page One';
		play.

	scripter click
		label: 'Select other page';
		id: #sidebar;
		id: #content;
		id: #title;
		play.

	scripter check
		label: 'Ensure page has changed';
		id: #content;
		id: #title;
		value: [ :anElement | anElement text asString ] equals: 'Page Two';
		play.

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithToCDuplicateNavigated [
	<gtExample>
	| scripter |
	scripter := self scripterOnDatabaseToolWithToCDuplicatePage.

	scripter check
		label: 'Ensure page is correct';
		id: #content;
		id: #title;
		value: [ :anElement | anElement text asString ] equals: scripter model pages last title;
		play.

	scripter click
		label: 'Select other page';
		id: #sidebar;
		id: #content;
		id: #scrollable;
		onChildAt: scripter model pages size;
		play.

	scripter check
		label: 'Ensure page has changed';
		id: #content;
		id: #title;
		value: [ :anElement | anElement text asString ] equals: 'Summary';
		play.

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithToCNavigated [
	<gtExample>
	| scripter |
	scripter := self scripterOnDatabaseToolWithToC.

	scripter check
		label: 'Ensure page is correct';
		id: #content;
		id: #title;
		value: [ :anElement | anElement text asString ] equals: 'Charts';
		play.

	scripter click
		label: 'Select other page';
		id: #sidebar;
		id: #content;
		id: #title;
		play.

	scripter check
		label: 'Ensure page has changed';
		id: #content;
		id: #title;
		value: [ :anElement | anElement text asString ] equals: 'Visualizing with Glamorous Toolkit';
		play.

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> scripterWithToCNavigatedAndOtherTabClicked [
	<gtExample>
	| scripter check |
	scripter := self scripterWithToCNavigated.

	scripter click
		label: 'Select other tab';
		id: #sidebar;
		id: #content;
		id: #header;
		id: #tabbar;
		onChildAt: 2;
		play.	"somehow the selection is only picked up on re-render"
	scripter click
		label: 'Select first tab';
		id: #sidebar;
		id: #content;
		id: #header;
		id: #tabbar;
		onChildAt: 1;
		play.

	scripter click
		label: 'Select other tab again';
		id: #sidebar;
		id: #content;
		id: #header;
		id: #tabbar;
		onChildAt: 2;
		play.

	scripter check
		label: 'Check that element is selected';
		id: #sidebar;
		id: #content;
		id: #content;
		id: #list;
		satisfies: [ :aList | 
			aList
				selectedEntityDo: [ :aGroup | check := aGroup itemObject title = 'Visualizing with Glamorous Toolkit' ].
			check ];
		play.

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> toolFor: aDatabase [
	^ LePagePhlowTool new page: aDatabase pages last
]

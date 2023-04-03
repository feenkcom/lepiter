Class {
	#name : #LeDatabaseByScripterExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Examples'
}

{ #category : #accessing }
LeDatabaseByScripterExamples >> databaseWithTwoPages [
	<gtExample>
	| database |
	database := LeUIByScripterExamples new emptyDatabase.

	self addEmptyPageOneInto: database.
	self addEmptyPageTwoInto: database.

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
	scripter := self
			scripterWithModel: [ :aTarget :theScripter | LeUIExamples new databaseWithTableOfContents ]
			element: [ :aDatabase | (self toolFor: aDatabase) asElement createInPager maximized ].
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
LeDatabaseByScripterExamples >> scripterWithToCNavigated [
	<gtExample>
	| scripter |
	scripter := self scripterOnDatabaseToolWithToC.

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
		id: #title;
		play.

	scripter check
		label: 'Ensure page has changed';
		id: #content;
		id: #title;
		value: [ :anElement | anElement text asString ] equals: scripter model tableOfContents title;
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
				selectedEntityDo: [ :aGroup | check := aGroup itemObject title = scripter model tableOfContents title ].
			check ];
		play.

	^ scripter
]

{ #category : #accessing }
LeDatabaseByScripterExamples >> toolFor: aDatabase [
	^ LePagePhlowTool new page: aDatabase pages last
]

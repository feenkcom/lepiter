Class {
	#name : #LeDatabaseByScripterExamples,
	#superclass : #LeUIByScripterExamples,
	#category : #'Lepiter-UI-Examples'
}

{ #category : #accessing }
LeDatabaseByScripterExamples >> databaseWithTwoPages [
	<gtExample>
	| database |
	database := self emptyDatabase.

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
LeDatabaseByScripterExamples >> toolFor: aDatabase [
	^ LePagePhlowTool new page: aDatabase pages last
]

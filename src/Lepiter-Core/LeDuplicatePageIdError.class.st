Class {
	#name : #LeDuplicatePageIdError,
	#superclass : #Error,
	#instVars : [
		'file',
		'database',
		'newPage',
		'existingPage'
	],
	#category : #'Lepiter-Core-Exceptions'
}

{ #category : #'gt - extensions' }
LeDuplicatePageIdError >> createAnnotatedPagesElement [
	| pagesContainer headerElement rightContainer |
	pagesContainer :=  BrHorizontalPane new
		matchParent.
		
	headerElement := BrHorizontalPane new
		"padding: (BlInsets all: 0);"
		hMatchParent;
		vFitContent.

	headerElement 
		addChild: self createExistingPageLabel;
		addChild: self createNewPageLabel.
		
	pagesContainer addChild: (LePageToolContentTreeElement new 
		withTitleOnly;
		pageViewModel: existingPage asContentUIModel;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
		margin: (BlInsets all: 5);
		matchParent).
		
	rightContainer := BrHorizontalPane new
		margin: (BlInsets all: 5);
		"addAptitude: (BrGlamorousWithHorizontalResizerAptitude new beLeft);"
		matchParent.
		
	"rightContainer addChild: (BrFrame new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal exact: 10 ]
		yourself)."
		
	rightContainer addChild: (LePageToolContentTreeElement new 
		withTitleOnly;
		pageViewModel: newPage asContentUIModel;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
		matchParent).
		
	pagesContainer 
		addChild: rightContainer.
	
	^ BrVerticalPane new
	 	matchParent;
	 	addChild: headerElement;
	 	addChild: pagesContainer
]

{ #category : #'gt - extensions' }
LeDuplicatePageIdError >> createExistingPageLabel [
	^ BrLabel new 
		aptitude: BrGlamorousLabelAptitude;
		text: ('Existing page' asRopedText glamorousCodeSmallSize
			foreground: BrGlamorousColors defaultButtonTextColor);
	 	hMatchParent
]

{ #category : #'gt - extensions' }
LeDuplicatePageIdError >> createExplanationText [
	^ self standardMessageText, ' To proceed choose which page to load.'
			"'The Phlow view created by the method ' asRopedText
			,(self viewMethod printString asRopedText italic)
			,' returned the' asRopedText
			, (self parameterName asRopedText glamorousExplanationFor: #viewParameter)
			, ' argument. This is not allowed. Return  'asRopedText 
			, (self parameterName, ' empty') asRopedText italic,
			' instead.' asRopedText"
]

{ #category : #'gt - extensions' }
LeDuplicatePageIdError >> createExplanationWithPagesElement [
	| container |
	container := BrVerticalPane new
		matchParent;
		padding: (BlInsets top: 0 bottom: 5 left: 5 right: 5).
				
	"container addChild: (BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		text: self createExplanationText;
		margin: (BlInsets all: 10);
		hMatchParent;
		vFitContent).
				"
	container addChild: self createAnnotatedPagesElement.
	container explainer isExplanationHolder: true.
	
	^ container
]

{ #category : #'gt - extensions' }
LeDuplicatePageIdError >> createNewPageLabel [
	^ BrLabel new 
		aptitude: BrGlamorousLabelAptitude;
		text: ('New page' asRopedText glamorousCodeSmallSize
			foreground: BrGlamorousColors defaultButtonTextColor);
	 	hMatchParent
]

{ #category : #'private - adding / removing' }
LeDuplicatePageIdError >> database: aDatabase [ 
	database := aDatabase
]

{ #category : #'as yet unclassified' }
LeDuplicatePageIdError >> deletePageFile: aPage [
	"Delete the file from the supplied page, and if in the DB, remove the page"

	(database monitor pageFileReference: aPage) ensureDelete.
	aPage removeSelf.
]

{ #category : #accessing }
LeDuplicatePageIdError >> file [
	^ file
]

{ #category : #accessing }
LeDuplicatePageIdError >> file: anObject [
	file := anObject
]

{ #category : #'gt - extensions' }
LeDuplicatePageIdError >> gtDetailsFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView columnedList
		title: 'Details';
		priority: 0.1;
		items: {'Page already in DB' -> existingPage.
				'Page to add' -> newPage};
		column: 'Page' text: #key;
		column: 'Title' text: [ :each | each value title ];
		column: 'Uid' text: [ :each | each value uidString ];
		column: 'DB key' text: [ :each | each value databaseKey ];
		column: 'On disk'
			text: [ :each | 
				database monitor
					ifNil: [ 'N/A' ]
					ifNotNil: [ (database monitor pageFileReference: each value) exists ] ];
		contextItemLabel: 'Inspect database key'
			action: [ :anElement :each | anElement phlow spawnObject: each value databaseKey ];
		contextItemLabel: 'Inspect id'
			action: [ :anElement :each | anElement phlow spawnObject: each value uidString ];
		contextItemLabel: 'Inspect file'
			action: [ :anElement :each | anElement phlow spawnObject: (database monitor pageFileReference: each value) ]
			if: [ :each | 
				database monitor notNil
					and: [ (database monitor pageFileReference: each value) exists ] ];
		contextItemLabel: 'Delete page & file'
			action: [ :anElement :each | self deletePageFile: each value ]
			if: [ :each | 
				database monitor notNil
					and: [ (database monitor pageFileReference: each value) exists ] ];
		send: #value
]

{ #category : #'gt - extensions' }
LeDuplicatePageIdError >> gtViewTwoPageComparisonFor: aView [
	<gtView>
	<gtExceptionView>
	
	^ aView explicit
		title: 'Comparison';
		priority: 0;
		stencil: [ self createExplanationWithPagesElement ]";
		in: [ :currentView |
			self shouldTransform ifTrue: [.
				currentView
					actionDropdownButtonIcon: BrGlamorousVectorIcons repair 
						tooltip: 'Refactor view return' 
						content: [ self refactoringContentElement ] ].
			currentView
				actionButtonIcon: BrGlamorousVectorIcons browse
					tooltip: 'Browse method'
					action: [ self viewMethod gtBrowse ];
				yourself ]"
]

{ #category : #private }
LeDuplicatePageIdError >> isResumable [
	"Determine whether an exception is resumable."

	^ true
]

{ #category : #accessing }
LeDuplicatePageIdError >> messageText [
	^ messageText ifNil: [ 
		messageText := self standardMessageText ]
]

{ #category : #'private - adding / removing' }
LeDuplicatePageIdError >> pageInCurrentDatabase: aPage [ 
	existingPage := aPage
]

{ #category : #'private - adding / removing' }
LeDuplicatePageIdError >> pageToAdd: aLePage [ 
	newPage := aLePage
]

{ #category : #accessing }
LeDuplicatePageIdError >> standardMessageText [
	^  'The existing page "{1}" with id "{2}" has the same databaseKey "{3}" as the new page "{4}" with id "{5}".' format: {
		existingPage gtDisplayString.
		existingPage uidString.
		newPage databaseKey.
		newPage gtDisplayString.
		newPage uidString.
	} 
]

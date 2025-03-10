Class {
	#name : #LePageFooterToolbarElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'pageModel',
		'changeDatabaseButton'
	],
	#category : #'Lepiter-UI-! Tool - Page'
}

{ #category : #callbacks }
LePageFooterToolbarElement >> actOnPageModelChanged [
	self updateContent.
]

{ #category : #accessing }
LePageFooterToolbarElement >> availableDatabases [
	^ self currentDatabase logicalDatabase 
		ifNil: [ #() ]
		ifNotNil: [ :aLogicalDatabase | 
			Array streamContents: [ :out |
				aLogicalDatabase databasesDo: [ :aDatabase |
					aDatabase = self currentDatabase
						ifFalse: [ out nextPut: aDatabase ] ] ] ]
]

{ #category : #accessing }
LePageFooterToolbarElement >> currentDatabase [
	^ self pageModel database
]

{ #category : #initialization }
LePageFooterToolbarElement >> initialize [
	super initialize.
	self layout: BlLinearLayout horizontal.
	self 
		margin: (BlInsets top: 5 left: 0 bottom: 5 right: 0);
		padding: (BlInsets top: 5 left: 10 bottom: 5 right: 15).

	changeDatabaseButton := self newChangeDatabaseButton. 
	self addChild: changeDatabaseButton as: #changeDatabaseButton.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent).
]

{ #category : #actions }
LePageFooterToolbarElement >> modePageToDatabase: aNewDatabase [
	self pageModel moveToDatabase: aNewDatabase
]

{ #category : #initialization }
LePageFooterToolbarElement >> newAvailableDatabasesList [
	^ BrSimpleList new
		vFitContentLimited;
		hFitContent;
		itemStencil: [
			BrButton new
				beSmallSize;
				aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
				action: [ :aButton :aButtonModel |
					aButton fireEvent: BrDropdownHideWish new.
					self modePageToDatabase: aButton viewModel model ] ];
		itemDataBinder: [ :eachButton :eachDatabase |
			eachButton viewModel model: eachDatabase.
			eachButton 
				label: eachDatabase databaseName;
				enabled: (self pageModel canMoveToDatabase: eachDatabase) ];
		items: self availableDatabases
]

{ #category : #initialization }
LePageFooterToolbarElement >> newChangeDatabaseButton [
	^ BrButton new
		beTinySize;
		aptitude:
			BrGlamorousButtonWithLabelAptitude
				+
					(BrGlamorousWithExplicitDropdownAptitude
						handle: [
							BrButton new
								beSmallSize;
								disable;
								aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
								label: self currentDatabase databaseName ]
						content: [ 
							self newAvailableDatabasesList ])
]

{ #category : #accessing }
LePageFooterToolbarElement >> pageModel [
	^ pageModel
]

{ #category : #accessing }
LePageFooterToolbarElement >> pageModel: anObject [
	pageModel := anObject.
	self actOnPageModelChanged.
]

{ #category : #updating }
LePageFooterToolbarElement >> updateContent [
	changeDatabaseButton label: self currentDatabase databaseName.
	changeDatabaseButton enabled: self pageModel canMoveToAnotherDatabase.
	
	self currentDatabase isDatabase ifFalse: [
		"Do not show the button at all in case the page does not have a database"
		changeDatabaseButton visibility: BlVisibility gone.
		
		self margin: (BlInsets all:0).
		self padding: (BlInsets all:0)]
]

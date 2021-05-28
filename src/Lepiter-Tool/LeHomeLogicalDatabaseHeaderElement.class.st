Class {
	#name : #LeHomeLogicalDatabaseHeaderElement,
	#superclass : #LeHomeCommonDatabaseHeaderElement,
	#instVars : [
		'readyOnlyTitleElement'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #initialization }
LeHomeLogicalDatabaseHeaderElement >> initialize [
	super initialize.
	self initializeReadOnlyTitleElement.
	
	self addChild: self toolbarElement as: #toolbar.
	self toolbarElement 
		addItem: self readOnlyTitleElement;
		addItem: self newAddNewPageButton.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent; 
		hInherit: self toolbarElement;
		vAnyToFitContent: self toolbarElement).
]

{ #category : #initialization }
LeHomeLogicalDatabaseHeaderElement >> initializeReadOnlyTitleElement [
	readyOnlyTitleElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			foreground: BrGlamorousColors disabledButtonTextColor;
			glamorousRegularFontAndSize);
		text: 'Recent Pages'
]

{ #category : #'private - accessing' }
LeHomeLogicalDatabaseHeaderElement >> readOnlyTitleElement [
	<return: #BrLabel>
	^ readyOnlyTitleElement
]

"
I display a ${class:LeDatabase}$ items, including ${class:LePage}$ instances and their ${class:LeSnippet}$ instances. The items can be filtered using ${class:GtFiltersElement}$.

${example:LeUIExamples>>#databaseToolElement|previewExpanded}$

"
Class {
	#name : #LeDatabaseToolElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'headerElement',
		'treeElement'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #'private - accessing' }
LeDatabaseToolElement >> headerElement [
	<rerturn: #LeDatabaseHeaderElement>
	^ headerElement
]

{ #category : #initialization }
LeDatabaseToolElement >> initialize [
	super initialize.
	self initializeHeaderElement.
	self initializeTreeElement.
	self layout: BlLinearLayout vertical.
	
	self addChild: self headerElement as: #header.
	self addChild: self treeElement as: #tree.

	self addAptitude: (BrLayoutResizerAptitude inherit)
]

{ #category : #initialization }
LeDatabaseToolElement >> initializeHeaderElement [
	headerElement := LeDatabaseHeaderElement new
]

{ #category : #initialization }
LeDatabaseToolElement >> initializeTreeElement [
	treeElement := LeDatabaseFilteredTreeElement new
]

{ #category : #'private - hooks' }
LeDatabaseToolElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self headerElement databaseViewModel: self databaseViewModel.
	self treeElement databaseViewModel: self databaseViewModel
]

{ #category : #'private - accessing' }
LeDatabaseToolElement >> treeElement [
	<rerturn: #LeDatabaseFilteredTreeElement>
	^ treeElement
]

"
I display a {{gtClass:LeDatabase}} items, including {{gtClass:LePage}} instances and their {{gtClass:LeSnippet}} instances. The items can be filtered using {{gtClass:GtFiltersElement}}.

{{gtExample:LeUIExamples>>#databaseFilteredTreeElement|previewExpanded}}


"
Class {
	#name : #LeDatabaseFilteredTreeElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'treeElement',
		'filtersElement',
		'filters'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #'private - event handling' }
LeDatabaseFilteredTreeElement >> buildFilters: anEvent [
	filters := OrderedCollection new.
	anEvent filterElement
		filtersDo:
			[ :descriptor :value | filters add: (descriptor newFilterWithValue: value) ].
	self updateTreeElementItems
]

{ #category : #'private - accessing' }
LeDatabaseFilteredTreeElement >> filters [
	^ filters
]

{ #category : #'private - accessing' }
LeDatabaseFilteredTreeElement >> filtersElement [
	<return: #GtFiltersElement>
	^ filtersElement
]

{ #category : #initialization }
LeDatabaseFilteredTreeElement >> initialize [
	super initialize.
	filters := #().
	self initializeFiltersElement.
	self initializeTreeElement.
	self layout: BlLinearLayout vertical.

	self addChild: self filtersElement as: #filters.	
	self addChild: self treeElement as: #tree.
	
	self addAptitude: (BrLayoutResizerAptitude new inherit: self treeElement)
]

{ #category : #initialization }
LeDatabaseFilteredTreeElement >> initializeFiltersElement [
	filtersElement := GtFiltersElement new.
	filtersElement padding: (BlInsets all: 2).
	filtersElement
		when: GtFiltersChangedEvent
		do: [ :event | self buildFilters: event ].
]

{ #category : #initialization }
LeDatabaseFilteredTreeElement >> initializeTreeElement [
	treeElement := LeDatabaseTreeElement new
		rootItemsSelector: (LeFilteredChildrenSelector new element: self)
]

{ #category : #'private - hooks' }
LeDatabaseFilteredTreeElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self treeElement databaseViewModel: self databaseViewModel.
	self updateFilterDescriptors.
	self updateTreeElementItems.
]

{ #category : #'private - accessing' }
LeDatabaseFilteredTreeElement >> treeElement [
	<return: #LeDatabaseTreeElement>
	^ treeElement
]

{ #category : #'private - updating' }
LeDatabaseFilteredTreeElement >> updateFilterDescriptors [
	filtersElement descriptors: (
		LeFilter allFilterDescriptorsFor: self database)
]

{ #category : #'private - updating' }
LeDatabaseFilteredTreeElement >> updateTreeElementItems [
	self treeElement updateTreeElementItems
]

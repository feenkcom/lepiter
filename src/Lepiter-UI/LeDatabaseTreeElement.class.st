"
I display a {{gtClass:LeDatabase}} items, including {{gtClass:LePage}} instances and their {{gtClass:LeSnippet}} instances.

{{gtExample:LeUIExamples>>#databaseTreeElement|previewExpanded}}


"
Class {
	#name : #LeDatabaseTreeElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'treeElement',
		'selectionTransformationHandler',
		'rootItemsSelector'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #defaults }
LeDatabaseTreeElement >> defaultRootItemsSelector [
	^ LeChildrenSelector default
]

{ #category : #defaults }
LeDatabaseTreeElement >> defaultSelectionTransformation [
	^ [ :aNode :anIndex | aNode value ]
]

{ #category : #initialization }
LeDatabaseTreeElement >> initialize [
	super initialize.
	rootItemsSelector := self defaultRootItemsSelector.
	self initializeTreeElement.
	self initializeTreeColumns.
	self layout: BlLinearLayout vertical.
	
	self addChild: self treeElement as: #tree.
	
	self addAptitude: (BrLayoutResizerAptitude new 
		inherit: self treeElement)
]

{ #category : #initialization }
LeDatabaseTreeElement >> initializeTreeColumns [
	self treeElement column
		title: 'Title';
		cellStencil: [ :aNodeType | BrLabel new aptitude: BrGlamorousLabelAptitude ];
		dataBinder: [ :anItemElement :anItem | anItemElement text: anItem contentAsString ];
		weight: 2.
	self treeElement column
		title: 'Edit Time';
		cellStencil: [ :aNodeType | BrLabel new aptitude: BrGlamorousLabelAptitude ];
		dataBinder:
				[ :anItemElement :anItem | anItemElement text: anItem latestEditTime asDate asString ];
		weight: 1.
	self treeElement column
		title: 'Edit Author';
		cellStencil: [ :aNodeType | BrLabel new aptitude: BrGlamorousLabelAptitude ];
		dataBinder:
				[ :anItemElement :anItem | anItemElement text: anItem editOrCreateEmail asString ];
		weight: 1
]

{ #category : #initialization }
LeDatabaseTreeElement >> initializeTreeElement [
	treeElement := BrColumnedTree new
		matchParent;
		rowStencil: (BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new);
		nodeType: [ :anItemTypeFactory :aTreeNode :aNodeIndex | aTreeNode value class ];
		items: self children lazy: #children.
	selectionTransformationHandler := GtPhlowListToSelectHandler new
		transformation: self defaultSelectionTransformation.
	treeElement addEventHandler: selectionTransformationHandler
]

{ #category : #'private - hooks' }
LeDatabaseTreeElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateTreeElementItems.
]

{ #category : #'private - accessing' }
LeDatabaseTreeElement >> rootItems [
	^ Array streamContents: [ :aStream | 
		self rootItemsInto: aStream ].
]

{ #category : #'private - accessing' }
LeDatabaseTreeElement >> rootItemsInto: aStream [
	self rootItemsSelector rootsFor: self database into: aStream.
]

{ #category : #'private - accessing' }
LeDatabaseTreeElement >> rootItemsSelector [
	"Get selector for root items"
	^ rootItemsSelector
]

{ #category : #'api - initialization' }
LeDatabaseTreeElement >> rootItemsSelector: aRootItemsSelector [
	"Set selector for root items"
	rootItemsSelector := aRootItemsSelector.
]

{ #category : #'private - accessing' }
LeDatabaseTreeElement >> treeElement [
	<return: #BrColumnedTree>
	^ treeElement
]

{ #category : #'private - updating' }
LeDatabaseTreeElement >> updateTreeElementItems [
	self treeElement items: self rootItems lazy: #children.
]

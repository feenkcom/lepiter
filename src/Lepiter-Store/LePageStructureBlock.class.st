Class {
	#name : #LePageStructureBlock,
	#superclass : #Object,
	#instVars : [
		'uid',
		'parentBlock',
		'typeName',
		'blocks',
		'changeStatuses'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #'instance creation' }
LePageStructureBlock class >> forContent: aLeContent [
	^ self new
		uid: aLeContent uid;
		typeName: aLeContent className
]

{ #category : #adding }
LePageStructureBlock >> addChildBlock: aChildBlock [
	self assert: [ aChildBlock parentBlock isNil ].
	
	self blocks add: aChildBlock.
	aChildBlock parentBlock: self
]

{ #category : #'accessing - count' }
LePageStructureBlock >> addedBlocksCount [
	^ self countAllNodesMatching: [ :aBlock | aBlock isAdded ]
]

{ #category : #'gt - extensions' }
LePageStructureBlock >> backgroundColor [
	self isAdded 
		ifTrue: [ ^ Color green muchDarker ].
	self isModified 
		ifTrue: [ ^ Color red muchDarker ].
	self isResolved 
		ifTrue: [ ^ Color blue muchDarker ].
	^ Color gray
]

{ #category : #accessing }
LePageStructureBlock >> blocks [

	^ blocks
]

{ #category : #accessing }
LePageStructureBlock >> changeStatuses [
	^ changeStatuses
]

{ #category : #enumerating }
LePageStructureBlock >> collectAllNodesMatching: aComputation [
	^ self withDeep: #blocks select: aComputation collect: [ :aNode | aNode ]
]

{ #category : #enumerating }
LePageStructureBlock >> countAllNodesMatching: aComputation [
	| count |
	count := 0.
	self withAllChildrenDo: [ :each |
		(aComputation value: each) ifTrue: [
			count := count + 1 ] ].
	^ count
]

{ #category : #printing }
LePageStructureBlock >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
LePageStructureBlock >> descriptionOn: aStream [
	aStream 
		<< self typeName;
		<< ', ';
		<< self uid asString
]

{ #category : #'gt - extensions' }
LePageStructureBlock >> gtViewChangesFor: aView [
	<gtView>
	
	^ aView list
		  title: 'Changes';
		  priority: 30;
		  items: [ changeStatuses ]
]

{ #category : #'gt - extensions' }
LePageStructureBlock >> gtViewStructureFor: aView [
	<gtView>
	
	^ aView columnedTree
		  title: 'Structure Tree';
		  priority: 10;
		  items: [ { self } ];
		  expandUpTo: 2;
		  children: [ :aNode | aNode blocks ];
		  column: 'Node' text: [ :aNode | aNode  description ];
		  column: 'Actions' text: [ :aNode | aNode changeStatuses asCommaString ]
]

{ #category : #'gt - extensions' }
LePageStructureBlock >> gtViewStructureMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Structure Map' translated;
		priority: 20;
		painting: [ :mondrian |
			self paintStructureOn: mondrian ]
]

{ #category : #initialization }
LePageStructureBlock >> initialize [
	super initialize.
	blocks := OrderedCollection new.
	changeStatuses := OrderedCollection new.
]

{ #category : #testing }
LePageStructureBlock >> isAdded [
	^ changeStatuses includes: #added
]

{ #category : #testing }
LePageStructureBlock >> isModified [
	^ changeStatuses includes: #modified
]

{ #category : #testing }
LePageStructureBlock >> isMoved [
	^ changeStatuses includes: #moved
]

{ #category : #testing }
LePageStructureBlock >> isResolved [
	^ changeStatuses includes: #resolved
]

{ #category : #'accessing - status' }
LePageStructureBlock >> markAsAdded [
	changeStatuses add: #added
]

{ #category : #'accessing - status' }
LePageStructureBlock >> markAsModified [
	changeStatuses add: #modified
]

{ #category : #'accessing - status' }
LePageStructureBlock >> markAsMoved [
	changeStatuses add: #moved
]

{ #category : #'accessing - status' }
LePageStructureBlock >> markAsResolved [
	changeStatuses add: #resolved
]

{ #category : #'accessing - count' }
LePageStructureBlock >> modifiedBlocksCount [
	^ self countAllNodesMatching: [ :aBlock | aBlock isModified ]
]

{ #category : #enumerating }
LePageStructureBlock >> movedBlocks [
	^ self collectAllNodesMatching: [ :aNode | aNode isMoved ]
]

{ #category : #'accessing - count' }
LePageStructureBlock >> movedBlocksCount [
	^ self countAllNodesMatching: [ :aBlock | aBlock isMoved ]
]

{ #category : #'gt - extensions' }
LePageStructureBlock >> paintStructureOn: mondrian [
	mondrian nodes 
		shape: [ :aBlock |
			BrLabel new 
				text: aBlock typeName; 
				aptitude: (BrGlamorousLabelAptitude new
					foreground: aBlock backgroundColor;
					in: [ :aptitude |
						aBlock isMoved ifTrue: [ 
							aptitude underline ].
						aptitude ]) ];
		with: (self withDeepCollect: #blocks).
	mondrian edges
		stencil: [:class | 
			BlParabollaArcElement new 
				zIndex: 0;
				curvatureFraction: 0.3;
				border: (BlBorder paint: (Color gray alpha: 0.5) width: 2);
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (Color gray alpha: 0.5); width: 2; build)) ];
		fromRightCenter;
		toLeftCenter;
		connectToAll: #blocks.
	mondrian layout  horizontalDominanceTree
		levelDistance: 100;
		nodeDistance: 10
]

{ #category : #accessing }
LePageStructureBlock >> parentBlock [

	^ parentBlock
]

{ #category : #accessing }
LePageStructureBlock >> parentBlock: anObject [

	parentBlock := anObject
]

{ #category : #accessing }
LePageStructureBlock >> parentUid [
	^ self parentBlock ifNotNil: [ :aBlock | aBlock uid ]
]

{ #category : #accessing }
LePageStructureBlock >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< '(';
		<< self typeName;
		<< ')'
]

{ #category : #'accessing - count' }
LePageStructureBlock >> resolvedBlocksCount [
	^ self countAllNodesMatching: [ :aBlock | aBlock isResolved ]
]

{ #category : #accessing }
LePageStructureBlock >> typeName [

	^ typeName
]

{ #category : #accessing }
LePageStructureBlock >> typeName: aString [

	typeName := aString
]

{ #category : #accessing }
LePageStructureBlock >> uid [

	^ uid
]

{ #category : #accessing }
LePageStructureBlock >> uid: anObject [

	uid := anObject
]

{ #category : #enumerating }
LePageStructureBlock >> withAllChildrenDo: aComputation [
	aComputation cull: self.
	self blocks do: [ :aChild |
		aChild withAllChildrenDo: aComputation ]
]

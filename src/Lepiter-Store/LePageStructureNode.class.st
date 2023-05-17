"
I model a node in the structure of a page. 

I exist becasue the current reload mechanisn flattens the structure of a page.
I preserve that structure and I am used for recreating the page.
"
Class {
	#name : #LePageStructureNode,
	#superclass : #Object,
	#instVars : [
		'uid',
		'parentNode',
		'childNodes',
		'typeName',
		'changeStatuses'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #'instance creation' }
LePageStructureNode class >> forContent: aLeContent [
	^ self new
		uid: aLeContent uid;
		typeName: aLeContent className
]

{ #category : #adding }
LePageStructureNode >> addChildNode: aChildNode [
	self assert: [ aChildNode parentNode isNil ].
	
	self childNodes add: aChildNode.
	aChildNode parentNode: self
]

{ #category : #'accessing - count' }
LePageStructureNode >> addedNodesCount [
	^ self countAllNodesMatching: [ :aNode | aNode isAdded ]
]

{ #category : #'gt - extensions' }
LePageStructureNode >> backgroundColor [
	self isAdded 
		ifTrue: [ ^ Color green muchDarker ].
	self isModified 
		ifTrue: [ ^ Color red muchDarker ].
	self isResolved 
		ifTrue: [ ^ Color blue muchDarker ].
	^ Color gray
]

{ #category : #accessing }
LePageStructureNode >> changeStatuses [
	^ changeStatuses
]

{ #category : #accessing }
LePageStructureNode >> childNodes [

	^ childNodes
]

{ #category : #enumerating }
LePageStructureNode >> collectAllNodesMatching: aComputation [
	^ self withDeep: #childNodes select: aComputation collect: [ :aNode | aNode ]
]

{ #category : #enumerating }
LePageStructureNode >> countAllNodesMatching: aComputation [
	| count |
	count := 0.
	self withAllChildrenDo: [ :aNode |
		(aComputation value: aNode) ifTrue: [
			count := count + 1 ] ].
	^ count
]

{ #category : #printing }
LePageStructureNode >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
LePageStructureNode >> descriptionOn: aStream [
	aStream 
		<< self typeName;
		<< ', ';
		<< self uid asString
]

{ #category : #'gt - extensions' }
LePageStructureNode >> gtViewChangesFor: aView [
	<gtView>
	
	^ aView list
		  title: 'Changes';
		  priority: 30;
		  items: [ changeStatuses ]
]

{ #category : #'gt - extensions' }
LePageStructureNode >> gtViewStructureFor: aView [
	<gtView>
	
	^ aView columnedTree
		  title: 'Structure tree';
		  priority: 10;
		  items: [ { self } ];
		  expandUpTo: 2;
		  children: [ :aNode | aNode childNodes ];
		  column: 'Node' text: [ :aNode | aNode  description ];
		  column: 'Actions' text: [ :aNode | aNode changeStatuses asCommaString ]
]

{ #category : #'gt - extensions' }
LePageStructureNode >> gtViewStructureMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Structure map' translated;
		priority: 20;
		painting: [ :mondrian |
			self paintStructureOn: mondrian ]
]

{ #category : #initialization }
LePageStructureNode >> initialize [
	super initialize.
	childNodes := OrderedCollection new.
	changeStatuses := OrderedCollection new.
]

{ #category : #testing }
LePageStructureNode >> isAdded [
	^ changeStatuses includes: #added
]

{ #category : #testing }
LePageStructureNode >> isModified [
	^ changeStatuses includes: #modified
]

{ #category : #testing }
LePageStructureNode >> isMoved [
	^ changeStatuses includes: #moved
]

{ #category : #testing }
LePageStructureNode >> isRemoved [
	^ changeStatuses includes: #removed
]

{ #category : #testing }
LePageStructureNode >> isResolved [
	^ changeStatuses includes: #resolved
]

{ #category : #'accessing - status' }
LePageStructureNode >> markAsAdded [
	changeStatuses add: #added
]

{ #category : #'accessing - status' }
LePageStructureNode >> markAsModified [
	changeStatuses add: #modified
]

{ #category : #'accessing - status' }
LePageStructureNode >> markAsMoved [
	changeStatuses add: #moved
]

{ #category : #'accessing - status' }
LePageStructureNode >> markAsRemoved [
	changeStatuses add: #removed
]

{ #category : #'accessing - status' }
LePageStructureNode >> markAsResolved [
	changeStatuses add: #resolved
]

{ #category : #'accessing - count' }
LePageStructureNode >> modifiedNodesCount [
	^ self countAllNodesMatching: [ :aNode | aNode isModified ]
]

{ #category : #enumerating }
LePageStructureNode >> movedNodes [
	^ self collectAllNodesMatching: [ :aNode | aNode isMoved ]
]

{ #category : #'accessing - count' }
LePageStructureNode >> movedNodesCount [
	^ self countAllNodesMatching: [ :aNode | aNode isMoved ]
]

{ #category : #'gt - extensions' }
LePageStructureNode >> paintStructureOn: mondrian [
	mondrian nodes 
		shape: [ :aNode |
			BrLabel new 
				text: aNode typeName; 
				aptitude: (BrGlamorousLabelAptitude new
					foreground: aNode backgroundColor;
					in: [ :aptitude |
						aNode isMoved ifTrue: [ 
							aptitude underline ].
						aNode isRemoved ifTrue: [ 
							aptitude decorationDo: [ :d | d lineThrough ] ].
						aptitude ]) ];
		with: (self withDeepCollect: #childNodes).
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
		connectToAll: #childNodes.
	mondrian layout  horizontalDominanceTree
		levelDistance: 100;
		nodeDistance: 10
]

{ #category : #accessing }
LePageStructureNode >> parentNode [

	^ parentNode
]

{ #category : #accessing }
LePageStructureNode >> parentNode: aNode [

	parentNode := aNode
]

{ #category : #accessing }
LePageStructureNode >> parentUid [
	^ self parentNode ifNotNil: [ :aNode | aNode uid ]
]

{ #category : #accessing }
LePageStructureNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< '(';
		<< self typeName;
		<< ')'
]

{ #category : #'accessing - count' }
LePageStructureNode >> resolvedNodesCount [
	^ self countAllNodesMatching: [ :aNode | aNode isResolved ]
]

{ #category : #accessing }
LePageStructureNode >> typeName [

	^ typeName
]

{ #category : #accessing }
LePageStructureNode >> typeName: aString [

	typeName := aString
]

{ #category : #accessing }
LePageStructureNode >> uid [

	^ uid
]

{ #category : #accessing }
LePageStructureNode >> uid: anObject [

	uid := anObject
]

{ #category : #enumerating }
LePageStructureNode >> withAllChildrenDo: aComputation [
	aComputation cull: self.
	self childNodes do: [ :aChildNode |
		aChildNode withAllChildrenDo: aComputation ]
]

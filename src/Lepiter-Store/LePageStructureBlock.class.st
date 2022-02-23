Class {
	#name : #LePageStructureBlock,
	#superclass : #Object,
	#instVars : [
		'uid',
		'typeName',
		'blocks',
		'changeStatus'
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
LePageStructureBlock >> addChildBlock: aBlock [
	self blocks add: aBlock 
]

{ #category : #accessing }
LePageStructureBlock >> backgroundColor [
	self isAdded 
		ifTrue: [ ^ Color green muchDarker ].
	self isModified 
		ifTrue: [ ^ Color red muchDarker  ].
	^ Color black
]

{ #category : #accessing }
LePageStructureBlock >> blocks [

	^ blocks
]

{ #category : #accessing }
LePageStructureBlock >> changeStatus [
	^ changeStatus ifNil: [
		#notModified ]
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

{ #category : #accessing }
LePageStructureBlock >> gtLoadDirectivesMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Structure Map' translated;
		priority: 20;
		painting: [ :mondrian |
			mondrian nodes 
				shape: [ :aBlock |
					BrLabel new 
						text: aBlock typeName; 
						aptitude: (BrGlamorousLabelAptitude new
							foreground: aBlock backgroundColor) ];
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
				nodeDistance: 10 ]
]

{ #category : #accessing }
LePageStructureBlock >> gtViewStructureFor: aView [
	<gtView>
	
	^ aView tree
		  title: 'Structure Tree';
		  priority: 10;
		  items: [ { self } ];
		  expandUpTo: 2;
		  children: [ :aBlock | aBlock blocks ];
		  itemText: [ :aBlock | aBlock description ]
]

{ #category : #initialization }
LePageStructureBlock >> initialize [
	super initialize.
	blocks := OrderedCollection new.
]

{ #category : #testing }
LePageStructureBlock >> isAdded [
	^ self changeStatus = #added
]

{ #category : #accessing }
LePageStructureBlock >> isModified [
	^ changeStatus = #modified
]

{ #category : #accessing }
LePageStructureBlock >> markAsAdded [
	changeStatus := #added
]

{ #category : #accessing }
LePageStructureBlock >> markAsModified [
	^ changeStatus := #modified
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

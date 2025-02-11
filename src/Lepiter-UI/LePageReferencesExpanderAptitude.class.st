Class {
	#name : #LePageReferencesExpanderAptitude,
	#superclass : #BrExpanderAptitude,
	#instVars : [
		'sidebar',
		'toggle',
		'container'
	],
	#category : #'Lepiter-UI-Basic - Support'
}

{ #category : #initialization }
LePageReferencesExpanderAptitude >> initialize [
	super initialize.

	toggle := BrInlineExpanderElement new
		beSmallSize;
		aptitude: BrGlamorousTriangleInCircleExpanderAptitude;
		toggleAction: [ self widget fireEvent: BrExpansionToggleWish new ];
		margin: (BlInsets top: 2).

	sidebar := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent ];
		addChild: toggle.
	container := BlElement new
		clipChildren: false;
		layout: BlLinearLayout vertical.
		
	self add: (BrStyleCommonAptitude new
		collapsed: [ :aStyle | ]).
		
	self addChangeAddChildAs: #(sidebar) with: [ sidebar ].
	self addChangeAddChildAs: #(content) with: [ container ].
	
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].
	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: 3 ].

	container addAptitude: (BrLayoutResizerAptitude new
		matchParentToMatchParent: [ :aBlock | self resizableElementsDo: aBlock ];
		exactToMatchParent: [ :aBlock | self resizableElementsDo: aBlock ];
		fitContentToFitContent: [ :aBlock | self resizableElementsDo: aBlock ];
		fitContentLimitedToFitContentLimited: [ :aBlock | self resizableElementsDo: aBlock ])
]

{ #category : #accessing }
LePageReferencesExpanderAptitude >> padding: anInsets [
	container padding: anInsets
]

{ #category : #accessing }
LePageReferencesExpanderAptitude >> resizableElementsDo: aBlock [
	super resizableElementsDo: aBlock.
	
	aBlock value: container
]

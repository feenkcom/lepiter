Class {
	#name : #LeSnippetHeaderElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TLeWithSnippetViewModel',
	#classTraits : 'TLeWithSnippetViewModel classTrait',
	#instVars : [
		'pageButton',
		'descriptionLabel'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #accessing }
LeSnippetHeaderElement >> initialize [
	super initialize.
	self hMatchParent.
	self vFitContent.
	pageButton := BrButton new
			fitContent;
			aptitude: (BrGlamorousLabelAptitude new
					foreground: BrGlamorousColors defaultButtonTextColor;
					glamorousRegularSmallSize)
					+ (BrStyleCommonAptitude new
							default: [ :aStyle | 
								aStyle
									geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
									border: BlBorder empty ];
							hovered: [ :aStyle | aStyle border: self theme button hoveredBorderColor ]);
			label: '';
			action: [ self spawnPage ].
	descriptionLabel := BrLabel new
			fitContent;
			aptitude: (BrGlamorousLabelAptitude new
					glamorousRegularSmallSize;
					foreground: BrGlamorousColors defaultButtonTextColor);
			text: ''.
	self
		addChild: (BrHorizontalPane new
				vFitContent;
				hMatchParent;
				addChild: pageButton;
				yourself).
	self addChild: descriptionLabel
]

{ #category : #'api - snippet view model' }
LeSnippetHeaderElement >> onSnippetViewModelChanged [
	self updatePageButton.
	self updatePageDescription
]

{ #category : #accessing }
LeSnippetHeaderElement >> spawnPage [
	self snippetViewModel
		ifNotNil: [ :vm | self phlow spawnTool: (LePagePhlowTool page: vm snippetModel page) ]
]

{ #category : #'api - snippet view model' }
LeSnippetHeaderElement >> updatePageButton [
	self snippetViewModel
		ifNotNil: [ :vm | pageButton label: vm snippetModel page title ]
]

{ #category : #'api - snippet view model' }
LeSnippetHeaderElement >> updatePageDescription [
	self snippetViewModel
		ifNotNil: [ :vm | descriptionLabel text: vm snippetModel class description ]
]

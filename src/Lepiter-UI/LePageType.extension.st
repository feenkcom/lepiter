Extension { #name : #LePageType }

{ #category : #'*Lepiter-UI' }
LePageType >> asLepiterPagePhlowTool [
	^ (self class defaultSystemPageTypes includes: self class)
		ifTrue: [ self page asLepiterPagePhlowTool ]
		ifFalse: [ GtPhlowCompositeTool new
				addTool: self defaultPhlowTool;
				addTool: (GtPhlowExplicitTool new withLabelAndIconAptitude
						icon: BrGlamorousVectorIcons inspect;
						name: 'Page Type';
						stencil: [ (GtPhlowTool default object: self) asElement ]);
				addTool: (GtPhlowExplicitTool new withLabelAndIconAptitude
						icon: BrGlamorousVectorIcons inspect;
						name: 'Page';
						stencil: [ (GtPhlowTool default object: self page) asElement ]) ]
]

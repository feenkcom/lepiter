Extension { #name : #TLeUnknownPageType }

{ #category : #'*Lepiter-UI' }
TLeUnknownPageType >> asLepiterPagePhlowTool [
	^ GtPhlowCompositeTool new
		addTool: self defaultPhlowTool;
		addTool: (GtPhlowExplicitTool new withLabelAndIconAptitude
				icon: BrGlamorousVectorIcons debug;
				name: 'Unknown (' , self pageType asString , ') Page Type';
				stencil: [ (GtPhlowTool default object: self) asElement ]);
		addTool: (GtPhlowExplicitTool new withLabelAndIconAptitude
				icon: BrGlamorousVectorIcons inspect;
				name: 'Page';
				stencil: [ (GtPhlowTool default object: self page) asElement ])
]

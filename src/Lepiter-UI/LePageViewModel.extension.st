Extension { #name : #LePageViewModel }

{ #category : #'*Lepiter-UI' }
LePageViewModel >> asPhlowReferencedToolFrom: aReferencedPage [
	^ self pageModel asLepiterReferencedPagePhlowTool: aReferencedPage
]

{ #category : #'*Lepiter-UI' }
LePageViewModel >> asPhlowTool [
	^ GtPhlowCompositeTool new
		addTool: (LePagePhlowTool page: self pageModel);
		addTool: (GtPhlowTool default object: self pageModel)";
		addTool: (GtConnectorTool new object: self)"
]

{ #category : #'*Lepiter-UI' }
LePageViewModel >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ 
			LePageToolContentTreeElement new 
				pageViewModel: self;
				matchParent ]
]

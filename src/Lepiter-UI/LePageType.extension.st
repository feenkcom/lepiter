Extension { #name : #LePageType }

{ #category : #'*Lepiter-UI' }
LePageType >> asLepiterPagePhlowToolFocusStatus: aBoolean [
	^ GtPhlowCompositeTool new
		addTool: (LePagePhlowTool new
			shouldFocusFirstSnippet: aBoolean;
			page: page);
		addTool: (GtPhlowTool default object: page)";
		addTool: (GtConnectorTool new object: self)"
]

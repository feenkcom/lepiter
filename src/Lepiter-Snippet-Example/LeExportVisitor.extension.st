Extension { #name : #LeExportVisitor }

{ #category : #'*Lepiter-Snippet-Example' }
LeExportVisitor >> visitExampleSnippet: aLeExampleSnippet [

	LeExportExampleResourceBuilder new
		resources: context resources;
		sequencer: context sequencer;
		fileStore: context fileStore;
		snippet: aLeExampleSnippet;
		build.

	^ self visitSnippet: aLeExampleSnippet
]

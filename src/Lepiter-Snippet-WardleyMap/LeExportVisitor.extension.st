Extension { #name : #LeExportVisitor }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
LeExportVisitor >> visitWardleyMapSnippet: aLeWardleySnippet [
	| aResource |
	aResource := LeExportSnippetElementResource new.
	
	aResource height: aLeWardleySnippet height.
	aResource path: self nextPath.
	aResource reference: (self nextFileReferenceTo: aResource path).
	aResource snippet: aLeWardleySnippet.
	
	self addResource: aResource.

	^ self visitSnippet: aLeWardleySnippet
]

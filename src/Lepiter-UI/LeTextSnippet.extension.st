Extension { #name : #LeTextSnippet }

{ #category : #'*Lepiter-UI' }
LeTextSnippet >> promoteToPage [
	
	| aPage |
	aPage := LePage named: self text asString.
	self database addPage: aPage.
	self transferChildrenTo: aPage.
	self removeSelf.
]

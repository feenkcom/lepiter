Extension { #name : #LeTextualSnippet }

{ #category : #'*Lepiter-Utilities' }
LeTextualSnippet >> updateUnlinkedReferences [
	"Update unlinked references the receiver may have to other pages.
	Subclasses that support unlinked references should call this when they are updated."

	LeUnlinkedReferenceMaintenance submitForBlock: self.
]

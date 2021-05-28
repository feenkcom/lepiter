Trait {
	#name : #TLeUnlinkedReferencesUpdate,
	#category : #'Lepiter-Core-Visitor'
}

{ #category : #updating }
TLeUnlinkedReferencesUpdate >> removeUnlinkedReferencesFromDatabase: aDatabase [
	LeUnlinkedReferenceRemovalMaintenace 
		submitForSnippet: self 
		database: aDatabase
]

{ #category : #updating }
TLeUnlinkedReferencesUpdate >> updateUnlinkedReferences [
	"Update unlinked references the receiver may have to other pages.
	Subclasses that support unlinked references should call this when they are updated."

	LeUnlinkedReferenceMaintenace submitForBlock: self.
]

Extension { #name : #TLeUnlinkedReferencesUpdate }

{ #category : #'*Lepiter-Utilities' }
TLeUnlinkedReferencesUpdate >> removeUnlinkedReferencesFromDatabase: aDatabase [
	LeUnlinkedReferenceRemovalMaintenace 
		submitForSnippet: self 
		database: aDatabase
]

{ #category : #'*Lepiter-Utilities' }
TLeUnlinkedReferencesUpdate >> updateUnlinkedReferences [
	"Update unlinked references the receiver may have to other pages.
	Subclasses that support unlinked references should call this when they are updated."

	LeUnlinkedReferenceMaintenance submitForBlock: self.
]

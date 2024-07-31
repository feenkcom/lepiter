Extension { #name : #GtRBRenameMethodRefactoring }

{ #category : #'*Lepiter-Core' }
GtRBRenameMethodRefactoring >> renameLepiterReferences [
	<gtRename>
	(LeSearchReferencesFilter new selector: oldSelector) contents
		do: [ :snippet | 
			(snippet changesToRenameSelector: oldSelector to: newSelector)
				do: [ :change | self model changes addChange: change ] ]
]

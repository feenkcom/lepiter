Extension { #name : #GtRBRenameMethodRefactoring }

{ #category : #'*Lepiter-Core' }
GtRBRenameMethodRefactoring >> renameLepiterReferences [
	<gtRename>
	(LeSearchReferencesFilter new selector: oldSelector) contents
		do: [ :snippet | 
			(snippet changeToRenameSelector: oldSelector to: newSelector)
				ifNotNil: [ :change | self model changes addChange: change ] ]
]

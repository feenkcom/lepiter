Extension { #name : #GtRBRenameClassRefactoring }

{ #category : #'*Lepiter-Core' }
GtRBRenameClassRefactoring >> renameLepiterReferences [
	<gtRename>
	(LeSearchClassReferencesFilter new name: className) contents
		do: [ :snippet | 
			(snippet changeToRenameClass: className to: newName)
				ifNotNil: [ :change | self model changes addChange: change ] ]
]

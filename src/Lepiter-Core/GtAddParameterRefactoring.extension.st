Extension { #name : #GtAddParameterRefactoring }

{ #category : #'*Lepiter-Core' }
GtAddParameterRefactoring >> renameLepiterReferences [
	<gtRename>
	(LeSearchReferencesFilter new selector: oldSelector) contents
		do: [ :snippet | 
			(snippet addParameterTo: oldSelector using: self parseTreeRewriter)
				ifNotNil: [ :change | self model changes addChange: change ] ]
]

Extension { #name : #GtRemoveParameterRefactoring }

{ #category : #'*Lepiter-Core' }
GtRemoveParameterRefactoring >> renameLepiterReferences [
	<gtRename>
	(LeSearchReferencesFilter new selector: oldSelector) contents
		do: [ :snippet | 
			(snippet removeParameterFrom: oldSelector using: self parseTreeRewriter)
				ifNotNil: [ :change | self model changes addChange: change ] ]
]

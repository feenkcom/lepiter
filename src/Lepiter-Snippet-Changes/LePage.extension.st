Extension { #name : #LePage }

{ #category : #'*Lepiter-Snippet-Changes' }
LePage >> allChangeSnippets [
	^ self deep: #children select: [ :child | child isKindOf: LeChangesSnippet ]
]

{ #category : #'*Lepiter-Snippet-Changes' }
LePage >> applyChanges [
	^ self allChangeSnippets
		do: [ :each | each asSnippetViewModel changes applyChanges ]
]

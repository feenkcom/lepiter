Extension { #name : #GtWardleyMapNodeModel }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapNodeModel >> menuItemLepiterLabel [
	<wardleyContextMenuItem: 30>
	^ GtWardleyMapLabelMenuItem new
		text: 'Knowledge base:';
		condition: [ :aContextMenuItem | aContextMenuItem wardleySnippetModel isNotNil ]
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapNodeModel >> menuItemNodeToLepiterPageLinker [
	<wardleyContextMenuItem: 31>
	^ LeWardleyMapNodeToPageMenuItem new
]

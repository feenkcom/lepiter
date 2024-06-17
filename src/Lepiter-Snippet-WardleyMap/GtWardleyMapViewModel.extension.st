Extension { #name : #GtWardleyMapViewModel }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapViewModel >> wardleySnippetModel [
	^ self optionAt: #wardleySnippetModel ifAbsent: [ nil ]
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapViewModel >> wardleySnippetModel: aLeWardleySnippetModel [
	self optionAt: #wardleySnippetModel put: aLeWardleySnippetModel
]

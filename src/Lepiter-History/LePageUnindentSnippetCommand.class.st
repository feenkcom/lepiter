Class {
	#name : #LePageUnindentSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History'
}

{ #category : #accessing }
LePageUnindentSnippetCommand class >> commandDescription [ 
	^ 'Unindent'
]

{ #category : #execution }
LePageUnindentSnippetCommand >> execute [ 
	self targetSnippet unindent
]

Class {
	#name : #LeSnippetCommandBuilder,
	#superclass : #LeCommandBuilder,
	#category : #'Lepiter-History'
}

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> createIndentCommand [ 
	^ LePageIndentSnippetCommand forSnippet: self
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> createRemoveCommand [ 
	^ LePageRemoveSnippetCommand forSnippet: self
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> createUnindentCommand [ 
	^ LePageUnindentSnippetCommand forSnippet: self
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> editSnippetCommand [ 
	self flag: 'Deletate though the snippet'.
	
	self targetContent isTextSnippet ifTrue: [ 
		^ LeEditTextSnippetCommand new
			targetContent: self targetContent ].
		
	^ LeEditGenericSnippetCommand new
		targetContent: self targetContent
]

{ #category : #accessing }
LeSnippetCommandBuilder >> targetSnippet [
	^ self targetContent
]

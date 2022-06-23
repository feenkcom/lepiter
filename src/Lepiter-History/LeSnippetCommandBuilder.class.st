Class {
	#name : #LeSnippetCommandBuilder,
	#superclass : #LeCommandBuilder,
	#category : #'Lepiter-History-Builders'
}

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> editSnippetCommand [ 
	self flag: 'Deletate though the snippet'.
	
	self targetContent isTextSnippet ifTrue: [ 
		^ LeEditTextSnippetCommand new
			targetContent: self targetContent ].
		
	^ LeEditGenericSnippetCommand new
		targetContent: self targetContent
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> indentSnippetCommand [ 
	^ LePageIndentSnippetCommand forSnippet: self
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> moveDownSnippetCommand [ 
	^ LePageMoveDownSnippetCommand forSnippet: self
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> moveUpSnippetCommand [ 
	^ LePageMoveUpSnippetCommand forSnippet: self
]

{ #category : #accessing }
LeSnippetCommandBuilder >> targetSnippet [
	^ self targetContent
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> unindentSnippetCommand [ 
	^ LePageUnindentSnippetCommand forSnippet: self
]

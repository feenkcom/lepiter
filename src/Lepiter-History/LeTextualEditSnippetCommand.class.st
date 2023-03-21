Class {
	#name : #LeTextualEditSnippetCommand,
	#superclass : #LeBasicEditSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeTextualEditSnippetCommand >> code: aString [ 
	self code: aString withSource: nil
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> code: aString withSource: aSource [
	self snippetState 
		addAttribute: ((LeTextualSnippetStringAttribute named: #code)
			string: aString;
			source: aSource)
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> string: aString [ 
	self string: aString withSource: nil
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> string: aString withSource: aSource [
	self snippetState 
		addAttribute: ((LeTextualSnippetStringAttribute named: #string)
			string: aString;
			source: aSource)
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> text: aText [ 
	self notYetImplemented 
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> text: aText withSource: aSource [
	self notYetImplemented 
]

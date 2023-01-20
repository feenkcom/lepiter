"
{{gtClass:LePageUnindentSnippetCommand}} unindents  the target snippet in its page by inserting it as a child its parent snippet. 

The target snippet is inserted as the next sibling of its parent snippet.

This command has no effect if the target snippet is a first level snippet (its parent is a page). In this case, if execution is requested the command leaves no trace in the edit log. 

The actual indentation is performed by {{gtMethod:name=LeSnippet>>unindent}}.
"
Class {
	#name : #LePageUnindentSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageUnindentSnippetCommand class >> commandDescription [ 
	^ 'Unindent'
]

{ #category : #execution }
LePageUnindentSnippetCommand >> basicExecute [ 
	self assert: [ self targetSnippet canBeUnindented ].
	
	^ self withUndoExecute: [ 
		| oldParent |
		oldParent := self targetSnippet parent.
		self targetSnippet unindent.
		
		self assert: oldParent ~= self targetSnippet parent ]
]

{ #category : #'execution - utils' }
LePageUnindentSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder indentSnippetCommand
]

{ #category : #accessing }
LePageUnindentSnippetCommand >> label [
	^ 'Unindent Snippet'
]

"
{{gtClass:LePageIndentSnippetCommand}} indents the target snippet in its page by making the target snippet a child of the previous snippet. 

If the previous snippet has no children, the target snippet becomes its first child. If the previous snippet has children, the target snippet is added as its last child.

This command has no effect if the target snippet has no previous snippet in the page (is the target snippet is the first child). In this case, if execution is requested the command leaves no trace in the edit log. 

The actual indentation is performed by {{gtMethod:name=LeSnippet>>indent}}.
"
Class {
	#name : #LePageIndentSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageIndentSnippetCommand class >> commandDescription [ 
	^ 'Indent Snippet'
]

{ #category : #execution }
LePageIndentSnippetCommand >> basicExecute [ 
	^ self withUndoExecute: [  
		self targetSnippet indent ]
]

{ #category : #'execution - utils' }
LePageIndentSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder unindentSnippetCommand
]

Class {
	#name : #LeIsolatedSnippetPhlowTool,
	#superclass : #LeSnippetPhlowTool,
	#category : 'Lepiter-UI-Phlow Tools'
}

{ #category : #'api - converting' }
LeIsolatedSnippetPhlowTool >> asElementDo: aOneArgBlock [
	| anElement |
	anElement := self snippet asToolElement.
	anElement selectionTransformation: [ :aNode |
		aNode value asPhlowTool ].
	anElement selectAndScrollTo: self snippet.
	^ aOneArgBlock cull: anElement
]

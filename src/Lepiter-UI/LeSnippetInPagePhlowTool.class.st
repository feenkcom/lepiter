Class {
	#name : #LeSnippetInPagePhlowTool,
	#superclass : #LeSnippetPhlowTool,
	#category : #'Lepiter-UI-Phlow Tools'
}

{ #category : #'api - converting' }
LeSnippetInPagePhlowTool >> asElementDo: aOneArgBlock [

	| anElement aPageViewModel |
	aPageViewModel := self snippet page asContentUIModel.

	anElement := LePageToolElement new
		             pageViewModel: aPageViewModel;
		             matchParent.

	anElement selectionTransformation: [ :aNode | 
		aNode value asPhlowTool ].
	anElement selectAndScrollTo: self snippet.
	^ aOneArgBlock cull: anElement
]

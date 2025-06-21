Class {
	#name : #GtSlideReorderingHandler,
	#superclass : #BlReorderingHandler,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-UI-Drag & Drop'
}

{ #category : #initialization }
GtSlideReorderingHandler >> initialize [
	super initialize.
	dragEndEventAction := [ :aBlDragEndEvent | 
		| newSlideOrder |
		newSlideOrder := (aBlDragEndEvent currentTarget parent query
				// LeSlideshowPageSlideGridElement) result collect: #snippet.
		newSlideOrder = self page type elementSnippets
			ifFalse: [ | copyOfSnippets currentElementSnippetIndex |
				currentElementSnippetIndex := 1.
				copyOfSnippets := self page children asArray.
				copyOfSnippets
					do: [ :aSnippet | self page children removeSnippet: aSnippet ].
				copyOfSnippets
					do: [ :aSnippet | 
						(aSnippet isKindOf: LeElementSnippet)
							ifTrue: [ self page basicAddSnippet: (newSlideOrder at: currentElementSnippetIndex).
								currentElementSnippetIndex := currentElementSnippetIndex + 1 ]
							ifFalse: [ self page basicAddSnippet: aSnippet ] ].
				self page announceTreeChanged: self page ] ]
]

{ #category : #accessing }
GtSlideReorderingHandler >> page [
	^ page
]

{ #category : #accessing }
GtSlideReorderingHandler >> page: aLePage [
	page := aLePage
]

Class {
	#name : #GtResizablePreviewAttribute,
	#superclass : #GtPreviewAttribute,
	#category : #'Lepiter-UI-Core-Text - Attributes'
}

{ #category : #accessing }
GtResizablePreviewAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ GtResizablePreviewStencil new
		result: self result;
		showSelector: self showSelector;
		height: self height;
		asElement
]

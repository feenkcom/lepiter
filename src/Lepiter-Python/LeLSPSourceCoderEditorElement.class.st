Class {
	#name : #LeLSPSourceCoderEditorElement,
	#superclass : #GtSourceCoderEditorElement,
	#category : #'Lepiter-Python-Snippet'
}

{ #category : #accessing }
LeLSPSourceCoderEditorElement >> defaultTextEditorModel [
	^ GtLSPEditorModel withEditorMode: self defaultTextEditorMode
]

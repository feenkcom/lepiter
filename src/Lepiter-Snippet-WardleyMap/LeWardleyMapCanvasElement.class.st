Class {
	#name : #LeWardleyMapCanvasElement,
	#superclass : #GtWardleyMapCanvasElement,
	#instVars : [
		'snippet'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Helpers'
}

{ #category : #initialization }
LeWardleyMapCanvasElement >> createNodeEditorFor: aNodeViewModel [
	^ LeWardleyMapNodeEditorElement new
		wardleyMapViewModel: self wardleyMapViewModel;
		wardleyMapNodeViewModel: aNodeViewModel;
		snippet: self snippet;
		canvasElement: self
]

{ #category : #accessing }
LeWardleyMapCanvasElement >> snippet [
	^ snippet
]

{ #category : #accessing }
LeWardleyMapCanvasElement >> snippet: anObject [
	snippet := anObject
]

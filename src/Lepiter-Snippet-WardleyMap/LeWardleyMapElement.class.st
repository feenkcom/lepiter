Class {
	#name : #LeWardleyMapElement,
	#superclass : #GtWardleyMapElement,
	#instVars : [
		'snippet'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Helpers'
}

{ #category : #initialization }
LeWardleyMapElement >> createCanvasElement [
	^ LeWardleyMapCanvasElement new
]

{ #category : #accessing }
LeWardleyMapElement >> snippet [
	^ snippet
]

{ #category : #accessing }
LeWardleyMapElement >> snippet: anObject [
	snippet := anObject.
	canvasElement snippet: anObject
]

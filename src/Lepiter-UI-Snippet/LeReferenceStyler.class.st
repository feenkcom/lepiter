Class {
	#name : #LeReferenceStyler,
	#superclass : #LeSnippetStyler,
	#instVars : [
		'referencedPage'
	],
	#category : 'Lepiter-UI-Snippet-Text styler'
}

{ #category : #accessing }
LeReferenceStyler >> referencedPage [
	^ referencedPage
]

{ #category : #accessing }
LeReferenceStyler >> referencedPage: aLePage [
	referencedPage := aLePage
]

{ #category : #private }
LeReferenceStyler >> visitorForText: aText [
	^ (super visitorForText: aText) referencedPage: referencedPage
]

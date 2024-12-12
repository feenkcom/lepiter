Class {
	#name : #LePageTitleStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'pageViewModel'
	],
	#category : #'Lepiter-UI-Page-! Views'
}

{ #category : #accessing }
LePageTitleStyler >> pageViewModel [
	^ pageViewModel
]

{ #category : #accessing }
LePageTitleStyler >> pageViewModel: anObject [
	pageViewModel := anObject
]

{ #category : #accessing }
LePageTitleStyler >> privateStyle: aText [
	| buttonsAttribute |
	buttonsAttribute := {LePageTitleButtonsAttribute new
				pageViewModel: self pageViewModel}.
	
	aText
		attributes: buttonsAttribute
		from: ((aText size - 1) max: 0)
		to: aText size.
	((pageViewModel database hasPageNamed: aText asString)
		and: [ (pageViewModel pageTitle = aText asString) not ])
		ifTrue: [ aText highlight: (BrGlamorousColors errorBackgroundColor alpha: 0.5) ]
		ifFalse: [ aText ].
	^ aText
]

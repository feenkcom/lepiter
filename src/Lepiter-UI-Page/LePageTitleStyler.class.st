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
	aText asString = pageViewModel pageTitle
		ifTrue: [ ^ aText ]
		ifFalse: [ ^ aText highlight: (BrGlamorousColors errorBackgroundColor alpha: 0.5) ]
]

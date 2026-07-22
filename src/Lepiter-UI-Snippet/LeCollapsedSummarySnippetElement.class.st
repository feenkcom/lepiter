Class {
	#name : #LeCollapsedSummarySnippetElement,
	#superclass : #BrVerticalPane,
	#traits : 'TLeWithSnippetViewModel',
	#classTraits : 'TLeWithSnippetViewModel classTrait',
	#instVars : [
		'label'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #accessing }
LeCollapsedSummarySnippetElement >> initialize [
	super initialize.
	self hMatchParent.
	self vFitContent.
	label := BrLabel new.
	label
		hMatchParent;
		vFitContent;
		aptitude: BrGlamorousLabelAptitude;
		text: '' asRopedText.
	self addChild: label
]

{ #category : #accessing }
LeCollapsedSummarySnippetElement >> onSnippetViewModelChanged [
	self updateLabel
]

{ #category : #accessing }
LeCollapsedSummarySnippetElement >> updateLabel [
	snippetViewModel
		ifNotNil: [ snippetViewModel collapsedTextPromise
				then: [ :text | label inUIProcessDo: [ label text: text ] ] ]
]

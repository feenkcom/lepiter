Class {
	#name : #LeFileSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'contentElement',
		'form'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #accessing }
LeFileSnippetElement >> go [
	| file bindingName sharedBindings binding |
	file := form fileReference asFileReference.
	bindingName := form bindingName.
	sharedBindings := self snippetViewModel snippetBindings.
	binding := sharedBindings bindingOf: bindingName asSymbol.
	binding value: file.
	^ "bindingName ->" file
]

{ #category : #initalization }
LeFileSnippetElement >> initialize [
	| formElement indicatorElement |
	super initialize.
	
	form := LeFileResourcePane new.
	form
		acceptAction: [ self go ];
		inspectAction: [ :model :element | element phlow spawnObject: self go ].
		
	formElement := form asElement margin: (BlInsets all: 10).
	formElement
		constraintsDo: [ :c | 
			c frame horizontal alignLeft.
			c frame vertical alignTop ].
	formElement hMatchParent.
	
	indicatorElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularSmallSize
		foreground: BrGlamorousColors textMarkupColor);
		margin: (BlInsets top: 5 right: 5);
		text: 'File Resourece'.
	indicatorElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].
		
	contentElement := BrFrame new
		hMatchParent;
		vFitContent;
		addChildren: { formElement. indicatorElement } 
]

{ #category : #accessing }
LeFileSnippetElement >> snippetContent [
	^ contentElement
]

{ #category : #accessing }
LeFileSnippetElement >> snippetToolbar [
	^ nil
]

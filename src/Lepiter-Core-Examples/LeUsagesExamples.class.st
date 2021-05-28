Class {
	#name : #LeUsagesExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #accessing }
LeUsagesExamples >> basicPlaygroundWithOneSnippet [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: (LePharoSnippet code:'classes := BrStencil withAllSubclasses.').
	self assert: page children size = 1.
	^ page
]

{ #category : #accessing }
LeUsagesExamples >> basicPlaygroundWithTwoSnippets [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: (LePharoSnippet code:'classes := BrStencil withAllSubclasses.').
	page addSnippet: (LePharoSnippet code:'view := GtMondrian new.
view nodes with: classes.
view edges connectFrom: #superclass.
view layout tree nodeDistance: 1.
view').
	self assert: page children size = 2.
	^ page
]

{ #category : #accessing }
LeUsagesExamples >> basicPlaygroundWithTwoSnippetsAndText [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: (LePharoSnippet code:'classes := BrStencil withAllSubclasses.').
	page addSnippet: (LeTextSnippet string:'The following snippet visualizes the subclasses of {{gtClass:BrStencil}}').
	page addSnippet: (LePharoSnippet code:'view := GtMondrian new.
view nodes with: classes.
view edges connectFrom: #superclass.
view layout tree nodeDistance: 1.
view').
	self assert: page children size = 3.
	^ page
]

{ #category : #accessing }
LeUsagesExamples >> playgroundWithQuery [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: (LePharoSnippet code:'#gtView gtPragmas & #list gtReferences').
	self assert: page children size = 1.
	^ page
]

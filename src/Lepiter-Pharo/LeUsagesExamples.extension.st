Extension { #name : #LeUsagesExamples }

{ #category : #'*Lepiter-Pharo' }
LeUsagesExamples >> basicPlaygroundWithOneSnippet [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: (LePharoSnippet code:'classes := BrStencil withAllSubclasses.').
	self assert: page children size = 1.
	^ page
]

{ #category : #'*Lepiter-Pharo' }
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

{ #category : #'*Lepiter-Pharo' }
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

{ #category : #'*Lepiter-Pharo' }
LeUsagesExamples >> playgroundWithQuery [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: (LePharoSnippet code:'#gtView gtPragmas & #list gtReferences').
	self assert: page children size = 1.
	^ page
]

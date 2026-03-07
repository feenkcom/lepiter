"
Examples for gtPragma annotation styling.
"
Class {
	#name : #LePragmaAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #examples }
LePragmaAnnotationStylerExamples >> assertForegroundOfButtonLabel: text hasColor: color [
	| buttonLabel scripter buttonAttribute buttonElement attributes |
	attributes := text attributesAt: 1.
	buttonAttribute := attributes
			detect: [ :each | each class = GtButtonAttribute ]
			ifNone: [ self assert: false description: 'Missing button attribute' ].
	buttonElement := buttonAttribute stencil asElement.
	scripter := BlScripter new element: buttonElement.
	buttonLabel := scripter elementWithoutParent label.
	self assertForegroundOfText: buttonLabel hasColor: color
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> assertForegroundOfText: text hasColor: expectedColor [
	| textColor foregroundAttribute attributes |
	attributes := text attributesAt: 1.
	foregroundAttribute := attributes
			detect: [ :each | each class = BlTextForegroundAttribute ]
			ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	textColor := foregroundAttribute paint.
	self assert: textColor equals: expectedColor
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> attributesOfExistingPragmaAnnotation [
	<gtExample>
	<return: #BlText>
	| text attributes |
	text := self textOfSnippetWithPragmaAnnotation.
	attributes := text attributesAt: 1.
	self
		assert: (attributes anySatisfy: [ :each | each class = BrTextAdornmentDynamicAttribute ]).
	self
		assert: (attributes
				anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]).
	self assertForegroundOfText: text hasColor: (Color black alpha: 0.6).
	self
		assertForegroundOfButtonLabel: text
		hasColor: BrGlamorousColors linkColor.
	^ attributes
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> styleExpandedPragmaAnnotation [
	<gtExample>
	<return: #BlText>
	| text attributes expandedAttribute |
	text := self textOfSnippetWithExpandedPragmaAnnotation.
	attributes := text attributesAt: 1.
	self assertForegroundOfText: text hasColor: BrGlamorousColors textMarkupColor.
	self
		assert: (attributes anySatisfy: [ :each | each class = BrTextAdornmentDynamicAttribute ]).
	self
		assert: (attributes
				anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]).

	expandedAttribute := attributes
			detect: [ :each | each class = GtCachedTextExpandButtonAttribute ]
			ifNone: [ self assert: false description: 'Missing expanded attribute' ].
	self assert: expandedAttribute isExpanded.

	self assertForegroundOfButtonLabel: text hasColor: BrGlamorousColors linkColor.

	^ text
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> styleMissingPragmaAnnotation [
	<gtExample>
	<return: #BlText>
	| attributes text |
	text := self textOfSnippetWithMissingPragmaAnnotation.
	attributes := text attributesAt: 1.

	self
		assertForegroundOfText: text
		hasColor: BrGlamorousColors linkWithErrorColor.

	self
		assert: (attributes anySatisfy: [ :each | each class = BrTextAdornmentDynamicAttribute ]).
	self
		assert: (attributes
				anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]) not.

	self
		assertForegroundOfButtonLabel: text
		hasColor: BrGlamorousColors linkWithErrorColor.

	^ text
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> textOfSnippetWithExpandedPragmaAnnotation [
	<gtExample>
	| string text annotation snippetViewModel styler snippet anAst |
	string := '{{gtPragma:gtView|expanded=true}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LePragmaAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^ text
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> textOfSnippetWithMissingPragmaAnnotation [
	<gtExample>
	| string text annotation snippetViewModel styler snippet anAst |
	string := '{{gtPragma:doesNotExistPragma}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LePragmaAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^ text
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> textOfSnippetWithPragmaAnnotation [
	<gtExample>
	| string text annotation snippetViewModel styler snippet anAst |
	string := '{{gtPragma:gtView}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LePragmaAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^ text
]

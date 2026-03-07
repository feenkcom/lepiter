"
Examples for gtPragma annotation styling.
"
Class {
	#name : #LePragmaAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #examples }
LePragmaAnnotationStylerExamples >> styleExistingPragmaAnnotation [
	<gtExample>
	<return: #BlText>
	| string anAst text styler snippet snippetViewModel annotation attributes foregroundAttribute textColor buttonAttribute buttonElement scripter buttonLabel buttonColor buttonLabelAttributes buttonLabelForegroundAttribute |
	string := '{{gtPragma:gtView}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LePragmaAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	
	attributes := text attributesAt: annotation parent startPosition.
	foregroundAttribute := attributes
			detect: [ :each | each class = BlTextForegroundAttribute ]
			ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	textColor := foregroundAttribute paint.
	self assert: textColor red equals: 0.0.
	self assert: textColor green equals: 0.0.
	self assert: textColor blue equals: 0.0.
	self assert: textColor alpha equals: 0.6.

	self assert: (attributes 
				anySatisfy: [ :each | each class = BrTextAdornmentDynamicAttribute ]).
	self assert: (attributes
				anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]).

	buttonAttribute := attributes
			detect: [ :each | each class = GtButtonAttribute ]
			ifNone: [ self assert: false description: 'Missing button attribute' ].
	buttonElement := buttonAttribute stencil asElement.
	scripter := BlScripter new element: buttonElement.
	buttonLabel := scripter elementWithoutParent label.
	buttonLabelAttributes := buttonLabel attributesAt: annotation parent startPosition.
	buttonLabelForegroundAttribute := buttonLabelAttributes
			detect: [ :each | each class = BlTextForegroundAttribute ]
			ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	buttonColor := buttonLabelForegroundAttribute paint.
	self assert: buttonColor equals: BrGlamorousColors linkColor.

	^ text
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> styleExpandedPragmaAnnotation [
	<gtExample>
	<return: #BlText>
	
		| string anAst text styler snippet snippetViewModel annotation attributes foregroundAttribute textColor buttonAttribute buttonElement scripter buttonLabel buttonColor buttonLabelAttributes buttonLabelForegroundAttribute expandedAttribute |
	string := '{{gtPragma:gtView|expanded=true}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LePragmaAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	
	attributes := text attributesAt: annotation parent startPosition.
	foregroundAttribute := attributes
			detect: [ :each | each class = BlTextForegroundAttribute ]
			ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	textColor := foregroundAttribute paint.
	self assert: textColor red equals: 0.0.
	self assert: textColor green equals: 0.0.
	self assert: textColor blue equals: 0.0.
	self assert: textColor alpha equals: 0.6.

	self assert: (attributes 
				anySatisfy: [ :each | each class = BrTextAdornmentDynamicAttribute ]).
	self assert: (attributes
				anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]).

	expandedAttribute := attributes
			detect: [ :each | each class = GtCachedTextExpandButtonAttribute ]
			ifNone: [ self assert: false description: 'Missing expanded attribute' ].
	self assert: expandedAttribute isExpanded.

				
	buttonAttribute := attributes
			detect: [ :each | each class = GtButtonAttribute ]
			ifNone: [ self assert: false description: 'Missing button attribute' ].
	buttonElement := buttonAttribute stencil asElement.
	scripter := BlScripter new element: buttonElement.
	buttonLabel := scripter elementWithoutParent label.
	buttonLabelAttributes := buttonLabel attributesAt: annotation parent startPosition.
	buttonLabelForegroundAttribute := buttonLabelAttributes
			detect: [ :each | each class = BlTextForegroundAttribute ]
			ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	buttonColor := buttonLabelForegroundAttribute paint.
	self assert: buttonColor equals: BrGlamorousColors linkColor.

	^ text
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> styleMissingPragmaAnnotation [
	<gtExample>
	<return: #BlText>
	| string anAst text styler snippet snippetViewModel annotation attributes foregroundAttribute textColor buttonAttribute buttonElement scripter buttonLabel buttonColor buttonLabelAttributes buttonLabelForegroundAttribute |
	string := '{{gtPragma:doesNotExistPragma}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LePragmaAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	
	attributes := text attributesAt: annotation parent startPosition.
	foregroundAttribute := attributes
			detect: [ :each | each class = BlTextForegroundAttribute ]
			ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	textColor := foregroundAttribute paint.
	self assert: textColor equals: BrGlamorousColors linkWithErrorColor.

	self assert: (attributes 
				anySatisfy: [ :each | each class = BrTextAdornmentDynamicAttribute ]).
	self assert: (attributes
				anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]) not.

	buttonAttribute := attributes
			detect: [ :each | each class = GtButtonAttribute ]
			ifNone: [ self assert: false description: 'Missing button attribute' ].
	buttonElement := buttonAttribute stencil asElement.
	scripter := BlScripter new element: buttonElement.
	buttonLabel := scripter elementWithoutParent label.
	buttonLabelAttributes := buttonLabel attributesAt: annotation parent startPosition.
	buttonLabelForegroundAttribute := buttonLabelAttributes
			detect: [ :each | each class = BlTextForegroundAttribute ]
			ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	buttonColor := buttonLabelForegroundAttribute paint.
	self assert: buttonColor equals: BrGlamorousColors linkWithErrorColor.

	^ text
]

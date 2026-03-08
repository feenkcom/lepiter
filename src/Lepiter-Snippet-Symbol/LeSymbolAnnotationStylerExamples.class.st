"
Examples for gtSymbol annotation styling.
"
Class {
	#name : #LeSymbolAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #asserting }
LeSymbolAnnotationStylerExamples >> assertForegroundOfButtonLabel: text hasColor: color [
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

{ #category : #asserting }
LeSymbolAnnotationStylerExamples >> assertForegroundOfText: text hasColor: expectedColor [
	| textColor foregroundAttribute attributes |
	attributes := text attributesAt: 1.
	foregroundAttribute := attributes
		detect: [ :each | each class = BlTextForegroundAttribute ]
		ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	textColor := foregroundAttribute paint.
	self assert: textColor equals: expectedColor
]

{ #category : #examples }
LeSymbolAnnotationStylerExamples >> styleExistingSymbolAnnotation [
	<gtExample>
	<return: #BlText>
	| text attributes |
	text := self textOfSnippetWithSymbolAnnotation.
	attributes := text attributesAt: 1.
	self assertForegroundOfText: text hasColor: BrGlamorousColors textMarkupColor.
	self assert: (attributes anySatisfy: [ :each | each class = GtButtonAttribute ]).
	self assertForegroundOfButtonLabel: text hasColor: BrGlamorousColors linkColor.
	^ text
]

{ #category : #examples }
LeSymbolAnnotationStylerExamples >> styleMissingSymbolAnnotation [
	<gtExample>
	<return: #BlText>
	| text attributes |
	text := self textOfSnippetWithMissingSymbolAnnotation.
	attributes := text attributesAt: 1.
	self assertForegroundOfText: text hasColor: BrGlamorousColors textMarkupColor.
	self assert: (attributes anySatisfy: [ :each | each class = GtButtonAttribute ]).
	self assert: (attributes anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]).
	self assertForegroundOfButtonLabel: text hasColor: BrGlamorousColors linkColor.
	^ text
]

{ #category : #examples }
LeSymbolAnnotationStylerExamples >> textOfSnippetWithMissingSymbolAnnotation [
	<gtExample>
	| string text annotation snippetViewModel styler snippet anAst uuidString |
	uuidString := UUID new asString36.
	string := '{{gtSymbol:gtSymbolMissing' , uuidString , '}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LeSymbolAnnotationNode) anyOne.
	self assert: annotation notNil.
	self assert: annotation isDefined not.
	self
		assert: annotation symbolName
		equals: 'gtSymbolMissing' , uuidString.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^ text
]

{ #category : #examples }
LeSymbolAnnotationStylerExamples >> textOfSnippetWithSymbolAnnotation [
	<gtExample>
	| string text annotation snippetViewModel styler snippet anAst |
	string := '{{gtSymbol:asString}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LeSymbolAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^ text
]

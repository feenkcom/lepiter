"
Examples for gtWordExplanation annotation styling.
"
Class {
	#name : #LeWordAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Words'
}

{ #category : #asserting }
LeWordAnnotationStylerExamples >> assertForegroundOfButtonLabel: text hasColor: color [
	| buttonLabel buttonAttribute attributes |
	attributes := (1 to: text size)
		detect: [ :index | (text attributesAt: index) anySatisfy: [ :each | each class = GtButtonAttribute ] ]
		ifFound: [ :index | text attributesAt: index ]
		ifNone: [ self assert: false description: 'Missing button attribute' ].
	buttonAttribute := attributes
		detect: [ :each | each class = GtButtonAttribute ].
	buttonLabel := (BlScripter new element: buttonAttribute stencil asElement) elementWithoutParent label.
	self assertForegroundOfText: buttonLabel hasColor: color
]

{ #category : #asserting }
LeWordAnnotationStylerExamples >> assertForegroundOfText: text hasColor: expectedColor [
	| textColor foregroundAttribute attributes |
	attributes := text attributesAt: 1.
	foregroundAttribute := attributes
		detect: [ :each | each class = BlTextForegroundAttribute ]
		ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	textColor := foregroundAttribute paint.
	self assert: textColor equals: expectedColor
]

{ #category : #asserting }
LeWordAnnotationStylerExamples >> assertNoForegroundOfText: text [
	| attributes |
	attributes := text attributesAt: 1.
	self assert: (attributes anySatisfy: [ :each | each class = BlTextForegroundAttribute ]) not
]

{ #category : #examples }
LeWordAnnotationStylerExamples >> styleExistingWordAnnotation [
	<gtExample>
	<return: #BlText>
	| text attributes |
	text := self textOfSnippetWithWordAnnotation.
	attributes := text attributesAt: 1.

	self assertForegroundOfText: text hasColor: BrGlamorousColors textMarkupColor.
	self assert: (attributes anySatisfy: [ :each | each class = BrTextAdornmentDynamicAttribute ]).
	self assert: (attributes anySatisfy: [ :each | each class = GtButtonAttribute ]).
	self assert: (attributes anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]).
	self assertForegroundOfButtonLabel: text hasColor: BrGlamorousColors linkColor.

	^ text
]

{ #category : #examples }
LeWordAnnotationStylerExamples >> styleExpandedWordAnnotation [
	<gtExample>
	<return: #BlText>
	| text attributes expandedAttribute |
	text := self textOfSnippetWithExpandedWordAnnotation.
	attributes := text attributesAt: 1.

	self assertForegroundOfText: text hasColor: BrGlamorousColors textMarkupColor.
	self assert: (attributes anySatisfy: [ :each | each class = BrTextAdornmentDynamicAttribute ]).
	self assert: (attributes anySatisfy: [ :each | each class = GtButtonAttribute ]).
	self assert: (attributes anySatisfy: [ :each | each class = GtCachedTextExpandButtonAttribute ]).
	expandedAttribute := attributes
		detect: [ :each | each class = GtCachedTextExpandButtonAttribute ]
		ifNone: [ self assert: false description: 'Missing expanded attribute' ].
	self assert: expandedAttribute isExpanded.
	self assertForegroundOfButtonLabel: text hasColor: BrGlamorousColors linkColor.

	^ text
]

{ #category : #examples }
LeWordAnnotationStylerExamples >> styleMissingWordAnnotation [
	<gtExample>
	<return: #BlText>
	| text attributes |
	text := self textOfSnippetWithMissingWordAnnotation.
	attributes := text attributesAt: 1.

	self assertNoForegroundOfText: text.
	self assert: (attributes anySatisfy: [ :each | each class = GtButtonAttribute ]) not.

	^ text
]

{ #category : #examples }
LeWordAnnotationStylerExamples >> styler [
	<gtExample>
	<return: #LeWordAnnotationStyler>
	^ LeWordAnnotationStyler new
]

{ #category : #examples }
LeWordAnnotationStylerExamples >> textOfSnippetWithExpandedWordAnnotation [
	<gtExample>
	| string text annotation snippetViewModel styler snippet anAst |
	string := '{{gtWordExplanation:toolkit|expanded|height=200}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LeWordAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	snippetViewModel optionAt: #wordDictionary put: LeWordDictionaryMock new.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^ text
]

{ #category : #examples }
LeWordAnnotationStylerExamples >> textOfSnippetWithMissingWordAnnotation [
	<gtExample>
	| string text snippetViewModel styler snippet anAst |
	string := '{{gtWordExplanation:}}'.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	snippetViewModel optionAt: #wordDictionary put: LeWordDictionaryMock new.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	anAst := LeParser parseWithErrors: string.
	styler style: text ast: anAst.
	^ text
]

{ #category : #examples }
LeWordAnnotationStylerExamples >> textOfSnippetWithWordAnnotation [
	<gtExample>
	| string text annotation snippetViewModel styler snippet anAst |
	string := '{{gtWordExplanation:toolkit}}'.
	anAst := LeParser parse: string.
	annotation := (anAst // LeWordAnnotationNode) anyOne.
	self assert: annotation notNil.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	snippetViewModel optionAt: #wordDictionary put: LeWordDictionaryMock new.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^ text
]

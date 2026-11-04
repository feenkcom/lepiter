"
Examples for initial Markdown delimiter hiding and cursor-driven revealing in LeSnippetStylerVisitor.
"
Class {
	#name : #LeSnippetStylerVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Examples'
}

{ #category : #asserting }
LeSnippetStylerVisitorExamples >> assertDelimitersIn: source size: delimiterSize showMarkup: showMarkup [
	| text styler visitor delimiterIndices contentIndices editor cursorAttribute |
	text := source asRopedText.
	styler := LeSnippetStyler new
			snippetViewModel: LeTextSnippet new asSnippetViewModel;
			showMarkup: showMarkup;
			yourself.
	visitor := styler visitorForText: text.
	visitor
		styleAutoHiding: (1 to: delimiterSize)
		and: (text size - delimiterSize + 1 to: text size)
		whenOutside: (1 to: text size).
	delimiterIndices := (1 to: delimiterSize)
			, (text size - delimiterSize + 1 to: text size).
	contentIndices := delimiterSize + 1 to: text size - delimiterSize.
	delimiterIndices
		do: [ :index | 
			self
				assert: ((text attributesAt: index)
						anySatisfy: [ :attribute | 
							(attribute isKindOf: BrTextAdornmentDynamicAttribute)
								and: [ attribute shouldReplace ] ])
				equals: showMarkup not ].
	contentIndices
		do: [ :index | 
			self
				assert: ((text attributesAt: index)
						anySatisfy: [ :attribute | attribute isKindOf: BrTextAdornmentDynamicAttribute ])
						not ].
	self assert: text asString equals: source.
	showMarkup
		ifTrue: [ self
				assert: (text
						hasAttributeSuchThat: [ :attribute | attribute isKindOf: BrTextCursorDynamicAttribute ])
						not.
			^ text ].
	text
		findAttributesSuchThat: [ :attribute | attribute isKindOf: BrTextCursorDynamicAttribute ]
		indicesDo: [ :start :end :attribute | cursorAttribute := attribute ].
	self assert: cursorAttribute notNil.
	editor := BrEditor new
			text: text;
			yourself.
	editor cursors add: (BrTextEditorSingleCursor at: delimiterSize + 1).
	cursorAttribute enterAction value: editor.
	self
		assert: (text
				hasAttributeSuchThat: [ :attribute | 
					(attribute isKindOf: BrTextAdornmentDynamicAttribute)
						and: [ attribute shouldReplace ] ]) not.
	editor cursors first position: 0.
	cursorAttribute leaveAction value: editor.
	delimiterIndices
		do: [ :index | 
			self
				assert: ((text attributesAt: index)
						anySatisfy: [ :attribute | 
							(attribute isKindOf: BrTextAdornmentDynamicAttribute)
								and: [ attribute shouldReplace ] ]) ].
	self assert: text asString equals: source.
	^ text
]

{ #category : #examples }
LeSnippetStylerVisitorExamples >> boldDelimitersAreHiddenInitially [
	<gtExample>
	<return: #BlText>
	^ self
		assertDelimitersIn: '**something**'
		size: 2
		showMarkup: false
]

{ #category : #examples }
LeSnippetStylerVisitorExamples >> doubleBacktickCodeDelimitersAreHiddenInitially [
	<gtExample>
	<return: #BlText>
	^ self
		assertDelimitersIn: '``something``'
		size: 2
		showMarkup: false
]

{ #category : #examples }
LeSnippetStylerVisitorExamples >> inlineCodeDelimitersAreHiddenInitially [
	<gtExample>
	<return: #BlText>
	^ self
		assertDelimitersIn: '`something`'
		size: 1
		showMarkup: false
]

{ #category : #examples }
LeSnippetStylerVisitorExamples >> italicDelimitersAreHiddenInitially [
	<gtExample>
	<return: #BlText>
	^ self
		assertDelimitersIn: '*something*'
		size: 1
		showMarkup: false
]

{ #category : #examples }
LeSnippetStylerVisitorExamples >> showMarkupKeepsDelimitersVisible [
	<gtExample>
	<return: #BlText>
	^ self
		assertDelimitersIn: '**something**'
		size: 2
		showMarkup: true
]

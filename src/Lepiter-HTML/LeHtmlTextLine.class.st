"
One line of a text snippet as seen by {{gtClass:LeHtmlTextSnippetVisitor}} when it looks for list items and blockquotes.

The Lepiter parser ({{gtClass:LeParser}}) has no nodes for lists or quotes: `1. one`, `- one` and `> one` are plain {{gtClass:LeTextNode}} instances separated by end-of-line text nodes. This class keeps what the visitor needs to write the HTML: the `kind` (#plain, #ol, #ul or #quote), the text left after the list or quote marker (`prefixText`), the remaining parsed `nodes`, the nodes that were consumed by the marker (`droppedNodes`), the end-of-line node that ended the line (`eol`, nil for the last line) and, for ordered items, the `number` written in the text.
"
Class {
	#name : #LeHtmlTextLine,
	#superclass : #Object,
	#instVars : [
		'kind',
		'prefixText',
		'nodes',
		'droppedNodes',
		'eol',
		'number'
	],
	#category : #'Lepiter-HTML'
}

{ #category : #'instance creation' }
LeHtmlTextLine class >> nodes: aCollection eol: anEolNodeOrNil [
	"Answer the line made of the given nodes. The kind of the line comes from its first node: a `>` is a quote, `- ` a bullet and `N. ` a numbered item. Anything else, also text that only contains those characters further inside, is plain."

	| line first content second digitCount |
	line := self new
			kind: #plain;
			nodes: aCollection;
			eol: anEolNodeOrNil;
			yourself.
	aCollection isEmpty ifTrue: [ ^ line ].
	first := aCollection first.
	(first isKindOf: LeTextNode) ifFalse: [ ^ line ].
	content := first content.
	content = '>'
		ifTrue: [ line kind: #quote.
			(aCollection size >= 2
				and: [ (second := aCollection at: 2) isKindOf: LeTextNode ])
				ifTrue: [ line
						prefixText: second content trimLeft;
						droppedNodes: {first.
								second};
						nodes: (aCollection allButFirst: 2) ]
				ifFalse: [ line
						droppedNodes: {first};
						nodes: aCollection allButFirst ].
			^ line ].
	(content size >= 2
		and: [ content first = $- and: [ content second isSeparator ] ])
		ifTrue: [ ^ line
				kind: #ul;
				prefixText: content allButFirst trimLeft;
				droppedNodes: {first};
				nodes: aCollection allButFirst;
				yourself ].
	digitCount := 0.
	[ digitCount < content size and: [ (content at: digitCount + 1) isDigit ] ]
		whileTrue: [ digitCount := digitCount + 1 ].
	(digitCount > 0
		and: [ content size > (digitCount + 1)
				and: [ (content at: digitCount + 1) = $.
						and: [ (content at: digitCount + 2) isSeparator ] ] ])
		ifTrue: [ ^ line
				kind: #ol;
				number: (content first: digitCount) asInteger;
				prefixText: (content allButFirst: digitCount + 1) trimLeft;
				droppedNodes: {first};
				nodes: aCollection allButFirst;
				yourself ].
	^ line
]

{ #category : #accessing }
LeHtmlTextLine >> droppedNodes [
	"The nodes replaced by the marker and the prefix text. They are not written as they are."

	^ droppedNodes ifNil: [ #() ]
]

{ #category : #accessing }
LeHtmlTextLine >> droppedNodes: aCollection [
	droppedNodes := aCollection
]

{ #category : #accessing }
LeHtmlTextLine >> eol [
	"The end-of-line node that ended this line, nil for the last line."

	^ eol
]

{ #category : #accessing }
LeHtmlTextLine >> eol: aNodeOrNil [
	eol := aNodeOrNil
]

{ #category : #testing }
LeHtmlTextLine >> isEmpty [
	"True when nothing is left to write for this line."

	^ self prefixText isEmpty and: [ self nodes isEmpty ]
]

{ #category : #testing }
LeHtmlTextLine >> isPlain [
	^ kind = #plain
]

{ #category : #accessing }
LeHtmlTextLine >> kind [
	^ kind
]

{ #category : #accessing }
LeHtmlTextLine >> kind: aSymbol [
	kind := aSymbol
]

{ #category : #accessing }
LeHtmlTextLine >> nodes [
	"The parsed nodes still to be written after the prefix text."

	^ nodes ifNil: [ #() ]
]

{ #category : #accessing }
LeHtmlTextLine >> nodes: aCollection [
	nodes := aCollection
]

{ #category : #accessing }
LeHtmlTextLine >> number [
	"The number written in front of an ordered item."

	^ number
]

{ #category : #accessing }
LeHtmlTextLine >> number: anInteger [
	number := anInteger
]

{ #category : #accessing }
LeHtmlTextLine >> prefixText [
	"The text written before the remaining nodes (what is left of the first text node after the marker)."

	^ prefixText ifNil: [ '' ]
]

{ #category : #accessing }
LeHtmlTextLine >> prefixText: aString [
	prefixText := aString
]

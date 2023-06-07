Class {
	#name : #LeHtmlOutputPrettyStream,
	#superclass : #ZnHtmlOutputStream,
	#instVars : [
		'indent',
		'allowIndent'
	],
	#category : #'Lepiter-HTML-Streams'
}

{ #category : #'private - html' }
LeHtmlOutputPrettyStream >> closeTag: tag [
	self decreaseIndent.
	self newLine.
	self indent.
	super closeTag: tag.
	self newLine.
]

{ #category : #streaming }
LeHtmlOutputPrettyStream >> cr [
	stream cr
]

{ #category : #'private - indent' }
LeHtmlOutputPrettyStream >> decreaseIndent [
	indent := indent - 1
]

{ #category : #'private - indent' }
LeHtmlOutputPrettyStream >> doOneIndent [
	stream nextPutAll: '  '
]

{ #category : #'private - indent' }
LeHtmlOutputPrettyStream >> increaseIndent [
	indent := indent + 1
]

{ #category : #'private - indent' }
LeHtmlOutputPrettyStream >> indent [
	allowIndent ifFalse: [ ^ self ].
	indent timesRepeat: [ self doOneIndent ]
]

{ #category : #initiailize }
LeHtmlOutputPrettyStream >> initialize [
	super initialize.

	indent := 0.
	allowIndent := true.
]

{ #category : #'html tags' }
LeHtmlOutputPrettyStream >> inlineTag: tag attributes: attributePairs [
	"Write a standalone, self closing HTML tag with attributes, a collection of alternating keys and values"

	"<tag attr1=""value1"" ... attrN=""valueN""/>"

	self noIndentDo: [ 
		self 
			tag: tag 
			attributes: attributePairs 
	]
]

{ #category : #'html tags' }
LeHtmlOutputPrettyStream >> inlineTag: tag attributes: attributePairs do: block [
	"Write an HTML tag with attributes, a collection of alternating keys and values, executing block to generate enclosed content"

	"<tag attr1=""value1"" ... attrN=""valueN""> ... </tag>"

	self noIndentDo: [ 
		self 
			tag: tag 
			attributes: attributePairs 
			do: block
	]
]

{ #category : #'html tags' }
LeHtmlOutputPrettyStream >> inlineTag: tag attributes: attributePairs with: string [
	"Write an HTML tag with attributes, a collection of alternating keys and values, using the escaped string as content"

	"<tag attr1=""value1"" ... attrN=""valueN"">string</tag>"

	self noIndentDo: [ 
		self 
			tag: tag 
			attributes: attributePairs 
			with: string
	]
]

{ #category : #'html tags' }
LeHtmlOutputPrettyStream >> inlineTag: tag class: cssClass do: block [
	"Write an HTML tag with class cssClass, executing block to generate enclosed content"

	"<tag class=""cssClass""> ... </tag>"

	self noIndentDo: [ 
		self 
			tag: tag 
			class: cssClass 
			do: block
	]
]

{ #category : #'html tags' }
LeHtmlOutputPrettyStream >> inlineTag: tag class: cssClass with: string [
	"Write an HTML tag with class cssClass, using the escaped string as content"

	"<tag class=""cssClass"">string</tag>"

	self noIndentDo: [ 
		self 
			tag: tag 
			class: cssClass 
			with: string
	]
]

{ #category : #'html tags' }
LeHtmlOutputPrettyStream >> inlineTag: tag do: block [
	"Write an HTML tag, executing block to generate enclosed content"

	"<tag>...</tag>"

	self noIndentDo: [ 
		self 
			tag: tag 
			do: block
	]
]

{ #category : #'html tags' }
LeHtmlOutputPrettyStream >> inlineTag: tag with: string [
	"Write an HTML tag using the escaped string as content"

	"<tag>string</tag>"

	self noIndentDo: [ 
		self tag: tag with: string
	]
]

{ #category : #'private - html' }
LeHtmlOutputPrettyStream >> newLine [
	allowIndent ifFalse: [ ^ self ].
	(stream respondsTo: #ensureCr)
		ifTrue: [ stream ensureCr ]
		ifFalse: [ stream cr ]
]

{ #category : #'html tags' }
LeHtmlOutputPrettyStream >> noIndentDo: aBlock [
	| previousIndent |
	previousIndent := allowIndent.
	allowIndent := false.
	aBlock cull: self.
	allowIndent := previousIndent.
]

{ #category : #'private - html' }
LeHtmlOutputPrettyStream >> openTag: tag [
	self indent.
	super openTag: tag.
	self newLine.
	self increaseIndent
]

{ #category : #'private - html' }
LeHtmlOutputPrettyStream >> openTag: tag attribute: name value: value [
	self indent.
	super openTag: tag attribute: name value: value.
	self newLine.
	self increaseIndent
]

{ #category : #'private - html' }
LeHtmlOutputPrettyStream >> openTag: tag attributes: attributes [
	self indent.
	super openTag: tag attributes: attributes.
	self newLine.
	self increaseIndent
]

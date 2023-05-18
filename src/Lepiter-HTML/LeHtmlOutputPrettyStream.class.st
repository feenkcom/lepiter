Class {
	#name : #LeHtmlOutputPrettyStream,
	#superclass : #ZnHtmlOutputStream,
	#instVars : [
		'indent'
	],
	#category : #'Lepiter-HTML-Streams'
}

{ #category : #'private - html' }
LeHtmlOutputPrettyStream >> closeTag: tag [
	self decreaseIndent.
	self newLine.
	self indent.
	super closeTag: tag
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
	indent timesRepeat: [ self doOneIndent ]
]

{ #category : #initiailize }
LeHtmlOutputPrettyStream >> initialize [
	super initialize.

	indent := 0
]

{ #category : #'private - html' }
LeHtmlOutputPrettyStream >> newLine [
	stream cr
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

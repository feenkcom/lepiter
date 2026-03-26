"
Examples for parsing gtSymbol annotation values.
"
Class {
	#name : #LeSymbolAnnotationParserExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #examples }
LeSymbolAnnotationParserExamples >> parseNamedSymbol [
	<gtExample>
	<return: #LeSymbolAnnotationNode>
	| anAst |
	anAst := LeSymbolAnnotationParser parse: 'symbol=gtSymbol'.
	self assert: anAst notNil.
	self assert: anAst hasSymbolNameSpecified.
	self assert: anAst symbolName equals: 'gtSymbol'.
	^ anAst
]

{ #category : #examples }
LeSymbolAnnotationParserExamples >> parseSymbolName [
	<gtExample>
	<return: #LeSymbolAnnotationNode>
	| anAst |
	anAst := LeSymbolAnnotationParser parse: 'gtSymbol'.
	self assert: anAst notNil.
	self assert: anAst hasSymbolNameSpecified.
	self assert: anAst symbolName equals: 'gtSymbol'.
	^ anAst
]

{ #category : #examples }
LeSymbolAnnotationParserExamples >> parseSymbolWithColon [
	<gtExample>
	<return: #LeSymbolAnnotationNode>
	| anAst |
	anAst := LeSymbolAnnotationParser parse: 'gtSymbol:'.
	self assert: anAst notNil.
	self assert: anAst hasSymbolNameSpecified.
	self assert: anAst symbolName equals: 'gtSymbol:'.
	self assert: anAst symbolValue equals: #gtSymbol:.
	^ anAst
]

{ #category : #examples }
LeSymbolAnnotationParserExamples >> parseSymbolWithColonAndUnderscore [
	<gtExample>
	<return: #LeSymbolAnnotationNode>
	| anAst |
	anAst := LeSymbolAnnotationParser parse: 'gtSymbol:_value:'.
	self assert: anAst notNil.
	self assert: anAst hasSymbolNameSpecified.
	self assert: anAst symbolName equals: 'gtSymbol:_value:'.
	self assert: anAst symbolValue equals: #'gtSymbol:_value:'.
	^ anAst
]

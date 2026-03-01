"
Examples for parsing gtPragma annotation values.
"
Class {
	#name : #LePragmaAnnotationParserExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #examples }
LePragmaAnnotationParserExamples >> parseNamedPragma [
	<gtExample>
	<return: #LePragmaAnnotationNode>
	| anAst |
	anAst := LePragmaAnnotationParser parse: 'pragma=gtExample'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 1.
	self assert: anAst pragmaName equals: 'gtExample'.

	^ anAst
]

{ #category : #examples }
LePragmaAnnotationParserExamples >> parsePragmaName [
	<gtExample>
	<return: #LePragmaAnnotationNode>
	| anAst |
	anAst := LePragmaAnnotationParser parse: 'gtView'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 1.
	self assert: anAst pragmaName equals: 'gtView'.

	^ anAst
]

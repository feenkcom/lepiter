"
Examples for parsing gtPragma annotation values.
"
Class {
	#name : #LePragmaAnnotationParserExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #examples }
LePragmaAnnotationParserExamples >> parseExpandedDefault [
	<gtExample>
	<return: #LePragmaAnnotationNode>
	| anAst |
	anAst := LePragmaAnnotationParser parse: 'gtView|expanded'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst expandedArgument notNil.
	self assert: anAst expandedArgument valueString equals: 'expanded'.
	self assert: anAst expandedValue equals: true.

	^ anAst
]

{ #category : #examples }
LePragmaAnnotationParserExamples >> parseExpandedFalse [
	<gtExample>
	<return: #LePragmaAnnotationNode>
	| anAst |
	anAst := LePragmaAnnotationParser parse: 'gtView|expanded=false'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst expandedArgument notNil.
	self assert: anAst expandedArgument name value equals: 'expanded'.
	self assert: anAst expandedArgument valueString equals: 'false'.
	self assert: anAst expandedValue equals: false.

	^ anAst
]

{ #category : #examples }
LePragmaAnnotationParserExamples >> parseExpandedTrue [
	<gtExample>
	<return: #LePragmaAnnotationNode>
	| anAst |
	anAst := LePragmaAnnotationParser parse: 'gtView|expanded=true'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst expandedArgument notNil.
	self assert: anAst expandedArgument name value equals: 'expanded'.
	self assert: anAst expandedArgument valueString equals: 'true'.
	self assert: anAst expandedValue equals: true.

	^ anAst
]

{ #category : #examples }
LePragmaAnnotationParserExamples >> parseExpandedWithWhitespace [
	<gtExample>
	<return: #LePragmaAnnotationNode>
	| anAst |
	anAst := LePragmaAnnotationParser parse: 'gtView|expanded = false'.

	self assert: anAst notNil.
	self assert: anAst expandedArgument notNil.
	self assert: anAst expandedValue equals: false.

	^ anAst
]

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

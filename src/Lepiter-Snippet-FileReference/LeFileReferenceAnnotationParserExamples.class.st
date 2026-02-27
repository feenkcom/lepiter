"
Examples for parsing gtFileReference annotation values.
"
Class {
	#name : #LeFileReferenceAnnotationParserExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseBareLabelValue [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|label=Readme'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst labelArgument notNil.
	self assert: anAst labelArgument value value equals: 'Readme'.
	self assert: anAst labelString equals: 'Readme'.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseExpandedDefault [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|expanded'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst expandedArgument notNil.
	self assert: anAst expandedArgument name value equals: 'expanded'.
	self assert: anAst expandedArgument valueString isNil.
	self assert: anAst expandedValue equals: true.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseExpandedFalse [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|expanded=false'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst expandedArgument notNil.
	self assert: anAst expandedArgument name value equals: 'expanded'.
	self assert: anAst expandedArgument valueString equals: 'false'.
	self assert: anAst expandedValue equals: false.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseExpandedTrue [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|expanded=true'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst expandedArgument notNil.
	self assert: anAst expandedArgument name value equals: 'expanded'.
	self assert: anAst expandedArgument valueString equals: 'true'.
	self assert: anAst expandedValue equals: true.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseExpandedWithWhitespace [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|expanded = false'.

	self assert: anAst notNil.
	self assert: anAst expandedArgument notNil.
	self assert: anAst expandedValue equals: false.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseInvalidMissingLabelValue [
	<gtExample>
	<return: #Boolean>
	| raised |
	raised := false.
	[ LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|label=' ]
		on: SmaCCParserError
		do: [ raised := true ].
	self assert: raised.
	^ true
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseInvalidMissingPathValue [
	<gtExample>
	<return: #Boolean>
	| raised |
	raised := false.
	[ LeFileReferenceAnnotationParser parse: 'path=' ]
		on: SmaCCParserError
		do: [ raised := true ].
	self assert: raised.
	^ true
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseInvalidRangeMissingColon [
	<gtExample>
	<return: #Boolean>
	| raised |
	raised := false.
	[ LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|range=2 10' ]
		on: SmaCCParserError
		do: [ raised := true ].
	self assert: raised.
	^ true
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseInvalidRangeMissingEnd [
	<gtExample>
	<return: #Boolean>
	| raised |
	raised := false.
	[ LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|range=2:' ]
		on: SmaCCParserError
		do: [ raised := true ].
	self assert: raised.
	^ true
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseInvalidRangeMissingStart [
	<gtExample>
	<return: #Boolean>
	| raised |
	raised := false.
	[ LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|range=:10' ]
		on: SmaCCParserError
		do: [ raised := true ].
	self assert: raised.
	^ true
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseInvalidUnterminatedQuote [
	<gtExample>
	<return: #Boolean>
	| raised |
	raised := false.
	[ LeFileReferenceAnnotationParser parse: 'path="/tmp/a file.md|label=Read' ]
		on: SmaCCParserError
		do: [ raised := true ].
	self assert: raised.
	^ true
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseNamedPath [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 1.
	self assert: anAst pathArgument notNil.
	self assert: anAst pathArgument name value equals: 'path'.
	self assert: anAst pathArgument value value equals: '/tmp/readme.md'.
	self assert: anAst pathArgument normalizedValue equals: '/tmp/readme.md'.
	self assert: anAst pathString equals: '/tmp/readme.md'.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseNamedPathAndLabel [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|label="Read me"'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst pathArgument notNil.
	self assert: anAst labelArgument notNil.
	self assert: anAst pathArgument name value equals: 'path'.
	self assert: anAst pathArgument value value equals: '/tmp/readme.md'.
	self assert: anAst labelArgument name value equals: 'label'.
	self assert: anAst labelArgument value value equals: '"Read me"'.
	self assert: anAst labelArgument normalizedValue equals: 'Read me'.
	self assert: anAst pathString equals: '/tmp/readme.md'.
	self assert: anAst labelString equals: 'Read me'.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseNamedPathAndRange [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|range=2:10'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst pathArgument notNil.
	self assert: anAst rangeArgument notNil.
	self assert: anAst rangeArgument name value equals: 'range'.
	self assert: anAst rangeValue notNil.
	self assert: anAst rangeStart equals: 2.
	self assert: anAst rangeEnd equals: 10.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseNamedPathAndRangeAndHeight [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|range=2:10|height=180'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 3.
	self assert: anAst pathArgument notNil.
	self assert: anAst rangeArgument notNil.
	self assert: anAst heightArgument notNil.
	self assert: anAst rangeStart equals: 2.
	self assert: anAst rangeEnd equals: 10.
	self assert: anAst heightValue equals: 180.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parsePathOnly [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: '/tmp/readme.md'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 1.
	self assert: anAst pathArgument notNil.
	self assert: anAst pathArgument value value equals: '/tmp/readme.md'.
	self assert: anAst pathString equals: '/tmp/readme.md'.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseQuotedPathAndLabel [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path="/tmp/a file.md"|label="Read ""me"""'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst pathArgument notNil.
	self assert: anAst labelArgument notNil.
	self assert: anAst pathArgument name value equals: 'path'.
	self assert: anAst pathArgument value value equals: '"/tmp/a file.md"'.
	self assert: anAst pathArgument normalizedValue equals: '/tmp/a file.md'.
	self assert: anAst labelArgument name value equals: 'label'.
	self assert: anAst labelArgument value value equals: '"Read ""me"""'.
	self assert: anAst labelArgument normalizedValue equals: 'Read "me"'.
	self assert: anAst pathString equals: '/tmp/a file.md'.
	self assert: anAst labelString equals: 'Read "me"'.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseQuotedPathOnly [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: '"/tmp/a file.md"'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 1.
	self assert: anAst pathArgument notNil.
	self assert: anAst pathArgument value value equals: '"/tmp/a file.md"'.
	self assert: anAst pathString equals: '/tmp/a file.md'.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseQuotedPathWithRangeAndExpanded [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path="/tmp/a file.md"|range=1:3|expanded=false'.

	self assert: anAst notNil.
	self assert: anAst pathArgument notNil.
	self assert: anAst rangeArgument notNil.
	self assert: anAst expandedArgument notNil.
	self assert: anAst rangeStart equals: 1.
	self assert: anAst rangeEnd equals: 3.
	self assert: anAst expandedValue equals: false.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseQuotedPathWithRangeExpandedAndHeight [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path="/tmp/a file.md"|range=1:3|expanded=false|height=240'.

	self assert: anAst notNil.
	self assert: anAst pathArgument notNil.
	self assert: anAst rangeArgument notNil.
	self assert: anAst expandedArgument notNil.
	self assert: anAst heightArgument notNil.
	self assert: anAst rangeStart equals: 1.
	self assert: anAst rangeEnd equals: 3.
	self assert: anAst expandedValue equals: false.
	self assert: anAst heightValue equals: 240.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseRangeAndExpanded [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|range=1:3|expanded=true'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 3.
	self assert: anAst rangeArgument notNil.
	self assert: anAst expandedArgument notNil.
	self assert: anAst rangeStart equals: 1.
	self assert: anAst rangeEnd equals: 3.
	self assert: anAst expandedValue equals: true.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseRangeWithWhitespace [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path=/tmp/readme.md|range= 2 : 10 |expanded=true'.

	self assert: anAst notNil.
	self assert: anAst rangeArgument notNil.
	self assert: anAst rangeStart equals: 2.
	self assert: anAst rangeEnd equals: 10.
	self assert: anAst expandedValue equals: true.

	^ anAst
]

{ #category : #examples }
LeFileReferenceAnnotationParserExamples >> parseWhitespaceAroundTokens [
	<gtExample>
	<return: #LeFileReferenceAnnotationNode>
	| anAst |
	anAst := LeFileReferenceAnnotationParser parse: 'path = "/tmp/a file.md" | label = "Read me"'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst pathString equals: '/tmp/a file.md'.
	self assert: anAst labelString equals: 'Read me'.

	^ anAst
]

"
Examples for parsing gtWordExplanation annotation values.
"
Class {
	#name : #LeWordAnnotationParserExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Words'
}

{ #category : #examples }
LeWordAnnotationParserExamples >> parseWordAndExpandedDefault [
	<gtExample>
	<return: #LeWordAnnotationNode>
	| anAst |
	anAst := LeWordAnnotationParser parse: 'toolkit|expanded'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst hasExpandedSpecified.
	self assert: anAst expandedValueNode name value equals: 'expanded'.
	self assert: anAst isExpanded.

	^ anAst
]

{ #category : #examples }
LeWordAnnotationParserExamples >> parseWordAndExpandedFalse [
	<gtExample>
	<return: #LeWordAnnotationNode>
	| anAst |
	anAst := LeWordAnnotationParser parse: 'toolkit|expanded=false'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst hasExpandedSpecified.
	self assert: anAst expandedValueNode name value equals: 'expanded'.
	self assert: anAst expandedValueNode value source equals: 'false'.
	self assert: anAst isExpanded equals: false.

	^ anAst
]

{ #category : #examples }
LeWordAnnotationParserExamples >> parseWordAndHeight [
	<gtExample>
	<return: #LeWordAnnotationNode>
	| anAst |
	anAst := LeWordAnnotationParser parse: 'toolkit|height=200'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst hasHeightSpecified.
	self assert: anAst heightValueNode name value equals: 'height'.
	self assert: anAst height equals: 200.

	^ anAst
]

{ #category : #examples }
LeWordAnnotationParserExamples >> parseWordOnly [
	<gtExample>
	<return: #LeWordAnnotationNode>
	| anAst |
	anAst := LeWordAnnotationParser parse: 'toolkit'.

	self assert: anAst notNil.
	self assert: anAst items size equals: 1.
	self assert: anAst hasWordSpecified.
	self assert: anAst word equals: 'toolkit'.
	self assert: anAst hasExpandedSpecified not.
	self assert: anAst hasHeightSpecified not.
	self assert: anAst isExpanded equals: false.
	self assert: anAst height equals: 100.

	^ anAst
]

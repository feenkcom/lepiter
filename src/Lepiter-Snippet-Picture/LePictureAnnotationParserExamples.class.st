Class {
	#name : #LePictureAnnotationParserExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #examples }
LePictureAnnotationParserExamples >> parseReferenceKeyAndValue [
	<gtExample>
	<return: #LePictureAnnotationNode>
	| anAst |
	anAst := LePictureAnnotationParser parse: 'reference=fig123'.

	self assert: anAst hasPictureReferenceSpecified.

	^ anAst
]

{ #category : #examples }
LePictureAnnotationParserExamples >> parseReferenceKeyAndValue_number [
	<gtExample>
	<return: #LePictureAnnotationNode>
	| anAst |
	anAst := LePictureAnnotationParser parse: 'reference=123'.

	self assert: anAst hasPictureReferenceSpecified.

	^ anAst
]

{ #category : #examples }
LePictureAnnotationParserExamples >> parseReferenceValue [
	<gtExample>
	<return: #LePictureAnnotationNode>
	| anAst |
	anAst := LePictureAnnotationParser parse: 'fig123'.

	self assert: anAst hasPictureReferenceSpecified.

	^ anAst
]

{ #category : #examples }
LePictureAnnotationParserExamples >> parseReferenceValue_number [
	<gtExample>
	<return: #LePictureAnnotationNode>
	| anAst |
	anAst := LePictureAnnotationParser parse: '42'.

	self assert: anAst hasPictureReferenceSpecified.

	^ anAst
]

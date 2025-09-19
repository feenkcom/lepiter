Class {
	#name : #LeHtmlElementIdBuilderExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlElementIdBuilderExamples >> headerDuplicateId [
	<gtExample>
	<return: #LeHtmlElementId>
	| aNode aHeader aResult aBuilder aResult2 |
	aNode := LeParserExamples new headers.
	aHeader := aNode parts at: 1.

	aBuilder := LeHtmlElementIdBuilder new contentNode: aHeader.
	aResult := aBuilder build.

	self assert: aResult contentNode source equals: '#header with a #text'.
	self assert: aResult elementId equals: 'header-with-atext'.

	aResult2 := aBuilder build.
	self assert: (aResult2 elementId = aResult elementId) not.
	self assert: aResult2 elementId equals: 'header-with-atext2'.

	^ aResult
]

{ #category : #examples }
LeHtmlElementIdBuilderExamples >> headerWithChinese [
	<gtExample>
	<return: #LeHtmlElementId>
	| aNode aHeader aResult |
	aNode := LeParserExamples new headers2.
	aHeader := aNode parts at: 8.

	aResult := LeHtmlElementIdBuilder new
			contentNode: aHeader;
			build.

	self assert: aResult contentNode source equals: '#### 中国 header'.
	self assert: aResult elementId equals: '中国-header'.

	^ aResult
]

{ #category : #examples }
LeHtmlElementIdBuilderExamples >> headerWithClassAnnotation [
	<gtExample>
	<return: #LeHtmlElementId>
	| aNode aHeader aResult |
	aNode := LeParserExamples new headers2.
	aHeader := aNode parts at: 6.

	aResult := LeHtmlElementIdBuilder new
			contentNode: aHeader;
			build.

	self
		assert: aResult contentNode source
		equals: '### I am {{gtClass:BrButton}} header'.
	self assert: aResult elementId equals: 'i-amheader'.

	^ aResult
]

{ #category : #examples }
LeHtmlElementIdBuilderExamples >> headerWithHash [
	<gtExample>
	<return: #LeHtmlElementId>
	| aNode aHeader aResult |
	aNode := LeParserExamples new headers.
	aHeader := aNode parts at: 1.

	aResult := LeHtmlElementIdBuilder new
			contentNode: aHeader;
			build.

	self assert: aResult contentNode source equals: '#header with a #text'.
	self assert: aResult elementId equals: 'header-with-atext'.

	^ aResult
]

{ #category : #examples }
LeHtmlElementIdBuilderExamples >> headerWithParentheses [
	<gtExample>
	<return: #LeHtmlElementId>
	| aNode aHeader aResult |
	aNode := LeParserExamples new headers2.
	aHeader := aNode parts at: 1.

	aResult := LeHtmlElementIdBuilder new
			contentNode: aHeader;
			build.

	self
		assert: aResult contentNode source
		equals: '# I am __Header One (Letter A)__'.
	self assert: aResult elementId equals: 'i-am-header-oneletter-a'.

	^ aResult
]

{ #category : #examples }
LeHtmlElementIdBuilderExamples >> headerWithStar [
	<gtExample>
	<return: #LeHtmlElementId>
	| aNode aHeader aResult |
	aNode := LeParserExamples new headers2.
	aHeader := aNode parts at: 4.

	aResult := LeHtmlElementIdBuilder new
			contentNode: aHeader;
			build.

	self
		assert: aResult contentNode source
		equals: '## I am *Header Two {Letter B}*'.
	self assert: aResult elementId equals: 'i-amheader-twoletter-b'.

	^ aResult
]

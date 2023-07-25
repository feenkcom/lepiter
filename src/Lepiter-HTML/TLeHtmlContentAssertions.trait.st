Trait {
	#name : #TLeHtmlContentAssertions,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #asserting }
TLeHtmlContentAssertions >> assertEmptyHtml: html [
	self assertHtml: html.
	self assert: html isEmpty description: [ 'HTML output must be empty' ]
]

{ #category : #asserting }
TLeHtmlContentAssertions >> assertHtml: html [
	self assert: html isNotNil description: [ 'HTML output must be non-nil' ].
	self assert: html isString description: [ 'HTML output must be a string' ]
]

{ #category : #asserting }
TLeHtmlContentAssertions >> assertHtml: html beginsWith: subString [
	self assertNotEmptyHtml: html.

	self
		assert: (html beginsWith: subString)
		description: [ 'HTML must begin with {1}' format: {subString} ]
]

{ #category : #asserting }
TLeHtmlContentAssertions >> assertHtml: html equals: wholeString [
	self assertNotEmptyHtml: html.

	self
		assert: (html = wholeString)
		description: [ 'Expected HTML is {1}, actual is {2}' format: {wholeString. html } ]
]

{ #category : #asserting }
TLeHtmlContentAssertions >> assertHtml: html includes: subString [
	self assertNotEmptyHtml: html.

	self
		assert: (html includesSubstring: subString)
		description: [ 'HTML must include {1}' format: {subString} ]
]

{ #category : #asserting }
TLeHtmlContentAssertions >> assertNotEmptyHtml: html [
	self assertHtml: html.
	self assert: html isNotEmpty description: [ 'HTML output must be non-empty' ]
]

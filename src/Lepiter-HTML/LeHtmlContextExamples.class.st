"
I have examples of {{gtClass:LeHtmlContext}}, the state that {{gtClass:TLeHtmlPiece}} pieces share while they write one HTML page. I check that a context copied with a new stream really writes to the new stream and not to the stream of the original context.
"
Class {
	#name : #LeHtmlContextExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlContextExamples >> copyWithNewStreamKeepsPage [
	<gtExample>
	<return: #LeHtmlContext>
	| aPage aContext aCopy |
	aPage := LePage new.
	aPage title: 'Page'.
	aContext := LeHtmlContext new.
	aContext page: aPage.
	aContext newStream: (WriteStream on: String new).

	aCopy := aContext copyWithNewStream: (WriteStream on: String new).

	self
		assert: aCopy page == aPage
		description: [ 'The copy must keep the page of the original context' ].

	^ aCopy
]

{ #category : #examples }
LeHtmlContextExamples >> copyWithNewStreamWritesToNewStream [
	<gtExample>
	<return: #LeHtmlContext>
	| anOriginalStream aCopyStream aContext aCopy |
	anOriginalStream := WriteStream on: String new.
	aCopyStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext newStream: anOriginalStream.
	"The HTML stream is cached when it is requested for the first time.
	A copy must not reuse it."
	aContext html nextPutAll: 'original'.

	aCopy := aContext copyWithNewStream: aCopyStream.
	aCopy html nextPutAll: 'copy'.
	aContext html nextPutAll: ' again'.

	self
		assert: aCopy ~~ aContext
		description: [ 'A copy must be a different object' ].
	self
		assert: anOriginalStream contents = 'original again'
		description: [ 'The original context must keep writing to its own stream, but it wrote {1}'
				format: {anOriginalStream contents} ].
	self
		assert: aCopyStream contents = 'copy'
		description: [ 'The copy must write to the new stream, but it wrote {1}'
				format: {aCopyStream contents} ].

	^ aCopy
]

{ #category : #examples }
LeHtmlContextExamples >> urlAttributePieceEscapesAmpersand [
	<gtExample>
	<return: #LeHtmlPageUrlAttributePiece>
	| aPage aStream aContext aPiece |
	aPage := LePage new.
	aPage title: 'Page'.
	aStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext page: aPage.
	aContext newStream: aStream.
	aPiece := LeHtmlPageUrlAttributePiece new.
	aPiece baseUrl: 'https://example.org/book?x=1&y=2' asZnUrl.

	aPiece writeWithContext: aContext.

	self
		assert: aStream contents = 'https://example.org/book/index.html?x=1&amp;y=2'
		description: [ 'URL attribute must have an escaped ampersand, but it is {1}'
				format: {aStream contents} ].

	^ aPiece
]

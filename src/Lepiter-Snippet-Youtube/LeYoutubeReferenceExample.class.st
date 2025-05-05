Class {
	#name : #LeYoutubeReferenceExample,
	#superclass : #Object,
	#traits : 'TLeHtmlContentAssertions',
	#classTraits : 'TLeHtmlContentAssertions classTrait',
	#category : #'Lepiter-Snippet-Youtube-Examples'
}

{ #category : #accessing }
LeYoutubeReferenceExample >> youtubeSnippet [
	<gtExample>
	<return: #ByteString>
	| markdown html |
	markdown := LeYoutubeReferenceSnippet new
			urlString: 'https://www.youtube.com/watch?v=vtD-xD0Eo3c'.
	html := String
			streamContents: [ :stream | 
				markdown
					acceptVisitor: (LeHtmlVisitor new context: (LeHtmlContext new stream: stream)) ].

	self assertNotEmptyHtml: html.
	self assertHtml: html includes: 'vtD-xD0Eo3c'.
	self assertHtml: html includes: 'youtube-reference-snippet'.

	^ html
]

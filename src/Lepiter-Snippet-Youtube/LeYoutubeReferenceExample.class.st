Class {
	#name : #LeYoutubeReferenceExample,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Youtube-Examples'
}

{ #category : #accessing }
LeYoutubeReferenceExample >> youtubeSnippet [
	<gtExample>
	| markdown html |
	markdown := LeYoutubeReferenceSnippet new urlString: 'https://www.youtube.com/watch?v=vtD-xD0Eo3c'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	
		
	^ html

]

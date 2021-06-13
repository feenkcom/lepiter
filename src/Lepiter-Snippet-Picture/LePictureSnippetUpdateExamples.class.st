Class {
	#name : #LePictureSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #'examples - snippets' }
LePictureSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet urlString 
		equals: 'www.example.com/picture2'
]

{ #category : #'examples - snippets' }
LePictureSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LePictureSnippet new 
		urlString: 'www.example.com/picture1'
]

{ #category : #'examples - snippets' }
LePictureSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet urlString: 'www.example.com/picture2'
]

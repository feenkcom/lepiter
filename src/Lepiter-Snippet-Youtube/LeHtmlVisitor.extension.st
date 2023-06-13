Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-Youtube' }
LeHtmlVisitor >> visitYoutubeReferenceSnippet: aLeSnippet [

	context html 
		tag: #div
		attributes: #('class' 'snippet youtube-reference-snippet')
		do: [ context html << aLeSnippet html ]
]

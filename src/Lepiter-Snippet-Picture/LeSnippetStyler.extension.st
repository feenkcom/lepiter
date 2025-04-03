Extension { #name : #LeSnippetStyler }

{ #category : #'*Lepiter-Snippet-Picture' }
LeSnippetStyler >> pictureSnippetWithReference: aReference [
	| aPage anIndex |
	snippetViewModel ifNil: [ ^ nil ].
	aPage := snippetViewModel snippetModel page.
	aPage ifNil: [ ^ nil ].
	anIndex := 0.
	aPage
		allChildrenDepthFirstDo: [ :eachSnippet | 
			eachSnippet isPictureSnippet ifTrue: [
				anIndex := anIndex + 1 ].
			(eachSnippet isPictureSnippetWithReference: aReference)
				ifTrue: [ ^ LePictureSnippetReference new
					snippetModel: eachSnippet;
					reference: aReference;
					index: anIndex ] ].

	^ nil
]

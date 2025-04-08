Extension { #name : #LeSnippetStyler }

{ #category : #'*Lepiter-Snippet-Picture' }
LeSnippetStyler >> pictureSnippetWithReference: aReference [
	| aPage anIndex aDatabase |
	snippetViewModel ifNil: [ ^ nil ].
	aPage := snippetViewModel snippetModel page.
	aPage ifNil: [ ^ nil ].
	aDatabase := aPage database.
	anIndex := 0.
	
	(aDatabase isNil or: [ aDatabase isDatabase not ]) ifTrue: [ 
		aPage
			allChildrenDepthFirstDo: [ :eachSnippet | 
				eachSnippet isPictureSnippet ifTrue: [
					anIndex := anIndex + 1 ].
				(eachSnippet isPictureSnippetWithReference: aReference)
					ifTrue: [ ^ LePictureSnippetReference new
						snippetModel: eachSnippet;
						reference: aReference;
						index: anIndex ] ] ].
						
	aDatabase snippetsIterator snippetsDo: [ :eachSnippet | 
		eachSnippet isPictureSnippet ifTrue: [
			anIndex := anIndex + 1 ].
		(eachSnippet isPictureSnippetWithReference: aReference)
			ifTrue: [ ^ LePictureSnippetReference new
				snippetModel: eachSnippet;
				reference: aReference;
				index: anIndex ] ].

	^ nil
]

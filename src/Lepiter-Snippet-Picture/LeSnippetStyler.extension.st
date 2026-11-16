Extension { #name : #LeSnippetStyler }

{ #category : #'*Lepiter-Snippet-Picture' }
LeSnippetStyler >> pictureSnippetWithReference: aReference [
	<return: #LePictureSnippetReference or: nil>
	snippetViewModel ifNil: [ ^ nil ].

	^ LePictureSnippetReference
		forReference: aReference
		inPage: snippetViewModel snippetModel page

]

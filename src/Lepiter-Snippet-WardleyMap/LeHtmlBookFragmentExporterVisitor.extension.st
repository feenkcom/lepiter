Extension { #name : #LeHtmlBookFragmentExporterVisitor }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
LeHtmlBookFragmentExporterVisitor >> visitWardleyMapSnippet: aLeWardleyMapSnippet [
	| aFileName |

	aFileName := self externalPicturesWriter  
			wardleyMapSnippetReferenceFor: aLeWardleyMapSnippet.

	self
		putTag: 'figure'
		andAttributes: #('class' 'snippet picture-snippet paragraphWidth')
		with: [

			self
				putTag: 'img'
				andAttributes: {'class'. 'picture-snippet-image'. 'src'. aFileName }.

			(aLeWardleyMapSnippet title isNotNil
				and: [ aLeWardleyMapSnippet title trimBoth isNotEmpty ])
				ifTrue: [ self
						putTag: 'figcaption'
						andAttributes: #('class' 'picture-snippet-caption')
						with: [ self putString: aLeWardleyMapSnippet title trimBoth asString asHTMLString ] ] ]
]

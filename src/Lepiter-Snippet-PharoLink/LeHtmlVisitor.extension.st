Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-PharoLink' }
LeHtmlVisitor >> visitPharoLinkSnippet: aLePharoLinkSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLePharoLinkSnippet
				withClasses: 'snippet textual-snippet code-snippet pharolink-snippet')
		do: [ context html
				tag: #pre
				attributes: #('class' 'no_bottom_margin')
				with: aLePharoLinkSnippet code ].
	^ self visitContent: aLePharoLinkSnippet
]

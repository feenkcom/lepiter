Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-Pharo-Rewrites' }
LeHtmlVisitor >> visitPharoRewriteSnippet: aLePharoRewriteSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLePharoRewriteSnippet
				withClasses: 'snippet textual-snippet code-snippet pharorewrite-snippet')
		do: [ context html
				tag: #pre
				attributes: #('class' 'no_bottom_margin')
				with: aLePharoRewriteSnippet search ].

	aLePharoRewriteSnippet replace trimBoth
		ifNotEmpty: [ context html
				tag: #div
				attributes: #('class' 'snippet textual-snippet code-snippet pharoreplace-snippet')
				do: [ context html
						tag: #pre
						attributes: #('class' 'no_bottom_margin')
						with: aLePharoRewriteSnippet replace ] ].

	^ self visitContent: aLePharoRewriteSnippet
]

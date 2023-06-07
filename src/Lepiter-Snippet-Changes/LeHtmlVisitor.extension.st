Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-Changes' }
LeHtmlVisitor >> visitChangesSnippet: aLeChangesSnippet [

	| aViewModel aCode |
	aViewModel := aLeChangesSnippet asSnippetViewModel.
	aViewModel hasChangesFile ifFalse: [ 
		context logger missingChangesSnippetFile: aViewModel.
		^ self
	].
	
	aCode := aViewModel changes tutorialState.

	context html
		tag: #div
		attributes: #('class' 'snippet textual-snippet code-snippet changes-snippet')
		do: [
			context html
				tag: #pre
				attributes: #('class' 'no_bottom_margin')
				with: aCode ].
	^ self visitContent: aLeChangesSnippet
]

Extension { #name : #LeSnippet }

{ #category : #'*Lepiter-UI-IncomingReferences' }
LeSnippet >> asIncomingLinkPreviewElement [
	"I return a ${class:BlElement}$ that is used for as a preview in the incoming link.
	By default, snippets are rendered as normally in the incoming link preview.
	Subclasses may override it to build a different preview"
	<return: #LeContentElement>
	| aSnippetViewModel aSnippetElement |

	aSnippetViewModel := self asSnippetViewModel.
	aSnippetElement := (aSnippetViewModel snippetView needsEmbellishments: false) asElement.
	aSnippetElement snippetViewModel: aSnippetViewModel.
	^ aSnippetElement
]

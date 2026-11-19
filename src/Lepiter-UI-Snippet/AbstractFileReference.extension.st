Extension { #name : #AbstractFileReference }

{ #category : #'*Lepiter-UI-Snippet' }
AbstractFileReference >> gtMarkdownViewFor: aView [
	<gtView>
	self exists ifFalse: [ ^ aView empty ].
	self isFile ifFalse: [ ^ aView empty ].
	self isReadable ifFalse: [ ^ aView empty ].
	(self extension endsWith: 'md' caseSensitive: false) ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'Markdown';
		priority: 30;
		text: [ self contents ];
		styler: [ LeLocalFileSnippetStyler new
				rootDirectory: self parent;
				snippetViewModel: LeTextSnippet new asSnippetViewModel ]
]

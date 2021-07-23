Extension { #name : 'LeLinkSnippetUidReference' }

{ #category : '*Lepiter-Store' }
LeLinkSnippetUidReference class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#snippetUid -> #snippetUid);
		yourself
]

{ #category : '*Lepiter-Store' }
LeLinkSnippetUidReference class >> leJsonV3Name [

	^ 'snippetReference'
]

{ #category : '*Lepiter-Store' }
LeLinkSnippetUidReference class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#snippetUid -> #snippetUid);
		yourself
]

{ #category : '*Lepiter-Store' }
LeLinkSnippetUidReference class >> leJsonV4Name [

	^ 'snippetReference'
]

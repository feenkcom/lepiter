Extension { #name : #LeLinkPageUidReference }

{ #category : #'*Lepiter-Store' }
LeLinkPageUidReference class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#pageUid -> #pageUid);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeLinkPageUidReference class >> leJsonV3Name [

	^ 'pageReferenceByUid'
]

{ #category : #'*Lepiter-Store' }
LeLinkPageUidReference class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#pageUid -> #pageUid);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeLinkPageUidReference class >> leJsonV4Name [

	^ 'pageReferenceByUid'
]

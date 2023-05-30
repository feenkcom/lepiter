Extension { #name : #LeLinkPageTextualTitleReference }

{ #category : #'*Lepiter-Store' }
LeLinkPageTextualTitleReference class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#pageTitle -> #pageTitle);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeLinkPageTextualTitleReference class >> leJsonV3Name [

	^ 'pageReferenceByTitle'
]

{ #category : #'*Lepiter-Store' }
LeLinkPageTextualTitleReference class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#pageTitle -> #pageTitle);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeLinkPageTextualTitleReference class >> leJsonV4Name [

	^ 'pageReferenceByTitle'
]

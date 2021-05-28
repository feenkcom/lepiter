Extension { #name : #LeLinkExternalUrlReference }

{ #category : #'*Lepiter-Store' }
LeLinkExternalUrlReference class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#url -> #urlString);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeLinkExternalUrlReference class >> leJsonV3Name [

	^ 'urlReference'
]

{ #category : #'*Lepiter-Store' }
LeLinkExternalUrlReference class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#url -> #urlString);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeLinkExternalUrlReference class >> leJsonV4Name [

	^ 'urlReference'
]

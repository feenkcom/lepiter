Extension { #name : 'LeExplicitLinks' }

{ #category : '*Lepiter-Store' }
LeExplicitLinks class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#items -> #items);
		add: (#uid -> #uid);
		yourself
]

{ #category : '*Lepiter-Store' }
LeExplicitLinks class >> leJsonV3Name [

	^ #explicitLinks
]

{ #category : '*Lepiter-Store' }
LeExplicitLinks class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#items -> #items);
		add: (#uid -> #uid);
		yourself
]

{ #category : '*Lepiter-Store' }
LeExplicitLinks class >> leJsonV4Name [

	^ #explicitLinks
]

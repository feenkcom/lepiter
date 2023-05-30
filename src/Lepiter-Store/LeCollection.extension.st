Extension { #name : #LeCollection }

{ #category : #'*Lepiter-Store' }
LeCollection >> fromSton: stonReader [

	items := OrderedCollection new.
	stonReader parseListDo: [ :each |
		items add: each ]
]

{ #category : #'*Lepiter-Store' }
LeCollection class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#items -> #items);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeCollection class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#items -> #items);
		yourself
]

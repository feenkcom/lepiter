Extension { #name : 'LeEmail' }

{ #category : '*Lepiter-Store' }
LeEmail class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#email -> #emailString);
		yourself
]

{ #category : '*Lepiter-Store' }
LeEmail class >> leJsonV3Name [

	^ #email
]

{ #category : '*Lepiter-Store' }
LeEmail class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#email -> #emailString);
		yourself
]

{ #category : '*Lepiter-Store' }
LeEmail class >> leJsonV4Name [

	^ #email
]

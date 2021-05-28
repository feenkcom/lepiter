Extension { #name : #LePharoClassPageType }

{ #category : #'*Lepiter-Store' }
LePharoClassPageType class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#pageClassName -> #pageClassName);
		yourself

]

{ #category : #'*Lepiter-Store' }
LePharoClassPageType class >> leJsonV3Name [

	^ 'pharoClassPage'
]

{ #category : #'*Lepiter-Store' }
LePharoClassPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#pageClassName -> #pageClassName);
		yourself

]

{ #category : #'*Lepiter-Store' }
LePharoClassPageType class >> leJsonV4Name [

	^ 'pharoClassPage'
]

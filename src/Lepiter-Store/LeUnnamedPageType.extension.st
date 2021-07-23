Extension { #name : 'LeUnnamedPageType' }

{ #category : '*Lepiter-Store' }
LeUnnamedPageType class >> leJsonV3Name [

	^ 'unnamedPage'
]

{ #category : '*Lepiter-Store' }
LeUnnamedPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#defaultTitle -> #defaultTitle);
		yourself

]

{ #category : '*Lepiter-Store' }
LeUnnamedPageType class >> leJsonV4Name [

	^ 'unnamedPage'
]

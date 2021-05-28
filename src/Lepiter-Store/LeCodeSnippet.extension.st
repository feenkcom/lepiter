Extension { #name : #LeCodeSnippet }

{ #category : #'*Lepiter-Store' }
LeCodeSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#code -> #code);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeCodeSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#code -> #code);
		yourself
]

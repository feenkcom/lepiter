Extension { #name : #LeHeadingStyle }

{ #category : #'*Lepiter-Store' }
LeHeadingStyle class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#level -> #level);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeHeadingStyle class >> leJsonV3Name [

	^ 'headingStyle'
]

{ #category : #'*Lepiter-Store' }
LeHeadingStyle class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#level -> #level);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeHeadingStyle class >> leJsonV4Name [

	^ 'headingStyle'
]

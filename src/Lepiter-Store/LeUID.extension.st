Extension { #name : #LeUID }

{ #category : #'*Lepiter-Store' }
LeUID class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#uid -> #uidString);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeUID class >> leJsonV3Name [

	^ 'uid'
]

{ #category : #'*Lepiter-Store' }
LeUID class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#uid -> #uidString);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeUID class >> leJsonV4Name [

	^ 'uid'
]

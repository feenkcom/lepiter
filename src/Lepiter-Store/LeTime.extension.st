Extension { #name : #LeTime }

{ #category : #'*Lepiter-Store' }
LeTime class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#time -> #time);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeTime class >> leJsonV3Name [

	^ 'time'
]

{ #category : #'*Lepiter-Store' }
LeTime class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#time -> #time);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeTime class >> leJsonV4Name [

	^ 'time'
]

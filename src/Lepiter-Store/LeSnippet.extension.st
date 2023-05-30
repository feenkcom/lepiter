Extension { #name : #LeSnippet }

{ #category : #'*Lepiter-Store' }
LeSnippet >> fromStonMapKey: key value: value [

	super fromStonMapKey: key value: value.
	key = #uid ifTrue: [ uid := value ].
]

{ #category : #'*Lepiter-Store' }
LeSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#uid -> #uid);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#uid -> #uid);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeSnippet >> stonProcessSubObjects: block [

	super stonProcessSubObjects: block.
	uid := block value: uid.
]

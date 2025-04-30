Extension { #name : #LeNamedPageType }

{ #category : #'*Lepiter-Store' }
LeNamedPageType class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: #title -> #title;
		in: [ :aMapping | 
			(self defaultSystemPageTypes includes: self)
				ifFalse: [ aMapping add: #pageTypeRepo -> #pageTypeRepo ].
			aMapping ]

]

{ #category : #'*Lepiter-Store' }
LeNamedPageType class >> leJsonV3Name [

	^ 'namedPage'
]

{ #category : #'*Lepiter-Store' }
LeNamedPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: #title -> #title;
		in: [ :aMapping | 
			(self defaultSystemPageTypes includes: self)
				ifFalse: [ aMapping add: #pageTypeRepo -> #pageTypeRepo ].
			aMapping ]
]

{ #category : #'*Lepiter-Store' }
LeNamedPageType class >> leJsonV4Name [

	^ 'namedPage'
]

Extension { #name : #LeUnnamedPageType }

{ #category : #'*Lepiter-Store' }
LeUnnamedPageType class >> leJsonV3Name [

	^ 'unnamedPage'
]

{ #category : #'*Lepiter-Store' }
LeUnnamedPageType class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #defaultTitle -> #defaultTitle;
		in: [ :aMapping | 
			(self defaultSystemPageTypes includes: self)
				ifFalse: [ aMapping add: #pageTypeRepo -> #pageTypeRepo ].
			aMapping ]
]

{ #category : #'*Lepiter-Store' }
LeUnnamedPageType class >> leJsonV4Name [

	^ 'unnamedPage'
]

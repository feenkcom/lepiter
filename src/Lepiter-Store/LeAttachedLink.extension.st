Extension { #name : #LeAttachedLink }

{ #category : #'*Lepiter-Store' }
LeAttachedLink class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#linkUuid -> #linkUuid);
		add: (#createEmail -> #createEmail);
		add: (#createTime -> #createTime);
		add: (#originReference -> #originReference);
		add: (#targetReference -> #targetReference);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeAttachedLink class >> leJsonV3Name [

	^ #explicitLink
]

{ #category : #'*Lepiter-Store' }
LeAttachedLink class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#linkUuid -> #linkUuid);
		add: (#createEmail -> #createEmail);
		add: (#createTime -> #createTime);
		add: (#originReference -> #originReference);
		add: (#targetReference -> #targetReference);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeAttachedLink class >> leJsonV4Name [

	^ #explicitLink
]

Extension { #name : #LeAttachment }

{ #category : #'*Lepiter-Store' }
LeAttachment class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#originalReference -> #originalReference);
		add: (#uploadDate -> #uploadDate);
		add: (#uploadedBy -> #uploadedBy);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeAttachment class >> leJsonV3Name [

	^ 'attachment'
]

{ #category : #'*Lepiter-Store' }
LeAttachment class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#originalReference -> #originalReference);
		add: (#uploadDate -> #uploadDate);
		add: (#uploadedBy -> #uploadedBy);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeAttachment class >> leJsonV4Name [

	^ 'attachment'
]

Extension { #name : #LeShellCommandSnippet }

{ #category : #'*Lepiter-Store' }
LeShellCommandSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #bindingName -> #bindingName;
		yourself
]

{ #category : #'*Lepiter-Store' }
LeShellCommandSnippet class >> leJsonV4Name [
	^ 'shellCommandSnippet'
]

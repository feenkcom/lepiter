Extension { #name : #LeJsonV3Examples }

{ #category : #'*Lepiter-Pharo' }
LeJsonV3Examples >> codeSnippet [
	<gtExample>
	<return: #LePharoSnippet>
	| code object |
	code := LePharoSnippet code: '4 + 3'.
	self setMetadataFor: code.
	code uidString: 'codeuid0'.
	object := self
			serialize: code
			encodedString: '{"__schema":"3.3","__type":"pharoSnippet","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"codeuid0AAAAAAAAAAAAAA=="},"code":"4 + 3"}'.
	self checkMetadata: object equals: code.
	self assert: object uid equals: code uid.
	self assert: object children class equals: LeSnippets.
	self assert: object hasChildren not.
	^ object
]

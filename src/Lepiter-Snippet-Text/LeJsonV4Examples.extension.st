Extension { #name : #LeJsonV4Examples }

{ #category : #'*Lepiter-Snippet-Text' }
LeJsonV4Examples >> explicitLinkPageAndSnippet [
	<gtExample>
	<return: #LeAttachedLink>
	| page textSnippet explicitLink explicitLinkObject |
	page := LePage named: 'Page Title'.
	self setMetadataFor: page.
	page addSnippet: self textWithPharoCode.
	page basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
	textSnippet := LeTextSnippet string: 'a text snippet'.
	self setMetadataFor: textSnippet.
	textSnippet uidString: 'textuid0'.
	explicitLink := LeAttachedLink new
			originReference: (LeLinkSnippetUidReference forSnippet: textSnippet);
			targetReference: (LeLinkPageUidReference forPage: page).
	explicitLink
		linkUuid: (UUID fromString: 'e4c56d28-f16e-0d00-b35c-bb740d6edd61').
	self seLinkMetadataFor: explicitLink.
	explicitLinkObject := self
			serialize: explicitLink
			encodedString: '{"__schema":"4.1","__type":"explicitLink","linkUuid":{"__type":"uuid","uuid":"e4c56d28-f16e-0d00-b35c-bb740d6edd61"},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"originReference":{"__type":"snippetReference","snippetUid":{"__type":"uid","uidString":"textuid0AAAAAAAAAAAAAA=="}},"targetReference":{"__type":"pageReferenceByUid","pageUid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}}'.
	self assert: explicitLinkObject createTime equals: explicitLink createTime.
	self assert: explicitLinkObject createEmail equals: explicitLink createEmail.
	self assert: explicitLinkObject linkUuid equals: explicitLink linkUuid.
	self assert: explicitLinkObject originReference content equals: nil.
	self assert: explicitLinkObject targetReference content equals: nil.
	self
		assert: explicitLinkObject originReference snippetUid
		equals: textSnippet uid.
	self assert: explicitLinkObject targetReference pageUid equals: page uid.
	^ explicitLinkObject
]

{ #category : #'*Lepiter-Snippet-Text' }
LeJsonV4Examples >> textSnippet [
	<gtExample>
	<return: #LeTextSnippet>
	| text object |
	text := LeTextSnippet string: 'a text snippet'.
	self setMetadataFor: text.
	text uidString: 'textuid0'.
	object := self
			serialize: text
			encodedString: '{"__schema":"4.1","__type":"textSnippet","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"textuid0AAAAAAAAAAAAAA=="},"paragraphStyle":{"__type":"textStyle"},"string":"a text snippet"}'.

	self checkMetadata: object equals: text.
	self assert: object uid equals: text uid.
	self assert: object children class equals: LeSnippets.
	self assert: object hasChildren not.
	self assert: object paragraphStyle equals: text paragraphStyle.
	^ object
]

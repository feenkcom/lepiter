"
Confirm that the main Lepiter objects are encoded as expected in JSON V4.


"
Class {
	#name : #LeJsonV4Examples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #private }
LeJsonV4Examples >> checkMetadata: expected equals: actual [ 

	self assert: expected createTime equals: actual createTime.
	self assert: expected editTime equals: actual editTime.
	self assert: expected createEmail equals: actual createEmail.
	self assert: expected editEmail equals: actual editEmail.

]

{ #category : #examples }
LeJsonV4Examples >> emailAddress [
	<gtExample>
	<return: #LeEmail>
	| email object |
	email := LeEmail address: 'user@email.com'.
	object := self
			serialize: email
			encodedString: '{"__schema":"4.1","__type":"email","emailString":"user@email.com"}'.
	self assert: object equals: email.
	^ object
]

{ #category : #examples }
LeJsonV4Examples >> emptyPage [
	<gtExample>
	<return: #LePage>
	| page pageObject |
	page := LePage named: 'Page Title'.
	self setMetadataFor: page.

	page basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
	pageObject := self
			serialize: page
			encodedString: '{"__schema":"4.1","__type":"page","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"pageType":{"__type":"namedPage","title":"Page Title"},"uid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}'.

	self checkMetadata: pageObject equals: page.
	self assert: pageObject children class equals: LeSnippets.
	self assert: pageObject uid equals: page uid.
	self assert: pageObject childrenCount equals: 0.

	^ pageObject
]

{ #category : #examples }
LeJsonV4Examples >> emptyPageNoCreateValues [
	<gtExample>
	<return: #LePage>
	| page pageObject |
	page := LePage named: 'Page Title'.
	page
		editTime: (LeTime new
				time: (DateAndTime
						year: 2020
						month: 10
						day: 14
						hour: 17
						minute: 26
						second: 42) translateToUTC);
		editEmail: (LeEmail address: 'edit@email.com').

	page basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
	pageObject := self
			serialize: page
			encodedString: '{"__schema":"4.1","__type":"page","children":{"__type":"snippets","items":[]},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"pageType":{"__type":"namedPage","title":"Page Title"},"uid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}'.

	self checkMetadata: pageObject equals: page.
	self assert: pageObject children class equals: LeSnippets.
	self assert: pageObject uid equals: page uid.
	self assert: pageObject childrenCount equals: 0.

	^ pageObject
]

{ #category : #examples }
LeJsonV4Examples >> emptyPageNoEditValues [
	<gtExample>
	<return: #LePage>
	| page pageObject |
	page := LePage named: 'Page Title'.
	page
		createTime: (LeTime new
				time: (DateAndTime
						year: 2020
						month: 10
						day: 13
						hour: 17
						minute: 26
						second: 42) translateToUTC);
		createEmail: (LeEmail address: 'create@email.com').

	page basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
	pageObject := self
			serialize: page
			encodedString: '{"__schema":"4.1","__type":"page","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"pageType":{"__type":"namedPage","title":"Page Title"},"uid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}'.

	self checkMetadata: pageObject equals: page.
	self assert: pageObject children class equals: LeSnippets.
	self assert: pageObject uid equals: page uid.
	self assert: pageObject childrenCount equals: 0.

	^ pageObject
]

{ #category : #examples }
LeJsonV4Examples >> pageWithText [
	<gtExample>
	<return: #LePage>
	| page text code pageObject |
	page := LePage named: 'Page Title'.
	self setMetadataFor: page.
	page addSnippet: self textWithPharoCode.
	page basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').

	pageObject := self
			serialize: page
			encodedString: '{"__schema":"4.1","__type":"page","children":{"__type":"snippets","items":[{"__type":"textSnippet","children":{"__type":"snippets","items":[{"__type":"pharoSnippet","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"codeuid0AAAAAAAAAAAAAA=="},"code":"4 + 3"}]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"textuid0AAAAAAAAAAAAAA=="},"paragraphStyle":{"__type":"textStyle"},"string":"a text snippet"}]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"pageType":{"__type":"namedPage","title":"Page Title"},"uid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}'.

	self checkMetadata: pageObject equals: page.

	self assert: pageObject children class equals: LeSnippets.
	self assert: pageObject uid equals: page uid.
	self assert: pageObject childrenCount equals: 1.

	text := pageObject children first.
	self assert: text uid equals: (LeUID new uidString: 'textuid0').
	self assert: text children class equals: LeSnippets.
	self assert: text childrenCount equals: 1.

	code := text children first.
	self assert: code uid equals: (LeUID new uidString: 'codeuid0').
	self assert: code code equals: '4 + 3'.

	^ pageObject
]

{ #category : #private }
LeJsonV4Examples >> seLinkMetadataFor: anExplicitLink [

	anExplicitLink
		createTime: (LeTime new time: (DateAndTime 
								year: 2020 month: 10 day: 13 
								hour: 17 minute: 26 second: 42) translateToUTC);
		createEmail: (LeEmail address: 'create@email.com')
]

{ #category : #private }
LeJsonV4Examples >> serialize: anObject encodedString: aString [
	| string readObject |

	string := String streamContents: [ :stream |
		LeJsonV4 uniqueInstance serialize: anObject on: stream prettyPrint: false ].
	self assert: string equals: aString.
	readObject := LeJsonV4 uniqueInstance deserialize: string readStream.
	^ readObject
]

{ #category : #private }
LeJsonV4Examples >> setMetadataFor: aLeContent [

	aLeContent
		createTime: (LeTime new time: (DateAndTime 
								year: 2020 month: 10 day: 13 
								hour: 17 minute: 26 second: 42) translateToUTC);
		createEmail: (LeEmail address: 'create@email.com');
		editTime: (LeTime new time: (DateAndTime 
								year: 2020 month: 10 day: 14
								hour: 17 minute: 26 second: 42) translateToUTC);
		editEmail: (LeEmail address: 'edit@email.com').

]

{ #category : #examples }
LeJsonV4Examples >> textWithPharoCode [
	<gtExample>
	<return: #LeTextSnippet>
	| text code textObject codeObject |
	text := self textSnippet.
	code := self codeSnippet.
	text addSnippet: code.
	textObject := self
			serialize: text
			encodedString: '{"__schema":"4.1","__type":"textSnippet","children":{"__type":"snippets","items":[{"__type":"pharoSnippet","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"codeuid0AAAAAAAAAAAAAA=="},"code":"4 + 3"}]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"textuid0AAAAAAAAAAAAAA=="},"paragraphStyle":{"__type":"textStyle"},"string":"a text snippet"}'.

	self checkMetadata: textObject equals: text.
	self assert: textObject uid equals: (LeUID new uidString: 'textuid0').
	self assert: textObject children class equals: LeSnippets.
	self assert: textObject childrenCount equals: 1.

	codeObject := textObject children first.
	self assert: codeObject uid equals: (LeUID new uidString: 'codeuid0').
	self assert: codeObject code equals: '4 + 3'.
	self assert: textObject createEmail equals: codeObject createEmail.

	self assert: textObject editEmail equals: codeObject editEmail.
	self assert: textObject createTime equals: codeObject createTime.
	self assert: textObject editTime equals: codeObject editTime.
	^ textObject
]

{ #category : #examples }
LeJsonV4Examples >> time [
	<gtExample>
	<return: #LeTime>
	| time object |
	time := LeTime new
			time: (DateAndTime
					year: 2020
					month: 10
					day: 13
					hour: 17
					minute: 26
					second: 42) translateToUTC.
	object := self
			serialize: time
			encodedString: '{"__schema":"4.1","__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}}'.
	self assert: object equals: time.
	^ object
]

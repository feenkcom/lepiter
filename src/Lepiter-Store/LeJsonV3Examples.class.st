"
Confirm that the main Lepiter objects are encoded as expected in JSON V3.


"
Class {
	#name : #LeJsonV3Examples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : 'Lepiter-Store-Local-Examples'
}

{ #category : #private }
LeJsonV3Examples >> checkMetadata: expected equals: actual [ 

	self assert: expected createTime equals: actual createTime.
	self assert: expected editTime equals: actual editTime.
	self assert: expected createEmail equals: actual createEmail.
	self assert: expected editEmail equals: actual editEmail.

]

{ #category : #examples }
LeJsonV3Examples >> codeSnippet [
	<gtExample>
	| code object |

	code := LePharoSnippet code: '4 + 3'.
	self setMetadataFor: code.
	code uidString: 'codeuid0'.
	object := self serialize: code encodedString: '{"__schema":"3.3","__type":"pharoSnippet","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"codeuid0AAAAAAAAAAAAAA=="},"code":"4 + 3"}'.
	self checkMetadata: object equals: code.
	self assert: object uid equals: code uid.
	self assert: object children class equals: LeSnippets.
	self assert: object hasChildren not.
	^ object.
]

{ #category : #examples }
LeJsonV3Examples >> emailAddress [
	<gtExample>
	| email object |

	email := LeEmail address: 'user@email.com'.
	object := self serialize: email encodedString: '{"__schema":"3.3","__type":"email","emailString":"user@email.com"}'.
	self assert: object equals: email.
	^ object
]

{ #category : #examples }
LeJsonV3Examples >> emptyPage [
	<gtExample>
	| page pageObject |
	page := LePage named: 'Page Title'.
	self setMetadataFor: page.
	
	page
		basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
	pageObject := self
		serialize: page
		encodedString:
			'{"__schema":"3.3","__type":"page","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"pageType":{"__type":"namedPage","title":"Page Title"},"uid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}'.
			
	self checkMetadata: pageObject equals: page.
	self assert: pageObject children class equals: LeSnippets.
	self assert: pageObject uid equals: page uid.
	self assert: pageObject childrenCount equals: 0.
	
	^ pageObject
]

{ #category : #examples }
LeJsonV3Examples >> emptyPageNoCreateValues [
	<gtExample>
	| page pageObject |
	page := LePage named: 'Page Title'.
	page 
		editTime: (LeTime new time: (DateAndTime 
								year: 2020 month: 10 day: 14
								hour: 17 minute: 26 second: 42) translateToUTC);
		editEmail: (LeEmail address: 'edit@email.com').
	
	page
		basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
	pageObject := self
		serialize: page
		encodedString:
			'{"__schema":"3.3","__type":"page","children":{"__type":"snippets","items":[]},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"pageType":{"__type":"namedPage","title":"Page Title"},"uid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}'.
			
	self checkMetadata: pageObject equals: page.
	self assert: pageObject children class equals: LeSnippets.
	self assert: pageObject uid equals: page uid.
	self assert: pageObject childrenCount equals: 0.
	
	^ pageObject
]

{ #category : #examples }
LeJsonV3Examples >> emptyPageNoEditValues [
	<gtExample>
	| page pageObject |
	page := LePage named: 'Page Title'.
	page 
		createTime: (LeTime new time: (DateAndTime 
								year: 2020 month: 10 day: 13 
								hour: 17 minute: 26 second: 42) translateToUTC);
		createEmail: (LeEmail address: 'create@email.com').
	
	page
		basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
	pageObject := self
		serialize: page
		encodedString:
			'{"__schema":"3.3","__type":"page","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"pageType":{"__type":"namedPage","title":"Page Title"},"uid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}'.
			
	self checkMetadata: pageObject equals: page.
	self assert: pageObject children class equals: LeSnippets.
	self assert: pageObject uid equals: page uid.
	self assert: pageObject childrenCount equals: 0.
	
	^ pageObject
]

{ #category : #examples }
LeJsonV3Examples >> explicitLinkPageAndSnippet [
	<gtExample>
	| page textSnippet explicitLink explicitLinkObject |
	page := LePage named: 'Page Title'.
	self setMetadataFor: page.
	page addSnippet: self textWithPharoCode.
	page
		basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
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
		encodedString:
			'{"__schema":"3.3","__type":"explicitLink","linkUuid":{"__type":"uuid","uuid":"e4c56d28-f16e-0d00-b35c-bb740d6edd61"},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"originReference":{"__type":"snippetReference","snippetUid":{"__type":"uid","uidString":"textuid0AAAAAAAAAAAAAA=="}},"targetReference":{"__type":"pageReferenceByUid","pageUid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}}'.
	self
		assert: explicitLinkObject createTime
		equals: explicitLink createTime.
	self
		assert: explicitLinkObject createEmail
		equals: explicitLink createEmail.
	self
		assert: explicitLinkObject linkUuid
		equals: explicitLink linkUuid.
	self assert: explicitLinkObject originReference content equals: nil.
	self assert: explicitLinkObject targetReference content equals: nil.
	self
		assert: explicitLinkObject originReference snippetUid
		equals: textSnippet uid.
	self
		assert: explicitLinkObject targetReference pageUid
		equals: page uid.
	^ explicitLinkObject
]

{ #category : #examples }
LeJsonV3Examples >> pageWithText [
	<gtExample>
	| page text code pageObject |
	page := LePage named: 'Page Title'.
	self setMetadataFor: page.
	page addSnippet: self textWithPharoCode.
	page
		basicUid: (UUID fromString: 'c4c52d28-f16e-0d00-b35c-cb740d6edd61').
		
	pageObject := self
		serialize: page
		encodedString:
			'{"__schema":"3.3","__type":"page","children":{"__type":"snippets","items":[{"__type":"textSnippet","children":{"__type":"snippets","items":[{"__type":"pharoSnippet","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"codeuid0AAAAAAAAAAAAAA=="},"code":"4 + 3"}]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"textuid0AAAAAAAAAAAAAA=="},"paragraphStyle":{"__type":"textStyle"},"string":"a text snippet"}]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"pageType":{"__type":"namedPage","title":"Page Title"},"uid":{"__type":"uuid","uuid":"c4c52d28-f16e-0d00-b35c-cb740d6edd61"}}'.
	
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
LeJsonV3Examples >> seLinkMetadataFor: anExplicitLink [

	anExplicitLink
		createTime: (LeTime new time: (DateAndTime 
								year: 2020 month: 10 day: 13 
								hour: 17 minute: 26 second: 42) translateToUTC);
		createEmail: (LeEmail address: 'create@email.com')
]

{ #category : #private }
LeJsonV3Examples >> serialize: anObject encodedString: aString [
	| string readObject |

	string := String streamContents: [ :stream |
		LeJsonV3 uniqueInstance serialize: anObject on: stream prettyPrint: false ].
	self assert: string equals: aString.
	readObject := LeJsonV3 uniqueInstance deserialize: string readStream.
	^ readObject
]

{ #category : #private }
LeJsonV3Examples >> setMetadataFor: aLeContent [

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
LeJsonV3Examples >> textSnippet [
	<gtExample>
	| text object |

	text := LeTextSnippet string: 'a text snippet'.
	self setMetadataFor: text.
	text uidString: 'textuid0'.
	object := self serialize: text encodedString: '{"__schema":"3.3","__type":"textSnippet","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"textuid0AAAAAAAAAAAAAA=="},"paragraphStyle":{"__type":"textStyle"},"string":"a text snippet"}'.
	
	self checkMetadata: object equals: text.
	self assert: object uid equals: text uid.
	self assert: object children class equals: LeSnippets.
	self assert: object hasChildren not.
	self assert: object paragraphStyle equals: text paragraphStyle.
	^ object.
]

{ #category : #examples }
LeJsonV3Examples >> textWithPharoCode [
	<gtExample>
	| text code textObject codeObject |
	text := self textSnippet.
	code := self codeSnippet.
	text addSnippet: code.
	textObject := self
		serialize: text
		encodedString:
			'{"__schema":"3.3","__type":"textSnippet","children":{"__type":"snippets","items":[{"__type":"pharoSnippet","children":{"__type":"snippets","items":[]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"codeuid0AAAAAAAAAAAAAA=="},"code":"4 + 3"}]},"createEmail":{"__type":"email","emailString":"create@email.com"},"createTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}},"editEmail":{"__type":"email","emailString":"edit@email.com"},"editTime":{"__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-14T17:26:42+00:00"}},"uid":{"__type":"uid","uidString":"textuid0AAAAAAAAAAAAAA=="},"paragraphStyle":{"__type":"textStyle"},"string":"a text snippet"}'.
	
	self checkMetadata: textObject equals: text.
	self assert: textObject uid equals: (LeUID new uidString: 'textuid0').
	self assert: textObject children class equals: LeSnippets.
	self assert: textObject childrenCount equals: 1.
	
	codeObject := textObject children first.
	self assert: codeObject uid equals: (LeUID new uidString: 'codeuid0').
	self assert: codeObject code equals: '4 + 3'.
	self
		assert: textObject createEmail
		identicalTo: codeObject createEmail.
		
	self assert: textObject editEmail identicalTo: codeObject editEmail.
	self assert: textObject createTime identicalTo: codeObject createTime.
	self assert: textObject editTime identicalTo: codeObject editTime.
	^ textObject
]

{ #category : #examples }
LeJsonV3Examples >> time [
	<gtExample>
	| time object |

	time := LeTime new time: (DateAndTime 
								year: 2020 month: 10 day: 13 
								hour: 17 minute: 26 second: 42) translateToUTC.
	object := self serialize: time encodedString: '{"__schema":"3.3","__type":"time","time":{"__type":"dateAndTime","dateAndTimeString":"2020-10-13T17:26:42+00:00"}}'.
	self assert: object equals: time.
	^ object
]

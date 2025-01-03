"
Update from schema 4.0 to 4.1.

This changes LeUID from a 6 byte ByteArray to a UUID.  But since UUIDs can read base64 strings, no actual migration of the UID is needed.  Just bump the schema version number.

"
Class {
	#name : #LeJsonV4000Updater,
	#superclass : #LeJsonV4SchemaUpdater,
	#instVars : [
		'jsonPage'
	],
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #private }
LeJsonV4000Updater class >> cleanUidString: aString [
	"Come up with a deterministic and (hopefully) unique UID by replacing any characters which aren't part of the base64 alphabet and extending the string by repeating the first part until it is a valid length."
	| alphabet uidString uid |

	uidString := aString.
	self assert: (uidString size between: 3 and: 24).
	alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'.
	uidString doWithIndex: [ :ch :index |
		(alphabet includes: ch) ifFalse: 
			[ uidString := uidString 
				copyReplaceFrom: index 
				to: index 
				with: (alphabet at: (ch codePoint \\ (alphabet size + 1))) asString ] ].
	(uidString size \\ 4) = 0 ifFalse:
		[ uidString := uidString, (uidString copyFrom: 1 to: (4 - (uidString size \\ 4))) ].
	uid := UUID fromBase64EncodedString: uidString.
	^ uid base64Encoded.
]

{ #category : #'private - accessing' }
LeJsonV4000Updater class >> minorVersion [ 
	"Answer the minor version number that this class upgrades from"

	^ 0
]

{ #category : #private }
LeJsonV4000Updater >> cleanUidString: aString [
	^ self class cleanUidString: aString
]

{ #category : #private }
LeJsonV4000Updater >> update: jsonObject [
	"Update the supplied JSON object by one version
	from (self class minorVersion) to (self class minorVersion+1)"

	super update: jsonObject.
	jsonPage := jsonObject.

	"Iterate over all the snippets and ensure that the old UID is valid base64."
	self updateChildren: (jsonObject at: #children)
]

{ #category : #private }
LeJsonV4000Updater >> updateChildren: snippetDictionary [
	"Update the supplied snippet dictionary"

	(snippetDictionary at: #items) do: [ :item |
		self updateUID: (item at: #uid).
		(item at: #'__type') = #textSnippet ifTrue:
			[ self updateSnippetLinks: item ].
		self updateChildren: (item at: #children) ].
]

{ #category : #private }
LeJsonV4000Updater >> updateLinkItems: itemsDictionary [

	itemsDictionary at: #originReference ifPresent:
		[ :reference | self updateReference: reference ].
	itemsDictionary at: #targetReference ifPresent:
		[ :reference | self updateReference: reference ].

]

{ #category : #private }
LeJsonV4000Updater >> updateLinks: jsonObject [
	"Update the supplied JSON links object by one version
	from (self class minorVersion) to (self class minorVersion+1)"

	self assert: (jsonObject at: #'__type') equals: #explicitLinks.
	super update: jsonObject.
	jsonPage := jsonObject.

	"Iterate over all the snippets and ensure that the old UID is valid base64."
	(jsonObject at: #items) do: [ :each |
		self updateLinkItems: each ]
]

{ #category : #private }
LeJsonV4000Updater >> updateReference: referenceDictionary [
	| uidDictionary |

	(referenceDictionary at: #'__type') = #snippetReference ifFalse: [ ^ self ].
	
	uidDictionary := referenceDictionary at: #snippetUid.
	self assert: (uidDictionary at: #'__type') equals: #uid.
	uidDictionary at: #uidString put: (self cleanUidString: (uidDictionary at: #uidString)).
]

{ #category : #private }
LeJsonV4000Updater >> updateSnippetLinks: snippetDictionary [
	"Replace any snippet links, i.e. text of the form ((snippetuid)), with a 4.1 version"
	| snippetString ast visitor |

	snippetString := snippetDictionary at: #string.
	ast := LeParser parseWithErrors: snippetString.
	visitor := LeJsonV4000SnippetVisitor new 
		updater: self;
		snippetString: snippetString.
	ast acceptVisitor: visitor.
	snippetDictionary at: #string put: visitor updatedSnippetString.
]

{ #category : #private }
LeJsonV4000Updater >> updateUID: uidDictionary [
	"Ensure that the current uidString is valid base64.  
	If not, use the valid portion and add a differentiator."

	self assert: (uidDictionary at: #'__type') equals: #uid.
	uidDictionary at: #uidString put: (self cleanUidString: (uidDictionary at: #uidString)).
]

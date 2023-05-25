Class {
	#name : #LeDatabaseClassStorage,
	#superclass : #Object,
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #accessing }
LeDatabaseClassStorage >> attachmentIdsFor: dbClass [

	^ dbClass class selectors 
		select: [ :selector | selector beginsWith: 'attachment_' ]
		thenCollect: [ :selector | selector copyFrom: 12 to: selector size ]
]

{ #category : #accessing }
LeDatabaseClassStorage >> attachmentSelectorFor: attachmentId [

	^ ('attachment_', attachmentId) asSymbol
]

{ #category : #testing }
LeDatabaseClassStorage >> hasPageStored: aPage inClass: dbClass [

	^ dbClass respondsTo: (self pageSelectorFor: aPage)
]

{ #category : #accessing }
LeDatabaseClassStorage >> loadAttachmentFromMethod: aCompiledMethod [
	"Answer the object encoded in the supplied method"

	^ (aCompiledMethod parseTree comments at: 2) contents base64Decoded
]

{ #category : #accessing }
LeDatabaseClassStorage >> loadFromMethod: aCompiledMethod [
	"Answer the object encoded in the supplied method"
	| jsonString |

	jsonString := (aCompiledMethod parseTree comments at: 2) contents
		copyReplaceAll: '""' with: '"'.
	^ [ LeJsonV4 uniqueInstance deserialize: jsonString readStream ]
		on: NeoJSONParseError 
		do: [ :ex | | loadError |
			UIManager default inform: 'Lepiter: Unable to load: ', aCompiledMethod printString, ' due to a JSON parser error'.
			self renameToCorrupt: aCompiledMethod.
			loadError := LeDBLoadError new 
				fileReference: nil;
				reason: 'JSON Parse Error';
				originalException: ex.
			loadError signal ]
]

{ #category : #accessing }
LeDatabaseClassStorage >> loadJsonFromMethod: aCompiledMethod [
	"Load the JSON object from the supplied method without any interpretation of the contents, but keeping the attribute order"
	| jsonString |

	jsonString := (aCompiledMethod parseTree comments at: 2) contents
		copyReplaceAll: '""' with: '"'.
	ASTCache default removeKey: aCompiledMethod.
	^ (NeoJSONReader new on: jsonString readStream)
			mapClass: OrderedDictionary;
			next
]

{ #category : #accessing }
LeDatabaseClassStorage >> pageProtocolFor: aPage [
	"Answer the protocol where aPage is stored"

	^ (aPage isKindOf: LeExplicitLinks)
		ifTrue: [ 'links' ]
		ifFalse: [ 'pages' ]
]

{ #category : #accessing }
LeDatabaseClassStorage >> pageSelectorFor: aPage [
	"Answer the method name where aPage is stored"

	^ (aPage isKindOf: LeExplicitLinks)
		ifTrue: [ #explicitLinks ]
		ifFalse: [ self pageSelectorForUid: aPage uid ]
]

{ #category : #accessing }
LeDatabaseClassStorage >> pageSelectorForUid: aPageUid [
	"Answer the method name where the page with the given id is stored"

	^ ('page_', aPageUid asString36) asSymbol
]

{ #category : #accessing }
LeDatabaseClassStorage >> pageSelectorsIn: aClass [
	"Answer the selectors storing pages in aClass"

	^ aClass class selectors select: [ :each |
		each beginsWith: 'page_' ]
]

{ #category : #saving }
LeDatabaseClassStorage >> save: anObject inClass: aClass selector: aSymbol title: aString classified: protocol [
	"Write the supplied page back to the specified class.
	Note that unlike the file store, no backup of the page is made.  Code versioning is assumed to take care of this."
	| jsonString sourceCode |

	jsonString := String streamContents: [ :stream |
		[ self serialize: anObject on: stream prettyPrint: true ] ifCurtailed:
			[ Stdio stdout
				<< 'ERROR: Save to: ';
				<< aClass name;
				<< '>>';
				<< aSymbol;
				<< ' curtailed';
				lf; flush.
			self error: 'Lepiter DB page save curtailed' ] ].
	jsonString := jsonString copyReplaceAll: '"' with: '""'.
	sourceCode := String streamContents: [ :stream |
		stream
			<< aSymbol; cr;
			<< '"Automatically generated'; cr;
			<< aString;
			nextPut: $"; cr;
			nextPut: $";
			<< jsonString;
			nextPut: $" ].
	aClass class
		compile: sourceCode
		classified: protocol.

]

{ #category : #saving }
LeDatabaseClassStorage >> saveAttachment: aByteArray inClass: aClass selector: aSymbol title: aString classified: protocol metadata: aLeAttachment [
	"Write the supplied ByteArray to the specified class"
	| sourceCode |

	sourceCode := String 
		new: (aByteArray size * 4 / 3 + aSymbol size + aString size + 100) rounded
		streamContents: [ :stream |
			stream
				<< aSymbol; cr;
				<< '"Automatically generated'; cr;
				<< aString;
				nextPut: $"; cr;
				nextPut: $".
			ZnBase64Encoder new encode: aByteArray readStream to: stream.
			stream 
				nextPut: $"; cr;
				cr; tab;
				<< '^ LeJsonV4 uniqueInstance deserialize: '''.
			LeJsonV4 uniqueInstance serialize: aLeAttachment on: stream prettyPrint: false.
			stream << ''' readStream' ].
	aClass class
		compile: sourceCode
		classified: protocol.
]

{ #category : #saving }
LeDatabaseClassStorage >> savePage: aPage inClass: aClass [
	"Write the supplied page back to the specified class.
	Note that unlike the file store, no backup of the page is made.  Code versioning is assumed to take care of this."

	self
		save: aPage
		inClass: aClass 
		selector: (self pageSelectorFor: aPage) 
		title: aPage title
		classified: (self pageProtocolFor: aPage).
	LeLocalStoreSignal new
		pageTitle: aPage title;
		operation: #save;
		emit.
]

{ #category : #saving }
LeDatabaseClassStorage >> serialize: aPage on: aStream prettyPrint: aBoolean [

	self subclassResponsibility 
]

{ #category : #'schema updating' }
LeDatabaseClassStorage >> updateDbStore: store [
	"Update the store to the latest minor version.
	Subclasses should overwrite with the appropriate action."
]

Class {
	#name : #LeDatabaseClassStorage,
	#superclass : #Object,
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #accessing }
LeDatabaseClassStorage >> attachmentIdsFor: dbClass [

	^ dbClass class selectors 
		select: [ :selector | selector beginsWith: 'attachment_' ]
		thenCollect: [ :selector | selector 
			copyFrom: 'attachment_' size  + 1
			to: selector size ]
]

{ #category : #accessing }
LeDatabaseClassStorage >> attachmentSelectorFor: attachmentId [

	^ ('attachment_', attachmentId) asSymbol
]

{ #category : #enumerating }
LeDatabaseClassStorage >> explicitLinksOrNilFor: dbClass [

	^ (dbClass respondsTo: #explicitLinks) ifTrue:
		[ self loadFromMethod: (dbClass class >> #explicitLinks) ]
	ifFalse:
		[ nil ]
]

{ #category : #saving }
LeDatabaseClassStorage >> findAttachmentById: aSelector inClass: aClass [
	^ self loadAttachmentFromMethod: aClass class >> aSelector
]

{ #category : #saving }
LeDatabaseClassStorage >> hasAttachmentWithId: aSelector inClass: aClass [
	^ aClass respondsTo: aSelector
]

{ #category : #testing }
LeDatabaseClassStorage >> hasPageStored: aPage inClass: dbClass [

	^ dbClass respondsTo: (self pageSelectorFor: aPage)
]

{ #category : #accessing }
LeDatabaseClassStorage >> hashFromMethod: aCompiledMethod [
	"Answer the hash of an object encoded in the supplied method"
	
	<return: #LeBinaryContentsHash>
	| jsonString |

	jsonString := (aCompiledMethod parseTree comments at: 2) contents.
	^ LeBinaryContentsHash fromString: jsonString.
]

{ #category : #accessing }
LeDatabaseClassStorage >> loadAttachmentFromMethod: aCompiledMethod [
	"Answer the object encoded in the supplied method"

	^ (aCompiledMethod parseTree comments at: 2) contents base64Decoded
]

{ #category : #accessing }
LeDatabaseClassStorage >> loadFromClass: aClass selector: aSymbol [

	^ self loadFromMethod: aClass class >> aSymbol.
]

{ #category : #accessing }
LeDatabaseClassStorage >> loadFromMethod: aCompiledMethod [
	"Answer the object encoded in the supplied method"
	| jsonString |

	jsonString := (aCompiledMethod parseTree comments at: 2) contents.
	self 
		forPharo11AndPharo12: [] 
		forPharo10: [ 
			"In Pharo 10 double quotes are doubled in comments, but not in Pharo 11"
			jsonString :=  jsonString copyReplaceAll: '""' with: '"' ].
			
	^ [ LeJsonV4 uniqueInstance deserialize: jsonString readStream ]
		on: NeoJSONParseError 
		do: [ :ex | | loadError |
			UIManager default inform: 'Lepiter: Unable to load: ', aCompiledMethod printString, ' due to a JSON parser error'.
			self renameTo: 'corrupted' method: aCompiledMethod.
			loadError := LeDBLoadError new.
			loadError properties
				at: #class put: aCompiledMethod methodClass;
				at: #selector put: aCompiledMethod selector.
			loadError
				reason: 'JSON Parse Error';
				originalException: ex.
			loadError signal ].
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
LeDatabaseClassStorage >> loadPropertiesFromClass: aClass [
	"Answer the properties encoded in the supplied method"
	| jsonString |

	jsonString := ((aClass >> #databaseProperties) parseTree comments at: 2) contents
		copyReplaceAll: '""' with: '"'.
	^ [ (NeoJSONReader on: jsonString readStream)
		mapClass: GtStringContentDictionary;
		next ]
		on:  Error
		do: [ :ex | | loadError |
			UIManager default inform: 'Lepiter: Unable to load database properties due to a JSON parser error'.
			loadError := LeDBLoadError new.
			loadError properties
				at: #class put: aClass;
				at: #selector put: #databaseProperties.
			loadError
				reason: 'JSON Parse Error';
				originalException: ex.
			loadError signal ].
]

{ #category : #accessing }
LeDatabaseClassStorage >> pagePragmaFor: aPage [
	"Answer the pragma describing aPage"

	^ (aPage isKindOf: LeExplicitLinks)
		ifTrue: [ '<lepiterExplicitLinksStore>' ]
		ifFalse: [ '<lepiterPageStore>' ]
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

{ #category : #accessing }
LeDatabaseClassStorage >> pageUidForSelector: aSymbol [

	^ UUID fromString36: (aSymbol copyFrom: 6 to: aSymbol size)
]

{ #category : #accessing }
LeDatabaseClassStorage >> renameTo: prefixString method: aCompiledMethod [
	| pageSource newSource |

	self assert: aCompiledMethod parseTree comments size equals: 2.
	pageSource := aCompiledMethod sourceCode.
	newSource := prefixString, '_', (pageSource copyFrom: 6 to: pageSource size).
	aCompiledMethod methodClass
		compile: newSource
		classified: prefixString.
	aCompiledMethod removeFromSystem. 
]

{ #category : #accessing }
LeDatabaseClassStorage >> renameTo: prefixString pageUid: aPageUid class: aClass [

	self renameTo: prefixString method: (aClass class >> (self pageSelectorForUid: aPageUid)).
]

{ #category : #saving }
LeDatabaseClassStorage >> save: anObject inClass: aClass selector: aSymbol title: aString pragma: pragmaString classified: protocol [
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
			<< (aString copyReplaceAll: '"' with: '""');
			nextPut: $"; cr.
		pragmaString ifNotNil:
			[ stream
				tab;
				<< pragmaString;
				cr ].
		stream
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
				tab;
				<< '<lepiterAttachmentStore>';
				cr;
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
		pragma: (self pagePragmaFor: aPage)
		classified: (self pageProtocolFor: aPage).
	LeLocalStoreSignal new
		pageTitle: aPage title;
		operation: #save;
		emit.
]

{ #category : #saving }
LeDatabaseClassStorage >> saveProperties: aDictionary inClass: aClass [
	"Write the supplied proprties back to the specified class."
	| jsonString sourceCode |

	jsonString := STONJSON toStringPretty: aDictionary.
	jsonString := jsonString copyReplaceAll: '"' with: '""'.
	sourceCode := String streamContents: [ :stream |
		stream
			<< 'databaseProperties'; cr;
			tab;
			<< '"Automatically generated"'; cr;
			tab;
			<< '<lepiterDatabasePropertiesStore>'; cr.
		stream
			nextPut: $";
			<< jsonString;
			nextPut: $" ].
	aClass class
		compile: sourceCode
		classified: 'properties'.

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

Class {
	#name : #LeClassStorage,
	#superclass : #Object,
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #testing }
LeClassStorage >> hasPageStored: aPage inClass: dbClass [

	^ dbClass respondsTo: (self pageSelectorFor: aPage)
]

{ #category : #accessing }
LeClassStorage >> loadFromMethod: aCompiledMethod [
	"Answer the object encoded in the supplied method"
	| jsonString |

	jsonString := (aCompiledMethod comments at: 2)
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
LeClassStorage >> loadJsonFromMethod: aCompiledMethod [
	"Load the JSON object from the supplied method without any interpretation of the contents, but keeping the attribute order"
	| jsonString |

	jsonString := (aCompiledMethod comments at: 2)
		copyReplaceAll: '""' with: '"'.
	^ (NeoJSONReader new on: jsonString readStream)
			mapClass: OrderedDictionary;
			next
]

{ #category : #accessing }
LeClassStorage >> pageProtocolFor: aPage [
	"Answer the protocol where aPage is stored"

	^ (aPage isKindOf: LeExplicitLinks)
		ifTrue: [ 'links' ]
		ifFalse: [ 'pages' ]
]

{ #category : #accessing }
LeClassStorage >> pageSelectorFor: aPage [
	"Answer the method name where aPage is stored"

	^ (aPage isKindOf: LeExplicitLinks)
		ifTrue: [ #explicitLinks ]
		ifFalse: [ self pageSelectorForUid: aPage uid ]
]

{ #category : #accessing }
LeClassStorage >> pageSelectorForUid: aPageUid [
	"Answer the method name where the page with the given id is stored"

	^ ('page_', aPageUid asString36) asSymbol
]

{ #category : #accessing }
LeClassStorage >> pageSelectorsIn: aClass [
	"Answer the selectors storing pages in aClass"

	^ aClass class selectors select: [ :each |
		each beginsWith: 'page_' ]
]

{ #category : #saving }
LeClassStorage >> save: anObject inClass: aClass selector: aSymbol title: aString classified: protocol [
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
			<< '"Automatically generated, do not edit'; cr;
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
LeClassStorage >> savePage: aPage inClass: aClass [
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
LeClassStorage >> serialize: aPage on: aStream prettyPrint: aBoolean [

	self subclassResponsibility 
]

{ #category : #'schema updating' }
LeClassStorage >> updateDbStore: store [
	"Update the store to the latest minor version.
	Subclasses should overwrite with the appropriate action."
]

"
TGtMacroStringEncoding provides convenience methods to convert FileReferences to and from strings, allowing {{gtMethod:name=FileLocator class>>#supportedOrigins}} as macro names encoded with curly-braces. 

"
Trait {
	#name : #TGtMacroFileReferenceEncoding,
	#category : #'Lepiter-Utilities'
}

{ #category : #accessing }
TGtMacroFileReferenceEncoding >> decodeFileReferenceString: aString [
	"Answer a FileReference or FileLocator from the supplied string.
	FileLocator origins are available as formatted strings, e.g.
		{home}/myDirectory
	is the equivalent of
		FileLocator home / 'myDirectory'"
	| namedDirectories regex name path |

	namedDirectories := (FileLocator supportedOrigins collect: [ :origin | 
		origin -> (FileLocator origin: origin) ]) asGtStringContentDictionary.
	"TODO: Add support for additional named directories"
	"namedDirectories at: #dbParentDirectory put: localRoot parent."
	regex := '\{([a-zA-Z]+)\}(.*)' asRegex.
	^ (regex matches: aString) ifTrue: 
		[ name := regex subexpression: 2.
		path := regex subexpression: 3.
		namedDirectories at: name
			ifPresent: [ :locator | locator resolve: path allButFirst ]
			ifAbsent: [ self error: 'Unknown directory: ', name printString ] ]
	ifFalse:
	 	[ aString asFileReference ].
]

{ #category : #accessing }
TGtMacroFileReferenceEncoding >> encodeFileReferenceToString: aFileReferenceStringOrNil [
	"Answer the string form of the supplied reference"

	aFileReferenceStringOrNil ifNil: [ ^ nil ].
	^ aFileReferenceStringOrNil ifNotNil: 
			[ aFileReferenceStringOrNil isString ifTrue:
				[ aFileReferenceStringOrNil ]
			ifFalse: [ aFileReferenceStringOrNil class = FileLocator
				ifTrue: [ aFileReferenceStringOrNil asString ]
				ifFalse: [ aFileReferenceStringOrNil fullName ] ] ]
]

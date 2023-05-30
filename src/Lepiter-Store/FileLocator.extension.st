Extension { #name : #FileLocator }

{ #category : #'*Lepiter-Store' }
FileLocator >> asLepiterZnUrl [
	| segments |

	segments := OrderedCollection new.
	segments add: '{', self origin, '}'.
	segments addAll: path segments.
	^ ZnUrl new
		scheme: #file;
		segments: segments.

]

{ #category : #'*Lepiter-Store' }
FileLocator class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."
	| src regex originName path |

	src := aDictionary at: #filename.
	regex := '\{([a-zA-Z]+)\}(.*)' asRegex.
	^ (regex matches: src) ifTrue: 
		[ originName := (regex subexpression: 2) asSymbol.
		path := regex subexpression: 3.
		(self supportedOrigins includes: originName)
			ifTrue: [ (self origin: originName) resolve: path allButFirst ]
			ifFalse: [ self error: 'Unknown origin: ', originName printString ] ]
	ifFalse:
	 	[ self error: 'Invalid FileLocator: ', src ].
]

{ #category : #'*Lepiter-Store' }
FileLocator class >> leJsonV4MappingFor: aNeoJSONMapper [
	"FileReferences are encoded as their type and a single string in default FileReference format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV4Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #filename
			getter: [ :object | object gtDisplayString ]
			setter: [ :fileString | fileString asFileReference ] ].

]

{ #category : #'*Lepiter-Store' }
FileLocator class >> leJsonV4Name [

	^ #fileLocator
]

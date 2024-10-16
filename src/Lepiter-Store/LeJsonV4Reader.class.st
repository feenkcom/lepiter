Class {
	#name : #LeJsonV4Reader,
	#superclass : #NeoJSONReader,
	#instVars : [
		'objects',
		'typeMap'
	],
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #mapping }
LeJsonV4Reader >> for: smalltalkClass do: block [
	| mapping |

	mapping := super for: smalltalkClass do: block.
	typeMap at: smalltalkClass leJsonV4Name put: smalltalkClass.
	^ mapping
]

{ #category : #'initialize-release' }
LeJsonV4Reader >> initialize [

	super initialize.
	typeMap := GtStringContentDictionary new.
]

{ #category : #accessing }
LeJsonV4Reader >> mapClass [
	"Return the collection type to use for JSON maps"
	
	^ mapClass ifNil: [ GtStringContentDictionary ]
]

{ #category : #accessing }
LeJsonV4Reader >> next [

	^ self objectFor: super next
]

{ #category : #accessing }
LeJsonV4Reader >> nextAs: schema [

	^ self objectFor: (super nextAs: schema)
]

{ #category : #accessing }
LeJsonV4Reader >> nextListAs: schema [

	^ self objectFor: (super nextListAs: schema)
]

{ #category : #private }
LeJsonV4Reader >> object: type from: map [

	^ typeMap at: type
		ifPresent: [ :cls | cls leFromJsonV4Dictionary: map ]
		ifAbsent: [ self unknownSnippetTypeFrom: map ]
]

{ #category : #private }
LeJsonV4Reader >> objectFor: anObject [
	"Minimise memory usage by making Strings and ByteArrays singular."

	^ (anObject isString or: [ anObject class = ByteArray ])
		ifTrue: [ objects at: anObject ifAbsentPut: [ anObject ] ]
		ifFalse: [ anObject ].
]

{ #category : #'initialize-release' }
LeJsonV4Reader >> on: aStream [

	super on: aStream.
	objects := Dictionary new.
]

{ #category : #parsing }
LeJsonV4Reader >> parseMap [ 
	| map |

	map := super parseMap.
	^ map 
		at: '__type'
		ifPresent: [ :type | self object: type from: map ]
		ifAbsent: [ map ]
]

{ #category : #parsing }
LeJsonV4Reader >> parseValue [ 

	^ self objectFor: super parseValue
]

{ #category : #copying }
LeJsonV4Reader >> postCopy [
	super postCopy.
	readStream := nil.
	stringStream := nil.
	listClass := nil.
	mapClass := nil.
	objects := nil
]

{ #category : #private }
LeJsonV4Reader >> unknownSnippetTypeFrom: map [
	"If the supplied map looks like a snippet, answer an unknown snippet, otherwise raise an exception"

	| children snippet |
	"map is considered a snippet if it has all the keys of LeBlock"
	((LeSnippet leJsonV4AttributeMapping collect: #key as: GtStringContentSet)
		difference: map keys) ifNotEmpty: [ self error: 'Unknown snippet type' ].

	children := map at: 'children'.
	map at: 'children' put: LeSnippets new.
	snippet := LeUnknownSnippet
			jsonString: (String
					streamContents: [ :stream | 
						LeJsonV4 uniqueInstance
							serialize: map
							on: stream
							prettyPrint: true ]).
	snippet
		children: children;
		uid: (map at: 'uid'). 
	map at: 'editTime' ifPresent: [ :editTime | snippet editTime: editTime ].
	^ snippet
]

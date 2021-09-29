"
LeJsonV3Reader is a type of {{gtClass:name=NeoJSONReader}} that:

- Returns a single instance for all objects that are equal in the JSON string.
- Stores a schema identifier in the first mapped object saved.
- supports storing objects in the form: 

```
	{ 
		""__type"" : <type name>,
		""__schema"" : <schema identifier>,
		""attribute name"" : <attribute value> ...
	}
```


## Internal Representation and Key Implementation Points.

### Instance Variables
	objects:		<Dictionary> 	Holds the objects used to keep a single instance of equal objects
	typeMap:		<Dictionary> 	Maps the type name to the class that decodes the object


### Implementation Points

"
Class {
	#name : #LeJsonV3Reader,
	#superclass : #NeoJSONReader,
	#instVars : [
		'objects',
		'typeMap'
	],
	#category : 'Lepiter-Store-JSONV3'
}

{ #category : #mapping }
LeJsonV3Reader >> for: smalltalkClass do: block [
	| mapping |

	mapping := super for: smalltalkClass do: block.
	typeMap at: smalltalkClass leJsonV3Name put: smalltalkClass.
	^ mapping
]

{ #category : #'initialize-release' }
LeJsonV3Reader >> initialize [

	super initialize.
	typeMap := Dictionary new.
]

{ #category : #accessing }
LeJsonV3Reader >> next [

	^ self objectFor: super next
]

{ #category : #accessing }
LeJsonV3Reader >> nextAs: schema [

	^ self objectFor: (super nextAs: schema)
]

{ #category : #accessing }
LeJsonV3Reader >> nextListAs: schema [

	^ self objectFor: (super nextListAs: schema)
]

{ #category : #private }
LeJsonV3Reader >> object: type from: map [

	^ typeMap at: type
		ifPresent: [ :cls | cls leFromJsonV3Dictionary: map ]
		ifAbsent: [ self unknownSnippetTypeFrom: map ]
]

{ #category : #private }
LeJsonV3Reader >> objectFor: anObject [
	"Answer the single instance of anObject."

	^ objects at: anObject ifAbsentPut: [ anObject ]
]

{ #category : #'initialize-release' }
LeJsonV3Reader >> on: aStream [

	super on: aStream.
	objects := Dictionary new.
]

{ #category : #parsing }
LeJsonV3Reader >> parseMap [ 
	| map |

	map := super parseMap.
	^ map 
		at: #'__type'
		ifPresent: [ :type | self object: type from: map ]
		ifAbsent: [ map ]
]

{ #category : #parsing }
LeJsonV3Reader >> parseValue [ 

	^ self objectFor: super parseValue
]

{ #category : #private }
LeJsonV3Reader >> unknownSnippetTypeFrom: map [
	"If the supplied map looks like a snippet, answer an unknown snippet, otherwise raise an exception"
	| children snippet |

	"map is considered a snippet if it has all the keys of LeBlock"
	((LeSnippet leJsonV3AttributeMapping collect: #key as: Set) difference: map keys) ifNotEmpty: 
		[ self error: 'Unknown snippet type' ].

	children := map at: #children.
	map at: #children put: LeSnippets new.
	snippet := LeUnknownSnippet jsonString: (String streamContents: [ :stream | 
				LeJsonV3 uniqueInstance serialize: map on: stream prettyPrint: true ]).
	snippet 
		children: children;
		uid: (map at: #uid).
	^ snippet
]

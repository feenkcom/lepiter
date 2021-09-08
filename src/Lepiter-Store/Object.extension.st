Extension { #name : 'Object' }

{ #category : '*Lepiter-Store' }
Object class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Subclasses can override this to provide custom mappings."
	| anObject |

	anObject := self new.
	aDictionary keysAndValuesDo: [ :key :value |
		(#(__schema __type) includes: key) ifFalse:
			[ anObject
				perform: key asSymbol asMutator
				with: value ] ].
	^ anObject
]

{ #category : '*Lepiter-Store' }
Object class >> leJsonV4AddMappingsTo: aJsonMapping [
	"The default mapping is to write all instance variables.
	Subclasses may overwrite this with specific behaviour"

	self allInstVarNames do: [ :instVarName |
		aJsonMapping mapAccessor: instVarName to: instVarName ].
]

{ #category : '*Lepiter-Store' }
Object class >> leJsonV4MappingFor: aNeoJSONMapper [
	"By default, Lepiter objects are written as a mapping.
	Any subclasses that want a different representation should over-write this method"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV4Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		self leJsonV4AddMappingsTo: mapping ].

]

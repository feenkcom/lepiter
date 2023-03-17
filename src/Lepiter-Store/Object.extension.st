Extension { #name : #Object }

{ #category : #'*Lepiter-Store' }
Object class >> deSerializeAllImplementorsInstances [
	"Answer a collection of instances to be tested for serialisation / deserialisation"

	^ { self new }
]

{ #category : #'*Lepiter-Store' }
Object class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Subclasses can override this to provide custom mappings."
	| aLeModel |

	aLeModel := self new.
	self leJsonV4AttributeMapping do: [ :attributeMap |
		aDictionary 
			at: attributeMap value
			ifPresent: [ :aValue |
				aLeModel
					perform: attributeMap key asMutator
					with: aValue ]
			ifAbsent: [ "ignore it" ]
	].
	^ aLeModel
]

{ #category : #'*Lepiter-Store' }
Object class >> leJsonV4AddMappingsTo: aJsonMapping [
	"Subclasses may over-write this to add custom mappings"

	self leJsonV4AttributeMapping do: [ :attributeMap |
		aJsonMapping mapAccessor: attributeMap key to: attributeMap value ].
]

{ #category : #'*Lepiter-Store' }
Object class >> leJsonV4AttributeMapping [
	"Answer the Array of attribute to store keys.
	Subclasses should override this with their attributes."

	^ self allInstVarNames collect: [ :instVarName |
		instVarName -> instVarName ]
]

{ #category : #'*Lepiter-Store' }
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

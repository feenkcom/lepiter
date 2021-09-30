Extension { #name : #LeModel }

{ #category : #'*Lepiter-Store' }
LeModel class >> leFromJsonV3Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Subclasses can override this to provide custom mappings."
	| aLeModel |

	aLeModel := self new.
	self leJsonV3AttributeMapping do: [ :attributeMap |
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
LeModel class >> leFromJsonV4Dictionary: aDictionary [
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
LeModel class >> leJsonV3AddMappingsTo: aJsonMapping [
	"Subclasses may over-write this to add custom mappings"

	self leJsonV3AttributeMapping do: [ :attributeMap |
		aJsonMapping mapAccessor: attributeMap key to: attributeMap value ].
]

{ #category : #'*Lepiter-Store' }
LeModel class >> leJsonV3AttributeMapping [
	"Answer the Array of attribute to store keys.
	Subclasses should override this with their attributes.
	This is an array as it is normally cached."

	^ OrderedCollection new.
]

{ #category : #'*Lepiter-Store' }
LeModel class >> leJsonV3MappingFor: aNeoJSONMapper [
	"By default, Lepiter objects are written as a mapping.
	Any subclasses that want a different representation should over-write this method"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV3Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		self leJsonV3AddMappingsTo: mapping ].

]

{ #category : #'*Lepiter-Store' }
LeModel class >> leJsonV3Name [

	^ nil
]

{ #category : #'*Lepiter-Store' }
LeModel class >> leJsonV4AddMappingsTo: aJsonMapping [
	"Subclasses may over-write this to add custom mappings"

	self leJsonV4AttributeMapping do: [ :attributeMap |
		aJsonMapping mapAccessor: attributeMap key to: attributeMap value ].
]

{ #category : #'*Lepiter-Store' }
LeModel class >> leJsonV4AttributeMapping [
	"Answer the Array of attribute to store keys.
	Subclasses should override this with their attributes.
	This is an array as it is normally cached."

	^ OrderedCollection new.
]

{ #category : #'*Lepiter-Store' }
LeModel class >> leJsonV4Name [

	^ nil
]

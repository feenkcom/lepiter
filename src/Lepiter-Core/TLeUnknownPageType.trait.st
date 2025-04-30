Trait {
	#name : #TLeUnknownPageType,
	#instVars : [
		'pageType',
		'additionalFields',
		'pageTypeRepo'
	],
	#category : #'Lepiter-Core-Traits'
}

{ #category : #jsonV4 }
TLeUnknownPageType classSide >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Store additional fields in the slot named as such."

	| anUnknownPageType knownMapKeys |
	anUnknownPageType := super leFromJsonV4Dictionary: aDictionary.
	knownMapKeys := self leJsonV4AttributeMapping collect: #value.
	anUnknownPageType
		additionalFields: (aDictionary
				associationsSelect: [ :each | (knownMapKeys includes: each key) not ]).
	aDictionary
		at: #additionalFields
		ifPresent: [ :aValue | anUnknownPageType additionalFields addAll: aValue ].
	aDictionary
		at: #title
		ifPresent: [ :aValue | anUnknownPageType title: '*UNKNOWN* | ' ,aValue ].
	^ anUnknownPageType
]

{ #category : #jsonV4 }
TLeUnknownPageType classSide >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #pageTypeRepo -> #pageTypeRepo;
		add: #pageType -> #'__type';
		yourself
]

{ #category : #jsonV4 }
TLeUnknownPageType classSide >> leJsonV4MappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: self
		customDo: [ :aNeoJSONCustomMapping | 
			aNeoJSONCustomMapping
				encoder: [ :anUnknownPageType | 
					| aDictionary |
					aDictionary := GtStringContentDictionary new.
					self leJsonV4AttributeMapping
						do: [ :attributeMap | 
							aDictionary
								at: attributeMap value
								put: (anUnknownPageType perform: attributeMap key) ].
					anUnknownPageType additionalFields
						ifNotNil: [ :notNil | aDictionary addAll: notNil ].
					aDictionary
						at: #title
						ifPresent: [ :aValue | aDictionary at: #title put: (aValue copyReplaceAll: '*UNKNOWN* | ' with: '') ].
								aDictionary ] ]
]

{ #category : #accessing }
TLeUnknownPageType >> additionalFields [
	^ additionalFields
]

{ #category : #accessing }
TLeUnknownPageType >> additionalFields: anObject [
	additionalFields := anObject
]

{ #category : #accessing }
TLeUnknownPageType >> pageType [
	^ pageType
]

{ #category : #accessing }
TLeUnknownPageType >> pageType: anObject [
	pageType := anObject
]

{ #category : #accessing }
TLeUnknownPageType >> pageTypeRepo [
	^ pageTypeRepo
]

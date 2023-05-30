Extension { #name : #LePage }

{ #category : #'*Lepiter-Store' }
LePage >> fromStonMapKey: key value: value [
	"STON V2 stored the title in the page and the type had to match.
	Currently the type is set when updating the title, so the type can be ignored."

	super fromStonMapKey: key value: value.
	key = #title ifTrue: [ self title: value ].

]

{ #category : #'*Lepiter-Store' }
LePage class >> leFromJsonV3Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Set the page in the page's type."
	| aLeModel |

	aLeModel := super leFromJsonV3Dictionary: aDictionary.
	aLeModel type page: aLeModel.
	^ aLeModel
]

{ #category : #'*Lepiter-Store' }
LePage class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Set the page in the page's type."
	| aLeModel |

	aLeModel := super leFromJsonV4Dictionary: aDictionary.
	aLeModel type page: aLeModel.
	^ aLeModel
]

{ #category : #'*Lepiter-Store' }
LePage class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#type -> #pageType);
		add: (#basicUid -> #uid);
		yourself
]

{ #category : #'*Lepiter-Store' }
LePage class >> leJsonV3Name [

	^ #page
]

{ #category : #'*Lepiter-Store' }
LePage class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#type -> #pageType);
		add: (#basicUid -> #uid);
		yourself
]

{ #category : #'*Lepiter-Store' }
LePage class >> leJsonV4Name [

	^ #page
]

{ #category : #'*Lepiter-Store' }
LePage >> stonProcessSubObjects: block [

	super stonProcessSubObjects: block.
	self title: (block value: self title).
	type := block value: type.
]

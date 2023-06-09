Extension { #name : #LeContent }

{ #category : #'*Lepiter-Store' }
LeContent >> fromSton: stonReader [

	stonReader parseMapDo: [ :key :value |
		self fromStonMapKey: key value: value ].
]

{ #category : #'*Lepiter-Store' }
LeContent >> fromStonMapKey: key value: value [

	key = #editEmail ifTrue: [ editEmail := value ].
	key = #createEmail ifTrue: [ createEmail := value ].
	key = #editTime ifTrue: [ editTime := value ].
	key = #createTime ifTrue: [ createTime := value ].
	key = #children ifTrue: [ self children: value ].
]

{ #category : #'*Lepiter-Store' }
LeContent >> gtSerializationFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Serialization';
		priority: 80;
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: JSONParser gtStyler;
		text: [ LeJsonV4 uniqueInstance serializePretty: self ]
]

{ #category : #'*Lepiter-Store' }
LeContent class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#children -> #children);
		add: (#createEmail -> #createEmail);
		add: (#createTime -> #createTime);
		add: (#editEmail -> #editEmail);
		add: (#editTime -> #editTime);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeContent class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#children -> #children);
		add: (#createEmail -> #createEmail);
		add: (#createTime -> #createTime);
		add: (#editEmail -> #editEmail);
		add: (#editTime -> #editTime);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeContent >> reloadCommonMetadataFromContent: aLeContent [
	| attributesReloader |
	attributesReloader := LeContentAttributesReloader forContent: self.
	attributesReloader reloadCommonMetadataFromContent: aLeContent.
	^ attributesReloader hasChanges
]

{ #category : #'*Lepiter-Store' }
LeContent >> stonProcessSubObjects: block [
	"Evaluate block on each of the receiver's variables that are part of the ston state.
	Object>>stonProcessSubObjects: is overridden since part of the receiver's state has circular references, which isn't handled by STON.
	Subclasses should call super to process inherited state."

	editEmail := block value: editEmail.
	createEmail := block value: createEmail.
	editTime := block value: editTime.
	createTime := block value: createTime.
	children := block value: children.
]

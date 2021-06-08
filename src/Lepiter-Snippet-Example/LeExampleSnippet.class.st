Class {
	#name : #LeExampleSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'exampleBehaviorName',
		'exampleSelector',
		'codeExpanded',
		'noCode',
		'previewExpanded',
		'previewShowSelector',
		'previewHeight'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #'api - accessing menu' }
LeExampleSnippet class >> contextMenuItemSpefication [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Example'
]

{ #category : #factory }
LeExampleSnippet class >> empty [
	"Return a content (page or block) with empty values (title or text).
	Required by ${method:LeContent>>#addBlockOfClass:after:}$"
	^ self new
]

{ #category : #jsonV3 }
LeExampleSnippet class >> leJsonV4AttributeMapping [
	"To retries properties:
	(Pragma allNamed: #propertyGetter: in: self) collect: [ :eachPragma | (eachPragma argumentAt: 1) -> (eachPragma argumentAt: 1) ]"
	^ super leJsonV4AttributeMapping
		addAll: {#exampleSelector->#exampleSelector. #previewHeight->#previewHeight. #previewShowSelector->#previewShowSelector. #exampleBehaviorName->#exampleBehaviorName. #codeExpanded->#codeExpanded. #previewExpanded->#previewExpanded. #noCode->#noCode};
		yourself
]

{ #category : #'lepiter-store' }
LeExampleSnippet class >> leJsonV4Name [

	^ 'exampleSnippet'
]

{ #category : #'api - accessing' }
LeExampleSnippet >> asAnnotationString [
	^ String streamContents: [ :aStream |	
		aStream
			nextPutAll: (self exampleBehaviorName ifNil: [ '' ]).

		(self hasExampleBehaviorName and: [ self hasExampleSelector ])
			ifTrue: [ aStream nextPutAll: '>>#' ].

		aStream
			nextPutAll: (self exampleSelector ifNil: [ '' ]).

		self noCode = self defaultNoCode
			ifFalse: [
				aStream
					nextPutAll: ' | noCode=';
					print: self noCode ].
				
		self codeExpanded = self defaultCodeExpanded
			ifFalse: [
				aStream
					nextPutAll: ' | codeExpanded=';
					print: self codeExpanded ].
		
		self previewExpanded = self defaultPreviewExpanded
			ifFalse: [
				aStream
					nextPutAll: ' | previewExpanded=';
					print: self previewExpanded ].
				
		self previewShowSelector = self defaultPreviewShowSelector
			ifFalse: [
				aStream
					nextPutAll: ' | previewShow=';
					print: self previewShowSelector ].
				
		self previewHeight = self defaultPreviewHeight
			ifFalse: [
				aStream
					nextPutAll: ' | previewHeight=';
					print: self previewHeight ] ]
]

{ #category : #'api - accessing' }
LeExampleSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LeExampleSnippetViewModel new snippetModel: self
]

{ #category : #'api - code expanded' }
LeExampleSnippet >> codeExpanded [
	<return: #Boolean>
	<propertyGetter: #codeExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ codeExpanded
]

{ #category : #'api - code expanded' }
LeExampleSnippet >> codeExpanded: aNewCodeExpanded [
	<propertySetter: #codeExpanded>
	<propertyAnnouncement: #LeExampleSnippetCodeExpandedChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasCodeExpanded
		and: [ self codeExpanded = aNewCodeExpanded ])
			ifTrue: [ ^ self ].
	
	self hasCodeExpanded
		ifTrue: [
			| aPreviousCodeExpanded |
			aPreviousCodeExpanded := codeExpanded.
			codeExpanded := nil.
			self onPreviousCodeExpandedUnset: aPreviousCodeExpanded ].
	codeExpanded := aNewCodeExpanded.
	self onNewCodeExpandedSet: aNewCodeExpanded.
	self notifyCodeExpandedChanged
]

{ #category : #'api - accessing' }
LeExampleSnippet >> contentAsString [
	^ '{{gtExample:', self asAnnotationString, '}}'
]

{ #category : #'api - accessing' }
LeExampleSnippet >> copyFrom: aLeExampleSnippet [
	self codeExpanded: aLeExampleSnippet codeExpanded.
	self exampleBehaviorName: aLeExampleSnippet exampleBehaviorName.
	self exampleSelector: aLeExampleSnippet exampleSelector.
	self noCode: aLeExampleSnippet noCode.
	self previewExpanded: aLeExampleSnippet previewExpanded.
	self previewHeight: aLeExampleSnippet previewHeight.
	self previewShowSelector: aLeExampleSnippet previewShowSelector.
]

{ #category : #initialization }
LeExampleSnippet >> defaultCodeExpanded [
	^ true
]

{ #category : #initialization }
LeExampleSnippet >> defaultNoCode [
	^ false
]

{ #category : #initialization }
LeExampleSnippet >> defaultPreviewExpanded [
	^ false
]

{ #category : #initialization }
LeExampleSnippet >> defaultPreviewHeight [
	^ 200
]

{ #category : #initialization }
LeExampleSnippet >> defaultPreviewShowSelector [
	^ #gtViewsFor:
]

{ #category : #'api - example behavior name' }
LeExampleSnippet >> exampleBehaviorName [
	<return: #Symbol>
	<propertyGetter: #exampleBehaviorName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ exampleBehaviorName
]

{ #category : #'api - example behavior name' }
LeExampleSnippet >> exampleBehaviorName: aNewExampleBehaviorName [
	<propertySetter: #exampleBehaviorName>
	<propertyAnnouncement: #LeExampleSnippetExampleBehaviorNameChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasExampleBehaviorName
		and: [ self exampleBehaviorName = aNewExampleBehaviorName ])
			ifTrue: [ ^ self ].
	
	self hasExampleBehaviorName
		ifTrue: [
			| aPreviousExampleBehaviorName |
			aPreviousExampleBehaviorName := exampleBehaviorName.
			exampleBehaviorName := nil.
			self onPreviousExampleBehaviorNameUnset: aPreviousExampleBehaviorName ].
	exampleBehaviorName := aNewExampleBehaviorName.
	self onNewExampleBehaviorNameSet: aNewExampleBehaviorName.
	self notifyExampleBehaviorNameChanged
]

{ #category : #'api - example selector' }
LeExampleSnippet >> exampleSelector [
	<return: #Symbol>
	<propertyGetter: #exampleSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ exampleSelector
]

{ #category : #'api - example selector' }
LeExampleSnippet >> exampleSelector: aNewExampleSelector [
	<propertySetter: #exampleSelector>
	<propertyAnnouncement: #LeExampleSnippetExampleSelectorChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasExampleSelector
		and: [ self exampleSelector = aNewExampleSelector ])
			ifTrue: [ ^ self ].
	
	self hasExampleSelector
		ifTrue: [
			| aPreviousExampleSelector |
			aPreviousExampleSelector := exampleSelector.
			exampleSelector := nil.
			self onPreviousExampleSelectorUnset: aPreviousExampleSelector ].
	exampleSelector := aNewExampleSelector.
	self onNewExampleSelectorSet: aNewExampleSelector.
	self notifyExampleSelectorChanged
]

{ #category : #'api - code expanded' }
LeExampleSnippet >> hasCodeExpanded [
	<return: #Boolean>
	<propertyTester: #codeExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ codeExpanded notNil
]

{ #category : #'api - example behavior name' }
LeExampleSnippet >> hasExampleBehaviorName [
	<return: #Boolean>
	<propertyTester: #exampleBehaviorName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ exampleBehaviorName notNil
]

{ #category : #'api - example selector' }
LeExampleSnippet >> hasExampleSelector [
	<return: #Boolean>
	<propertyTester: #exampleSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ exampleSelector notNil
]

{ #category : #'api - no code' }
LeExampleSnippet >> hasNoCode [
	<return: #Boolean>
	<propertyTester: #noCode>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ noCode notNil
]

{ #category : #'api - preview expanded' }
LeExampleSnippet >> hasPreviewExpanded [
	<return: #Boolean>
	<propertyTester: #previewExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ previewExpanded notNil
]

{ #category : #'api - preview height' }
LeExampleSnippet >> hasPreviewHeight [
	<return: #Boolean>
	<propertyTester: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ previewHeight notNil
]

{ #category : #'api - preview show selector' }
LeExampleSnippet >> hasPreviewShowSelector [
	<return: #Boolean>
	<propertyTester: #previewShowSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ previewShowSelector notNil
]

{ #category : #initialization }
LeExampleSnippet >> initialize [
	super initialize.
	
	codeExpanded := self defaultCodeExpanded.
	noCode := self defaultNoCode.
	previewExpanded := self defaultPreviewExpanded.
	previewShowSelector := self defaultPreviewShowSelector.
	previewHeight := self defaultPreviewHeight
]

{ #category : #'api - no code' }
LeExampleSnippet >> noCode [
	<return: #Boolean>
	<propertyGetter: #noCode>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ noCode
]

{ #category : #'api - no code' }
LeExampleSnippet >> noCode: aNewNoCode [
	<propertySetter: #noCode>
	<propertyAnnouncement: #LeExampleSnippetNoCodeChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasNoCode
		and: [ self noCode = aNewNoCode ])
			ifTrue: [ ^ self ].
	
	self hasNoCode
		ifTrue: [
			| aPreviousNoCode |
			aPreviousNoCode := noCode.
			noCode := nil.
			self onPreviousNoCodeUnset: aPreviousNoCode ].
	noCode := aNewNoCode.
	self onNewNoCodeSet: aNewNoCode.
	self notifyNoCodeChanged
]

{ #category : #'api - code expanded' }
LeExampleSnippet >> notifyCodeExpandedChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #codeExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeExampleSnippetCodeExpandedChanged new
		source: self;
		snippet: self;
		codeExpanded: self codeExpanded).
]

{ #category : #'api - example behavior name' }
LeExampleSnippet >> notifyExampleBehaviorNameChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #exampleBehaviorName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeExampleSnippetExampleBehaviorNameChanged new
		source: self;
		snippet: self;
		exampleBehaviorName: self exampleBehaviorName).
]

{ #category : #'api - example selector' }
LeExampleSnippet >> notifyExampleSelectorChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #exampleSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeExampleSnippetExampleSelectorChanged new
		source: self;
		snippet: self;
		exampleSelector: self exampleSelector).
]

{ #category : #'api - no code' }
LeExampleSnippet >> notifyNoCodeChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #noCode>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeExampleSnippetNoCodeChanged new
		source: self;
		snippet: self;
		noCode: self noCode).
]

{ #category : #'api - preview expanded' }
LeExampleSnippet >> notifyPreviewExpandedChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #previewExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeExampleSnippetPreviewExpandedChanged new
		source: self;
		snippet: self;
		previewExpanded: self previewExpanded).
]

{ #category : #'api - preview height' }
LeExampleSnippet >> notifyPreviewHeightChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeExampleSnippetPreviewHeightChanged new
		source: self;
		snippet: self;
		previewHeight: self previewHeight).
]

{ #category : #'api - preview show selector' }
LeExampleSnippet >> notifyPreviewShowSelectorChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #previewShowSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeExampleSnippetPreviewShowSelectorChanged new
		source: self;
		snippet: self;
		previewShowSelector: self previewShowSelector).
]

{ #category : #'api - code expanded' }
LeExampleSnippet >> onNewCodeExpandedSet: aNewCodeExpanded [
	"Is sent after a new value of the codeExpanded is assigned"
	<propertySetHook: #codeExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - example behavior name' }
LeExampleSnippet >> onNewExampleBehaviorNameSet: aNewExampleBehaviorName [
	"Is sent after a new value of the exampleBehaviorName is assigned"
	<propertySetHook: #exampleBehaviorName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - example selector' }
LeExampleSnippet >> onNewExampleSelectorSet: aNewExampleSelector [
	"Is sent after a new value of the exampleSelector is assigned"
	<propertySetHook: #exampleSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - no code' }
LeExampleSnippet >> onNewNoCodeSet: aNewNoCode [
	"Is sent after a new value of the noCode is assigned"
	<propertySetHook: #noCode>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - preview expanded' }
LeExampleSnippet >> onNewPreviewExpandedSet: aNewPreviewExpanded [
	"Is sent after a new value of the previewExpanded is assigned"
	<propertySetHook: #previewExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - preview height' }
LeExampleSnippet >> onNewPreviewHeightSet: aNewPreviewHeight [
	"Is sent after a new value of the previewHeight is assigned"
	<propertySetHook: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - preview show selector' }
LeExampleSnippet >> onNewPreviewShowSelectorSet: aNewPreviewShowSelector [
	"Is sent after a new value of the previewShowSelector is assigned"
	<propertySetHook: #previewShowSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - code expanded' }
LeExampleSnippet >> onPreviousCodeExpandedUnset: aPreviousCodeExpanded [
	"Is sent after a previous value of the codeExpanded is de-assigned"
	<propertyUnsetHook: #codeExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - example behavior name' }
LeExampleSnippet >> onPreviousExampleBehaviorNameUnset: aPreviousExampleBehaviorName [
	"Is sent after a previous value of the exampleBehaviorName is de-assigned"
	<propertyUnsetHook: #exampleBehaviorName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - example selector' }
LeExampleSnippet >> onPreviousExampleSelectorUnset: aPreviousExampleSelector [
	"Is sent after a previous value of the exampleSelector is de-assigned"
	<propertyUnsetHook: #exampleSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - no code' }
LeExampleSnippet >> onPreviousNoCodeUnset: aPreviousNoCode [
	"Is sent after a previous value of the noCode is de-assigned"
	<propertyUnsetHook: #noCode>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - preview expanded' }
LeExampleSnippet >> onPreviousPreviewExpandedUnset: aPreviousPreviewExpanded [
	"Is sent after a previous value of the previewExpanded is de-assigned"
	<propertyUnsetHook: #previewExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - preview height' }
LeExampleSnippet >> onPreviousPreviewHeightUnset: aPreviousPreviewHeight [
	"Is sent after a previous value of the previewHeight is de-assigned"
	<propertyUnsetHook: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - preview show selector' }
LeExampleSnippet >> onPreviousPreviewShowSelectorUnset: aPreviousPreviewShowSelector [
	"Is sent after a previous value of the previewShowSelector is de-assigned"
	<propertyUnsetHook: #previewShowSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - preview expanded' }
LeExampleSnippet >> previewExpanded [
	<return: #Boolean>
	<propertyGetter: #previewExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ previewExpanded
]

{ #category : #'api - preview expanded' }
LeExampleSnippet >> previewExpanded: aNewPreviewExpanded [
	<propertySetter: #previewExpanded>
	<propertyAnnouncement: #LeExampleSnippetPreviewExpandedChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasPreviewExpanded
		and: [ self previewExpanded = aNewPreviewExpanded ])
			ifTrue: [ ^ self ].
	
	self hasPreviewExpanded
		ifTrue: [
			| aPreviousPreviewExpanded |
			aPreviousPreviewExpanded := previewExpanded.
			previewExpanded := nil.
			self onPreviousPreviewExpandedUnset: aPreviousPreviewExpanded ].
	previewExpanded := aNewPreviewExpanded.
	self onNewPreviewExpandedSet: aNewPreviewExpanded.
	self notifyPreviewExpandedChanged
]

{ #category : #'api - preview height' }
LeExampleSnippet >> previewHeight [
	<return: #Number>
	<propertyGetter: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ previewHeight
]

{ #category : #'api - preview height' }
LeExampleSnippet >> previewHeight: aNewPreviewHeight [
	<propertySetter: #previewHeight>
	<propertyAnnouncement: #LeExampleSnippetPreviewHeightChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasPreviewHeight
		and: [ self previewHeight = aNewPreviewHeight ])
			ifTrue: [ ^ self ].
	
	self hasPreviewHeight
		ifTrue: [
			| aPreviousPreviewHeight |
			aPreviousPreviewHeight := previewHeight.
			previewHeight := nil.
			self onPreviousPreviewHeightUnset: aPreviousPreviewHeight ].
	previewHeight := aNewPreviewHeight.
	self onNewPreviewHeightSet: aNewPreviewHeight.
	self notifyPreviewHeightChanged
]

{ #category : #'api - preview show selector' }
LeExampleSnippet >> previewShowSelector [
	<return: #Symbol>
	<propertyGetter: #previewShowSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ previewShowSelector
]

{ #category : #'api - preview show selector' }
LeExampleSnippet >> previewShowSelector: aNewPreviewShowSelector [
	<propertySetter: #previewShowSelector>
	<propertyAnnouncement: #LeExampleSnippetPreviewShowSelectorChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasPreviewShowSelector
		and: [ self previewShowSelector = aNewPreviewShowSelector ])
			ifTrue: [ ^ self ].
	
	self hasPreviewShowSelector
		ifTrue: [
			| aPreviousPreviewShowSelector |
			aPreviousPreviewShowSelector := previewShowSelector.
			previewShowSelector := nil.
			self onPreviousPreviewShowSelectorUnset: aPreviousPreviewShowSelector ].
	previewShowSelector := aNewPreviewShowSelector.
	self onNewPreviewShowSelectorSet: aNewPreviewShowSelector.
	self notifyPreviewShowSelectorChanged
]

{ #category : #'api - testing' }
LeExampleSnippet >> similarTo: anotherExampleSnippet [
	^ self codeExpanded = anotherExampleSnippet codeExpanded
		and: [ self exampleBehaviorName = anotherExampleSnippet exampleBehaviorName
			and: [ self exampleSelector = anotherExampleSnippet exampleSelector
				and: [ self noCode = anotherExampleSnippet noCode
					and: [ self previewExpanded = anotherExampleSnippet previewExpanded
						and: [ self previewHeight = anotherExampleSnippet previewHeight
							and: [ self previewShowSelector = anotherExampleSnippet previewShowSelector ] ] ] ] ] ]
]

{ #category : #'api - code expanded' }
LeExampleSnippet >> unsetCodeExpanded [
	<propertyUnsetter: #codeExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousCodeExpanded |

	self hasCodeExpanded
		ifFalse: [ ^ self ].

	aPreviousCodeExpanded := codeExpanded.
	codeExpanded := nil.
	self onPreviousCodeExpandedUnset: aPreviousCodeExpanded.
	self notifyCodeExpandedChanged
]

{ #category : #'api - example behavior name' }
LeExampleSnippet >> unsetExampleBehaviorName [
	<propertyUnsetter: #exampleBehaviorName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousExampleBehaviorName |

	self hasExampleBehaviorName
		ifFalse: [ ^ self ].

	aPreviousExampleBehaviorName := exampleBehaviorName.
	exampleBehaviorName := nil.
	self onPreviousExampleBehaviorNameUnset: aPreviousExampleBehaviorName.
	self notifyExampleBehaviorNameChanged
]

{ #category : #'api - example selector' }
LeExampleSnippet >> unsetExampleSelector [
	<propertyUnsetter: #exampleSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousExampleSelector |

	self hasExampleSelector
		ifFalse: [ ^ self ].

	aPreviousExampleSelector := exampleSelector.
	exampleSelector := nil.
	self onPreviousExampleSelectorUnset: aPreviousExampleSelector.
	self notifyExampleSelectorChanged
]

{ #category : #'api - no code' }
LeExampleSnippet >> unsetNoCode [
	<propertyUnsetter: #noCode>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousNoCode |

	self hasNoCode
		ifFalse: [ ^ self ].

	aPreviousNoCode := noCode.
	noCode := nil.
	self onPreviousNoCodeUnset: aPreviousNoCode.
	self notifyNoCodeChanged
]

{ #category : #'api - preview expanded' }
LeExampleSnippet >> unsetPreviewExpanded [
	<propertyUnsetter: #previewExpanded>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousPreviewExpanded |

	self hasPreviewExpanded
		ifFalse: [ ^ self ].

	aPreviousPreviewExpanded := previewExpanded.
	previewExpanded := nil.
	self onPreviousPreviewExpandedUnset: aPreviousPreviewExpanded.
	self notifyPreviewExpandedChanged
]

{ #category : #'api - preview height' }
LeExampleSnippet >> unsetPreviewHeight [
	<propertyUnsetter: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousPreviewHeight |

	self hasPreviewHeight
		ifFalse: [ ^ self ].

	aPreviousPreviewHeight := previewHeight.
	previewHeight := nil.
	self onPreviousPreviewHeightUnset: aPreviousPreviewHeight.
	self notifyPreviewHeightChanged
]

{ #category : #'api - preview show selector' }
LeExampleSnippet >> unsetPreviewShowSelector [
	<propertyUnsetter: #previewShowSelector>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousPreviewShowSelector |

	self hasPreviewShowSelector
		ifFalse: [ ^ self ].

	aPreviousPreviewShowSelector := previewShowSelector.
	previewShowSelector := nil.
	self onPreviousPreviewShowSelectorUnset: aPreviousPreviewShowSelector.
	self notifyPreviewShowSelectorChanged
]

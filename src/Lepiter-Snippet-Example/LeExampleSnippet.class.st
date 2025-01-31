"
An example is like a test that returns an object. Beside the utility for testing, examples can also be used for documentation purposes through an exmaple snippet.
"
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
		'previewHeight',
		'previewSelectSelector'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #'api - accessing menu' }
LeExampleSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #accessing }
LeExampleSnippet class >> defaultPreviewShowSelector [
	^ #gtViewsFor:
]

{ #category : #'api - accessing menu' }
LeExampleSnippet class >> description [
	^ 'Example'
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
		addAll: {
			#exampleSelector->#exampleSelector. 
			#previewHeight->#previewHeight. 
			#previewShowSelector->#previewShowSelector. 
			#previewSelectSelector->#previewSelectSelector. 
			#exampleBehaviorName->#exampleBehaviorName. 
			#codeExpanded->#codeExpanded. 
			#previewExpanded->#previewExpanded. 
			#noCode->#noCode};
		yourself
]

{ #category : #'lepiter-store' }
LeExampleSnippet class >> leJsonV4Name [

	^ 'exampleSnippet'
]

{ #category : #accessing }
LeExampleSnippet >> acceptVisitor: aVisitor [
	^ aVisitor visitExampleSnippet: self
]

{ #category : #'api - accessing' }
LeExampleSnippet >> asAnnotationString [
	^ self asAnnotationStringWithChanges: Dictionary new
]

{ #category : #'api - accessing' }
LeExampleSnippet >> asAnnotationStringWithChanges: aDictionary [
	^ String
		streamContents: [ :aStream | 
			| className selectorName value |
			className := aDictionary
					at: #exampleBehaviorName
					ifAbsent: [ self exampleBehaviorName ].
			selectorName := aDictionary
					at: #exampleSelector
					ifAbsent: [ self exampleSelector ].

			aStream nextPutAll: (className ifNil: [ '' ]).

			(className notNil and: [ selectorName notNil ])
				ifTrue: [ aStream nextPutAll: ' >> #' ].

			aStream nextPutAll: (selectorName ifNil: [ '' ]).

			value := aDictionary at: #noCode ifAbsent: [ self noCode ].
			value = self defaultNoCode
				ifFalse: [ aStream
						nextPutAll: ' | noCode=';
						print: value ].

			value := aDictionary at: #codeExpanded ifAbsent: [ self codeExpanded ].
			value = self defaultCodeExpanded
				ifFalse: [ aStream
						nextPutAll: ' | codeExpanded=';
						print: value ].

			value := aDictionary at: #previewExpanded ifAbsent: [ self previewExpanded ].
			value = self defaultPreviewExpanded
				ifFalse: [ aStream
						nextPutAll: ' | previewExpanded=';
						print: value ].

			value := aDictionary
					at: #previewShowSelector
					ifAbsent: [ self previewShowSelector ].
			value = self defaultPreviewShowSelector
				ifFalse: [ aStream
						nextPutAll: ' | previewShow=';
						nextPut: $#;
						nextPutAll: value asString ].

			value := aDictionary
					at: #previewSelectSelector
					ifAbsent: [ self previewSelectSelector ].
			value
				ifNotNil: [ aStream
						nextPutAll: ' | previewSelect=';
						nextPut: $#;
						nextPutAll: value asString ].

			value := aDictionary at: #previewHeight ifAbsent: [ self previewHeight ].
			value = self defaultPreviewHeight
				ifFalse: [ aStream
						nextPutAll: ' | previewHeight=';
						print: value ] ]
]

{ #category : #'api - accessing' }
LeExampleSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LeExampleSnippetViewModel new snippetModel: self
]

{ #category : #testing }
LeExampleSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : #accessing }
LeExampleSnippet >> changeToRenameClass: oldName to: newName [
	self instanceClassName = oldName ifFalse: [ ^ nil ].
	^ LeExampleSnippetChange new
		snippet: self;
		change: #exampleBehaviorName
			to: (self isForMetaclass
					ifTrue: [ newName , ' class' ]
					ifFalse: [ newName asSymbol ]);
		yourself
]

{ #category : #accessing }
LeExampleSnippet >> changeToRenameSelector: oldName to: newName using: aRewriter [
	| change |
	change := LeExampleSnippetChange new snippet: self.
	#(exampleSelector previewSelectSelector previewShowSelector)
		do: [ :each | (self perform: each) = oldName ifTrue: [ change change: each to: newName ] ].
	^ change hasChanges ifTrue: [ change ] ifFalse: [ nil ]
]

{ #category : #accessing }
LeExampleSnippet >> classAndSelectorReferencesPromise [
	^ [ | classes selectors |
	classes := Set new.
	selectors := Set new.
	classes add: self instanceClassName.
	self exampleSelector ifNotNil: [ :sel | selectors add: sel ].
	self previewSelectSelector ifNotNil: [ :sel | selectors add: sel ].
	self previewShowSelector ifNotNil: [ :sel | selectors add: sel ].
	{classes.
		selectors} ] asAsyncPromise
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

{ #category : #converting }
LeExampleSnippet >> convertToScript [
	| newSource ast |
	ast := self exampleMethodAST.
	ast ifNil: [ ^ self ].
	newSource := self snippetSourceFrom: ast body.
	self addSnippetAfterSelf: (LePharoSnippet new code: newSource).
	self removeSelf
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
	^ self class defaultPreviewShowSelector
]

{ #category : #'api - testing' }
LeExampleSnippet >> doesReferenceExist [
	^ self hasExampleBehaviorName and: [ 
		self hasExampleSelector and: [ 
			self exampleMethod notNil ] ]
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
		and: [ self exampleBehaviorName sameContentAs: aNewExampleBehaviorName ])
			ifTrue: [ ^ self ].
	
	self hasExampleBehaviorName
		ifTrue: [
			| aPreviousExampleBehaviorName |
			aPreviousExampleBehaviorName := exampleBehaviorName.
			exampleBehaviorName := nil.
			self onPreviousExampleBehaviorNameUnset: aPreviousExampleBehaviorName ].
	exampleBehaviorName := aNewExampleBehaviorName.
	self onNewExampleBehaviorNameSet: exampleBehaviorName.
	self notifyExampleBehaviorNameChanged
]

{ #category : #converting }
LeExampleSnippet >> exampleClass [
	| name class |
	name := self instanceClassName.
	class := Smalltalk globals at: name asSymbol ifAbsent: [ ^ nil ].
	self isForMetaclass ifTrue: [ class := class class ].
	^ class
]

{ #category : #converting }
LeExampleSnippet >> exampleMethod [
	^ self exampleClass 
		ifNotNil: [ :aClass |
			aClass
				compiledMethodAt: exampleSelector
				ifPresent: [ :method | method parseTree ]
				ifAbsent: [ nil ] ]
]

{ #category : #converting }
LeExampleSnippet >> exampleMethodAST [
	^ self exampleMethod
		  ifNotNil: [ :method | method parseTree ]
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
	| newSelector |

	newSelector := aNewExampleSelector ifNotNil: #asSymbol.
	(self hasExampleSelector
		and: [ self exampleSelector = newSelector ])
			ifTrue: [ ^ self ].
	
	self hasExampleSelector
		ifTrue: [
			| aPreviousExampleSelector |
			aPreviousExampleSelector := exampleSelector.
			exampleSelector := nil.
			self onPreviousExampleSelectorUnset: aPreviousExampleSelector ].
	exampleSelector := newSelector.
	self onNewExampleSelectorSet: newSelector.
	self notifyExampleSelectorChanged
]

{ #category : #'private - subscriptions' }
LeExampleSnippet >> handleSystemClassAnnouncement: anAnnouncement [
	(exampleBehaviorName sameContentAs: anAnnouncement classAffected originalName)
		ifTrue: [ self notifyExampleBehaviorNameChanged ]
]

{ #category : #'private - subscriptions' }
LeExampleSnippet >> handleSystemMethodAnnouncement: anAnnouncement [
	((exampleBehaviorName sameContentAs: anAnnouncement methodClass originalName)
		and: [ exampleSelector = anAnnouncement selector ])
		ifTrue: [ self notifyExampleSelectorChanged ]
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
LeExampleSnippet >> hasPreviewSelectSelector [

	^ previewSelectSelector notNil
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
	previewHeight := self defaultPreviewHeight.
	
	self subscribeToSystem
]

{ #category : #converting }
LeExampleSnippet >> instanceClassName [
	^ exampleBehaviorName first: (exampleBehaviorName
			   indexOf: $ 
			   ifAbsent: [ exampleBehaviorName size + 1 ]) - 1
]

{ #category : #converting }
LeExampleSnippet >> isForMetaclass [

	^ exampleBehaviorName endsWith: ' class'
]

{ #category : #'private - exporting' }
LeExampleSnippet >> markdownOn: stream level: anInteger [
	"Placeholder. What should we do here?"

	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		cr;
		<< '```';
		cr;
		<< self contentAsString trimBoth;
		cr;
		<< '```';
		cr.
	self
		childrenDo: [ :child | 
			stream cr.
			child markdownOn: stream level: anInteger + 1 ]
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
LeExampleSnippet >> notifyPreviewSelectSelectorChanged [
	
	self notifyAnnouncement: (LeExampleSnippetPreviewSelectSelectorChanged new
		source: self;
		snippet: self;
		previewSelectSelector: self previewSelectSelector).
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
LeExampleSnippet >> onNewPreviewSelectSelectorSet: aNewPreviewSelectSelector [
	
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
LeExampleSnippet >> onPreviousPreviewSelectSelectorUnset: aPreviousPreviewSelectSelector [
	
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

{ #category : #accessing }
LeExampleSnippet >> previewSelectSelector [
	^ previewSelectSelector
]

{ #category : #'api - preview show selector' }
LeExampleSnippet >> previewSelectSelector: aNewPreviewSelectSelector [

	(self hasPreviewSelectSelector
		and: [ self previewSelectSelector = aNewPreviewSelectSelector ])
			ifTrue: [ ^ self ].
	
	self hasPreviewSelectSelector
		ifTrue: [
			| aPreviousPreviewSelectSelector |
			aPreviousPreviewSelectSelector := previewSelectSelector.
			previewSelectSelector := nil.
			self onPreviousPreviewSelectSelectorUnset: aPreviousPreviewSelectSelector ].
	previewSelectSelector := aNewPreviewSelectSelector.
	self onNewPreviewSelectSelectorSet: aNewPreviewSelectSelector.
	self notifyPreviewSelectSelectorChanged
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
	| newSelector |

	newSelector := aNewPreviewShowSelector ifNotNil: [ aNewPreviewShowSelector asSymbol ].
	(self hasPreviewShowSelector
		and: [ self previewShowSelector = newSelector ])
			ifTrue: [ ^ self ].
	
	self hasPreviewShowSelector
		ifTrue: [
			| aPreviousPreviewShowSelector |
			aPreviousPreviewShowSelector := previewShowSelector.
			previewShowSelector := nil.
			self onPreviousPreviewShowSelectorUnset: aPreviousPreviewShowSelector ].
	previewShowSelector := newSelector.
	self onNewPreviewShowSelectorSet: newSelector.
	self notifyPreviewShowSelectorChanged
]

{ #category : #accessing }
LeExampleSnippet >> referencedExample [
	<return: #RGMethodDefinition or: nil>
	self exampleBehaviorName ifNil: [ ^ nil ].
	self exampleSelector ifNil: [ ^ nil ].
	^ GtSystemUtility methodDefinitionFromString: self exampleBehaviorName,'>>#', self exampleSelector
]

{ #category : #accessing }
LeExampleSnippet >> referencedExampleSourceCode [
	^ self referencedExample sourceCode
]

{ #category : #'api - testing' }
LeExampleSnippet >> similarTo: anotherExampleSnippet [
	^ self codeExpanded = anotherExampleSnippet codeExpanded
		and: [ (self exampleBehaviorName sameContentAs: anotherExampleSnippet exampleBehaviorName)
			and: [ self exampleSelector = anotherExampleSnippet exampleSelector
				and: [ self noCode = anotherExampleSnippet noCode
					and: [ self previewExpanded = anotherExampleSnippet previewExpanded
						and: [ self previewHeight = anotherExampleSnippet previewHeight
							and: [ self previewShowSelector = anotherExampleSnippet previewShowSelector
								and: [ self previewSelectSelector = anotherExampleSnippet previewSelectSelector ]  ] ] ] ] ] ]
]

{ #category : #converting }
LeExampleSnippet >> snippetSourceFrom: anAST [
	| ast |
	ast := self updateInstanceVariableReferencesIn: anAST.
	ast := self updateSelfReferencesIn: ast.
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	(ast statements notEmpty and: [ ast statements last isReturn ]) 
		ifTrue: [ 
			ast
				replaceNode: ast statements last
				withNode: ast statements last value ].
	^ ast formattedCode
]

{ #category : #printing }
LeExampleSnippet >> storeOn: aStream [

	"code adapted from #asAnnotationString method"

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new  exampleBehaviorName: '.
	self exampleBehaviorName storeOn: aStream.
	aStream nextPutAll: '; exampleSelector: '.
	self exampleSelector storeOn: aStream.


	self noCode = self defaultNoCode ifFalse: [ 
		aStream nextPutAll: '; noCode: '.
		self noCode storeOn: aStream ].

	self codeExpanded = self defaultCodeExpanded ifFalse: [ 
		aStream nextPutAll: '; codeExpanded: '.
		self codeExpanded storeOn: aStream ].

	self previewExpanded = self defaultPreviewExpanded ifFalse: [ 
		aStream nextPutAll: '; previewExpanded: '.
		self previewExpanded storeOn: aStream ].

	self previewShowSelector = self defaultPreviewShowSelector ifFalse: [ 
		aStream nextPutAll: '; previewShowSelector: '.
		self previewShowSelector storeOn: aStream ].
		
	self previewSelectSelector ifNotNil: [ 
		aStream nextPutAll: '; previewSelectSelector: '.
		self previewSelectSelector storeOn: aStream ].

	self previewHeight = self defaultPreviewHeight ifFalse: [ 
		aStream nextPutAll: '; previewHeight: '.
		self previewHeight storeOn: aStream ].

	aStream nextPutAll: ')'
]

{ #category : #'private - subscriptions' }
LeExampleSnippet >> subscribeToSystem [
	self unsubscribeFromSystem.
	SystemAnnouncer uniqueInstance weak
		when: ClassAnnouncement
			send: #handleSystemClassAnnouncement:
			to: self;
		when: MethodAnnouncement
			send: #handleSystemMethodAnnouncement:
			to: self
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

{ #category : #'private - subscriptions' }
LeExampleSnippet >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #converting }
LeExampleSnippet >> updateInstanceVariableReferencesIn: anAST [
	| rewrites |
	rewrites := RBParseTreeRewriter new.
	self exampleClass allInstVarNames
		do:
			[ :each | 
			rewrites
				replace: each , ' := ``@a' with: 'self instVarNamed: ''' , each , ''' put: ``@a';
				replace: each with: 'self instVarNamed: ''' , each , '''' ].
	rewrites executeTree: anAST.
	^ rewrites tree
]

{ #category : #converting }
LeExampleSnippet >> updateSelfReferencesIn: anAST [
	| selfNodes newNode |
	selfNodes := OrderedCollection new.
	anAST nodesDo: [ :each | (each isVariable and: [ each name = #self ]) ifTrue: [ selfNodes add: each ] ].
	selfNodes isEmpty ifTrue: [ ^ anAST ].
	self isForMetaclass
		ifTrue: [ newNode := RBVariableNode named: self instanceClassName ]
		ifFalse:
			[ selfNodes size > 1
				ifTrue:
					[ | name index |
					name := 'instance'.
					index := 1.
					[ anAST allTemporaryVariables anySatisfy: [ :each | each asString = name ] ]
						whileTrue:
							[ name := 'instance' , index printString.
							index := index + 1 ].
					anAST
						addNodeFirst:
							(RBAssignmentNode
								variable: (RBVariableNode named: name)
								value: (RBMessageNode receiver: (RBVariableNode named: self instanceClassName) selector: #new)).
					newNode := RBVariableNode named: name ]
				ifFalse: [ newNode := RBMessageNode receiver: (RBVariableNode named: self instanceClassName) selector: #new ] ].
	selfNodes do: [ :each | each replaceWith: newNode copy ].
	^ anAST
]

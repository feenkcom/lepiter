Class {
	#name : #LeExampleSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#instVars : [
		'annotationCoderViewModel',
		'mutex'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #'api - annotation coder view model' }
LeExampleSnippetViewModel >> annotationCoderViewModel [
	<return: #GtTextCoder>
	<propertyGetter: #annotationCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ annotationCoderViewModel
]

{ #category : #'api - annotation coder view model' }
LeExampleSnippetViewModel >> annotationCoderViewModel: aNewAnnotationCoderViewModel [
	<propertySetter: #annotationCoderViewModel>
	<propertyAnnouncement: #LeExampleSnippetViewModelAnnotationCoderViewModelChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasAnnotationCoderViewModel
		and: [ self annotationCoderViewModel = aNewAnnotationCoderViewModel ])
			ifTrue: [ ^ self ].
	
	self hasAnnotationCoderViewModel
		ifTrue: [
			| aPreviousAnnotationCoderViewModel |
			aPreviousAnnotationCoderViewModel := annotationCoderViewModel.
			annotationCoderViewModel := nil.
			self onPreviousAnnotationCoderViewModelUnset: aPreviousAnnotationCoderViewModel ].
	annotationCoderViewModel := aNewAnnotationCoderViewModel.
	self onNewAnnotationCoderViewModelSet: aNewAnnotationCoderViewModel.
	self notifyAnnotationCoderViewModelChanged
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> cacheExamplePreview: aComputedPreview withFingerprint: aFingerprint [
	"Cache a computed preview together with the fingerprint it was computed for"

	mutex
		critical: [ self optionAt: self cachedExamplePreviewKey put: aComputedPreview.
			self optionAt: self cachedExamplePreviewFingerprintKey put: aFingerprint ]
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> cachedExamplePreviewDo: aBlock [
	"Block receives a {{gtClass:LeExampleSnippetComputedPreview}} object."

	self cachedExamplePreviewDo: aBlock ifAbsent: [  "ignore" ]
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> cachedExamplePreviewDo: aBlock ifAbsent: absentBlock [
	"Block receives a {{gtClass:LeExampleSnippetComputedPreview}} object."

	mutex
		critical: [ self
				optionAt: self cachedExamplePreviewKey
				ifPresent: aBlock
				ifAbsent: absentBlock ]
]

{ #category : #'private - cache' }
LeExampleSnippetViewModel >> cachedExamplePreviewFingerprintKey [
	^ #cachedExamplePreviewFingerprint
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> cachedExamplePreviewForFingerprint: aFingerprint do: aBlock [
	"Evaluate aBlock with the cached preview if it was computed for the given fingerprint;
	otherwise remove the outdated preview"

	| aPreview |
	mutex
		critical: [ (self isCachedExamplePreviewComputedFor: aFingerprint)
				ifTrue: [ aPreview := self optionAt: self cachedExamplePreviewKey ]
				ifFalse: [ self clearCachedExamplePreview ] ].

	aPreview ifNotNil: aBlock
]

{ #category : #'private - cache' }
LeExampleSnippetViewModel >> cachedExamplePreviewGenerationKey [
	^ #cachedExamplePreviewGeneration
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> cachedExamplePreviewKey [
	^ #cachedExamplePreview
]

{ #category : #'private - cache' }
LeExampleSnippetViewModel >> cachedGtExampleKey [
	"The cached value is an association: referenced method key -> GtExample"

	^ #cachedGtExample
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> clearCachedExamplePreview [
	"Remove the cached preview without bumping the generation:
	previews that are being computed stay valid. See #invalidateCachedExamplePreview"

	mutex
		critical: [ self clearOption: self cachedExamplePreviewKey ifAbsent: [  "ignore" ].
			self
				clearOption: self cachedExamplePreviewFingerprintKey
				ifAbsent: [  "ignore" ] ]
]

{ #category : #'api - code expanded' }
LeExampleSnippetViewModel >> codeExpanded [
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel codeExpanded
]

{ #category : #'api - code expanded' }
LeExampleSnippetViewModel >> codeExpanded: aCodeExpanded [
	<propertySetter: #codeExpanded>
	<propertyAnnouncement: #LeExampleSnippetCodeExpandedChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel codeExpanded: aCodeExpanded
]

{ #category : #'filter view' }
LeExampleSnippetViewModel >> collapsedTextPromise [
	^ [ | text string styler ast |
	string := self snippetModel contentAsString.
	text := string asRopedText.
	styler := LeExampleSnippetStyler new.
	ast := LeParser parseWithErrors: string.
	self
		highlightText: text
		ast: ast
		using: self leHighlighters.
	ast
		withAllNodesOfType: LeAnnotationNode
		do: [ :each | styler style: text ast: each ].
	text ] asAsyncPromise
]

{ #category : #'api - example behavior name' }
LeExampleSnippetViewModel >> exampleBehaviorName [
	<return: #Symbol>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel exampleBehaviorName
]

{ #category : #'api - example behavior name' }
LeExampleSnippetViewModel >> exampleBehaviorName: aExampleBehaviorName [
	<propertySetter: #exampleBehaviorName>
	<propertyAnnouncement: #LeExampleSnippetExampleBehaviorNameChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel exampleBehaviorName: aExampleBehaviorName
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> examplePreviewFingerprint [
	"Return what a preview computed now depends on:
	the generation of the snippet settings and the version of the referenced example method"

	| aGeneration |
	aGeneration := mutex
			critical: [ self optionAt: self cachedExamplePreviewGenerationKey ifAbsent: [ 0 ] ].
	^ {aGeneration.
		self referencedExampleMethodKey}
]

{ #category : #'api - example selector' }
LeExampleSnippetViewModel >> exampleSelector [
	<return: #Symbol>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel exampleSelector
]

{ #category : #'api - example selector' }
LeExampleSnippetViewModel >> exampleSelector: aExampleSelector [
	<propertySetter: #exampleSelector>
	<propertyAnnouncement: #LeExampleSnippetExampleSelectorChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel exampleSelector: aExampleSelector
]

{ #category : #'api - focus' }
LeExampleSnippetViewModel >> focusAfterCreation [
	super focusAfterCreation.
	
	self annotationCoderViewModel
		focused: true;
		moveCursorAtEnd
]

{ #category : #'api - focus' }
LeExampleSnippetViewModel >> focusDueToNavigationDown [
	super focusDueToNavigationDown.
	
	self annotationCoderViewModel
		focused: true;
		moveCursorAtEnd
]

{ #category : #'api - focus' }
LeExampleSnippetViewModel >> focusDueToNavigationUp [
	super focusDueToNavigationUp.
	
	self annotationCoderViewModel
		focused: true;
		moveCursorAtEnd
]

{ #category : #'gt extensions' }
LeExampleSnippetViewModel >> gtActionCreateExampleFor: anAction [

	<gtAction>
	^ anAction button
		  tooltip: 'Create snippet';
		  icon: BrGlamorousVectorIcons play;
		  target: LeSnippetContextMenuActionTarget uniqueInstance;
		  priority: 10;
		  action: [ :aButton :aSnippetElement | 
			  snippetModel convertToScript.
			  aButton fireEvent: BrDropdownHideWish new ]
]

{ #category : #'api - accessing' }
LeExampleSnippetViewModel >> gtExampleDo: aBlock [
	self gtExampleDo: aBlock ifAbsent: [  "do nothing" ]
]

{ #category : #'api - accessing' }
LeExampleSnippetViewModel >> gtExampleDo: aBlock ifAbsent: absentBlock [
	"Evaluate aBlock with the GtExample of the referenced method, or evaluate absentBlock.
	A cached GtExample is reused only if it was created for the current version of the referenced method"

	| anExampleMethod aMethodKey aCachedExample aGtExample |
	anExampleMethod := self referencedCompiledMethod ifNil: [ ^ absentBlock value ].
	aMethodKey := self methodKeyOf: anExampleMethod.
	aCachedExample := mutex
			critical: [ self optionAt: self cachedGtExampleKey ifAbsent: [ nil ] ].
	(aCachedExample notNil
		and: [ aCachedExample key = aMethodKey
				and: [ aCachedExample value methodClass == anExampleMethod methodClass ] ])
		ifTrue: [ ^ aBlock value: aCachedExample value ].

	aGtExample := anExampleMethod gtExample ifNil: [ ^ absentBlock value ].
	mutex
		critical: [ self optionAt: self cachedGtExampleKey put: aMethodKey -> aGtExample ].
	^ aBlock value: aGtExample
]

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> handleAnnotationAstChange: anAst [

	| aNewSnippet |
	anAst
		allNodesDo: [ :eachNode | eachNode isErrorNode ifTrue: [ ^ self ] ]
		andTokensDo: [ :eachToken |  ]
		includeErrors: true.

	aNewSnippet := LeExampleSnippet new.

	"this will modify the properties of a default snippet while making sure that removing properties falls back to default"
	LeExampleSnippetAnnotationVisitor new
		exampleSnippet: aNewSnippet;
		accept: anAst.
	
	"if properties did not change, do nothing"
	(self snippetModel similarTo: aNewSnippet) ifTrue: [ ^ self ].

	"it is possible that multiple parameters were changes as part of the ast update.
	we should queue them up and request annotation update only once at the very end"
	self optionAt: #doNotUpdateText put: true.
	[ self updateSnippetStateBasedOn: aNewSnippet ] ensure: [ 
		self optionAt: #doNotUpdateText put: false ].

	(LeExampleSnippetAnnotationValidator new validate: anAst) ifFalse: [ 
		^ self ].

	self requestUpdateAnnotationText
]

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> handleSystemClassAnnouncement: aClassAnnouncement [
	"Is sent by a displayed example snippet element.
	If the referenced name does not resolve anymore (class renamed or removed), only react
	when the cached preview was computed for another fingerprint, so that snippets referencing
	a missing class do not recompute on every class announcement"

	| aBehaviorName |
	aBehaviorName := self referencedInstanceSideBehaviorName ifNil: [ ^ self ].
	(aBehaviorName
		sameContentAs: aClassAnnouncement classAffected instanceSide originalName)
		ifTrue: [ ^ self onReferencedExampleChanged ].

	self referencedBehavior ifNotNil: [ ^ self ].
	self isCachedExamplePreviewOutdated ifTrue: [ self onReferencedExampleChanged ]
]

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> handleSystemMethodAnnouncement: aMethodAnnouncement [
	"Is sent by a displayed example snippet element.
	Compare the preview fingerprint (settings generation and version of the looked-up method)
	instead of class names, so that inherited and trait methods are handled too;
	changes that keep the source (e.g. recategorization) do not re-run the example."

	self exampleSelector = aMethodAnnouncement selector ifFalse: [ ^ self ].
	self isCachedExamplePreviewCurrent ifTrue: [ ^ self ].

	self onReferencedExampleChanged
]

{ #category : #'api - annotation coder view model' }
LeExampleSnippetViewModel >> hasAnnotationCoderViewModel [
	<return: #Boolean>
	<propertyTester: #annotationCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ annotationCoderViewModel notNil
]

{ #category : #initialization }
LeExampleSnippetViewModel >> initialize [
	| annotationCoder |
	super initialize.

	mutex := Mutex new.

	annotationCoder := GtTextCoder new
			parser: LeAnnotationParser;
			parserStartingState: LeAnnotationParser startingStateForExampleAnnotation.

	self
		annotationCoderViewModel: (annotationCoder asCoderViewModel addStyler: LeExampleSnippetStyler new).

	self weak
		when: LeExampleSnippetContentChanged
		send: #requestUpdateAnnotationText
		to: self
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> invalidateCachedExamplePreview [
	"Snippet settings or the referenced example changed:
	previews that are still being computed are outdated as well"

	mutex
		critical: [ self
				optionAt: self cachedExamplePreviewGenerationKey
				put: (self optionAt: self cachedExamplePreviewGenerationKey ifAbsent: [ 0 ]) + 1.
			self clearOption: self cachedGtExampleKey ifAbsent: [  "ignore" ].
			self clearCachedExamplePreview ]
]

{ #category : #'private - cache' }
LeExampleSnippetViewModel >> isCachedExamplePreviewComputedFor: aFingerprint [
	"Must be called within mutex"

	<return: #Boolean>
	^ (self hasOptionAt: self cachedExamplePreviewKey)
		and: [ (self optionAt: self cachedExamplePreviewFingerprintKey ifAbsent: [ nil ])
				= aFingerprint ]
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> isCachedExamplePreviewCurrent [
	"Return true if a preview is cached and was computed for the current fingerprint"

	<return: #Boolean>
	| aFingerprint |
	aFingerprint := self examplePreviewFingerprint.
	^ mutex critical: [ self isCachedExamplePreviewComputedFor: aFingerprint ]
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> isCachedExamplePreviewOutdated [
	"Return true if a preview is cached, but was computed for another fingerprint"

	<return: #Boolean>
	| aFingerprint |
	aFingerprint := self examplePreviewFingerprint.
	^ mutex
		critical: [ (self hasOptionAt: self cachedExamplePreviewKey)
				and: [ (self isCachedExamplePreviewComputedFor: aFingerprint) not ] ]
]

{ #category : #'api - accessing' }
LeExampleSnippetViewModel >> isReferencedBehaviorClassSide [
	<return: #Boolean>
	^ self snippetModel hasExampleBehaviorName
		and: [ self exampleBehaviorName trimBoth endsWith: ' class' ]
]

{ #category : #'private - cache' }
LeExampleSnippetViewModel >> methodKeyOf: aCompiledMethod [
	"Return what identifies a version of an example method: its defining class name and source hash"

	^ {aCompiledMethod methodClass name.
		aCompiledMethod sourceCode hash}
]

{ #category : #'api - no code' }
LeExampleSnippetViewModel >> noCode [
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel noCode
]

{ #category : #'api - no code' }
LeExampleSnippetViewModel >> noCode: aNoCode [
	<propertySetter: #noCode>
	<propertyAnnouncement: #LeExampleSnippetNoCodeChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel noCode: aNoCode
]

{ #category : #'api - annotation coder view model' }
LeExampleSnippetViewModel >> notifyAnnotationCoderViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #annotationCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (LeExampleSnippetViewModelAnnotationCoderViewModelChanged new
		annotationCoderViewModel: self annotationCoderViewModel).
]

{ #category : #'api - annotation coder view model' }
LeExampleSnippetViewModel >> onNewAnnotationCoderViewModelSet: aNewAnnotationCoderViewModel [
	"Is sent after a new value of the annotationCoderViewModel is assigned"
	<propertySetHook: #annotationCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
	
	aNewAnnotationCoderViewModel weak
		when: GtTextualCoderViewModelTextChanged
		send: #onTextualCoderViewModelTextChanged:
		to: self
]

{ #category : #'api - annotation coder view model' }
LeExampleSnippetViewModel >> onPreviousAnnotationCoderViewModelUnset: aPreviousAnnotationCoderViewModel [
	"Is sent after a previous value of the annotationCoderViewModel is de-assigned"
	<propertyUnsetHook: #annotationCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
	
	aPreviousAnnotationCoderViewModel unsubscribe: self
]

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> onReferencedExampleChanged [
	self invalidateCachedExamplePreview.
	self announce: LeExampleSnippetViewModelExampleChanged new
]

{ #category : #'api - code expanded' }
LeExampleSnippetViewModel >> onSnippetCodeExpandedChanged: aLeExampleSnippetCodeExpandedChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetCodeExpandedChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	self invalidateCachedExamplePreview.
	self announce: aLeExampleSnippetCodeExpandedChanged
]

{ #category : #'api - example behavior name' }
LeExampleSnippetViewModel >> onSnippetExampleBehaviorNameChanged: aLeExampleSnippetExampleBehaviorNameChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetExampleBehaviorNameChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	self invalidateCachedExamplePreview.
	self announce: aLeExampleSnippetExampleBehaviorNameChanged
]

{ #category : #'api - example selector' }
LeExampleSnippetViewModel >> onSnippetExampleSelectorChanged: aLeExampleSnippetExampleSelectorChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetExampleSelectorChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	self invalidateCachedExamplePreview.
	self announce: aLeExampleSnippetExampleSelectorChanged
]

{ #category : #'api - snippet model' }
LeExampleSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.

	self invalidateCachedExamplePreview.
	self updateAnnotationText
]

{ #category : #'api - no code' }
LeExampleSnippetViewModel >> onSnippetNoCodeChanged: aLeExampleSnippetNoCodeChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetNoCodeChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	self invalidateCachedExamplePreview.
	self announce: aLeExampleSnippetNoCodeChanged
]

{ #category : #'api - preview expanded' }
LeExampleSnippetViewModel >> onSnippetPreviewExpandedChanged: aLeExampleSnippetPreviewExpandedChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewExpandedChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	self invalidateCachedExamplePreview.
	self announce: aLeExampleSnippetPreviewExpandedChanged
]

{ #category : #'api - preview height' }
LeExampleSnippetViewModel >> onSnippetPreviewHeightChanged: aLeExampleSnippetPreviewHeightChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewHeightChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	self invalidateCachedExamplePreview.
	self announce: aLeExampleSnippetPreviewHeightChanged
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> onSnippetPreviewSelectSelectorChanged: aLeExampleSnippetPreviewSelectorSelectorChanged [
	self invalidateCachedExamplePreview.
	self announce: aLeExampleSnippetPreviewSelectorSelectorChanged
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> onSnippetPreviewShowSelectorChanged: aLeExampleSnippetPreviewShowSelectorChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewShowSelectorChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	self invalidateCachedExamplePreview.
	self announce: aLeExampleSnippetPreviewShowSelectorChanged
]

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> onTextualCoderViewModelTextChanged: anAstChangedAnnouncement [

	self annotationCoderViewModel astAsyncDo: [ :anAst | 
		self handleAnnotationAstChange: anAst ]
]

{ #category : #'api - preview expanded' }
LeExampleSnippetViewModel >> previewExpanded [
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel previewExpanded
]

{ #category : #'api - preview expanded' }
LeExampleSnippetViewModel >> previewExpanded: aPreviewExpanded [
	<propertySetter: #previewExpanded>
	<propertyAnnouncement: #LeExampleSnippetPreviewExpandedChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel previewExpanded: aPreviewExpanded
]

{ #category : #'api - preview height' }
LeExampleSnippetViewModel >> previewHeight [
	<return: #Number>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel previewHeight
]

{ #category : #'api - preview height' }
LeExampleSnippetViewModel >> previewHeight: aPreviewHeight [
	<propertySetter: #previewHeight>
	<propertyAnnouncement: #LeExampleSnippetPreviewHeightChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel previewHeight: aPreviewHeight
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> previewSelectSelector [
	
	^ self snippetModel previewSelectSelector
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> previewSelectSelector: aPreviewSelectSelector [

	self snippetModel previewSelectSelector: aPreviewSelectSelector
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> previewShowSelector [
	<return: #Symbol>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel previewShowSelector
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> previewShowSelector: aPreviewShowSelector [
	<propertySetter: #previewShowSelector>
	<propertyAnnouncement: #LeExampleSnippetPreviewShowSelectorChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel previewShowSelector: aPreviewShowSelector
]

{ #category : #'api - accessing' }
LeExampleSnippetViewModel >> referencedBehavior [
	"Return the behavior currently referenced by the example snippet, or nil"

	<return: #Behavior or: nil>
	| aBehaviorName aBehavior |
	aBehaviorName := self referencedInstanceSideBehaviorName ifNil: [ ^ nil ].
	aBehavior := self class environment
			at: aBehaviorName asSymbol
			ifAbsent: [ ^ nil ].
	aBehavior isBehavior ifFalse: [ ^ nil ].

	^ self isReferencedBehaviorClassSide
		ifTrue: [ aBehavior classSide ]
		ifFalse: [ aBehavior ]
]

{ #category : #'api - accessing' }
LeExampleSnippetViewModel >> referencedCompiledMethod [
	"Return the compiled method currently referenced by the example snippet, or nil"

	<return: #CompiledMethod or: nil>
	| aBehavior |
	self snippetModel hasExampleSelector ifFalse: [ ^ nil ].
	aBehavior := self referencedBehavior ifNil: [ ^ nil ].

	^ aBehavior lookupSelector: self exampleSelector asSymbol
]

{ #category : #'private - cache' }
LeExampleSnippetViewModel >> referencedExampleMethodKey [
	"Return what identifies the current version of the referenced example method, or nil if it does not exist"

	^ self referencedCompiledMethod
		ifNotNil: [ :aCompiledMethod | self methodKeyOf: aCompiledMethod ]
]

{ #category : #'api - accessing' }
LeExampleSnippetViewModel >> referencedInstanceSideBehaviorName [
	"Return the referenced class name without ' class', or nil"

	<return: #String or: nil>
	| aBehaviorName |
	self snippetModel hasExampleBehaviorName ifFalse: [ ^ nil ].
	aBehaviorName := self exampleBehaviorName trimBoth.
	^ self isReferencedBehaviorClassSide
		ifTrue: [ aBehaviorName allButLast: ' class' size ]
		ifFalse: [ aBehaviorName ]
]

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> requestUpdateAnnotationText [

	self
		optionAt: #doNotUpdateText
		ifPresent: [ :aBoolean | aBoolean ifTrue: [ ^ self ] ]
		ifAbsent: [  ].

	"if the current annotation text represents the same snippet paremeters there is no need to change it"
	annotationCoderViewModel astAsyncDo: [ :anAst |
		| aTestExampleSnippet |

		aTestExampleSnippet := LeExampleSnippet new.

		LeExampleSnippetAnnotationVisitor new
			exampleSnippet: aTestExampleSnippet;
			accept: anAst.

		(self snippetModel similarTo: aTestExampleSnippet)
			ifFalse: [ self updateAnnotationText ] ]
]

{ #category : #'api - accessing' }
LeExampleSnippetViewModel >> snippetElementClass [
	^ LeExampleSnippetElement
]

{ #category : #'api - snippet model' }
LeExampleSnippetViewModel >> subscribeToSnippetModel [
	"Is sent after a new snippetModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSnippetModel if the receiver subscribes to them"
	<modelSubscriber: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	super subscribeToSnippetModel.

	self snippetModel weak when: LeExampleSnippetExampleBehaviorNameChanged send: #onSnippetExampleBehaviorNameChanged: to: self.
	self snippetModel weak when: LeExampleSnippetExampleSelectorChanged send: #onSnippetExampleSelectorChanged: to: self.
	self snippetModel weak when: LeExampleSnippetCodeExpandedChanged send: #onSnippetCodeExpandedChanged: to: self.
	self snippetModel weak when: LeExampleSnippetNoCodeChanged send: #onSnippetNoCodeChanged: to: self.
	self snippetModel weak when: LeExampleSnippetPreviewExpandedChanged send: #onSnippetPreviewExpandedChanged: to: self.
	self snippetModel weak when: LeExampleSnippetPreviewShowSelectorChanged send: #onSnippetPreviewShowSelectorChanged: to: self.
	self snippetModel weak when: LeExampleSnippetPreviewSelectSelectorChanged send: #onSnippetPreviewSelectSelectorChanged: to: self.
	self snippetModel weak when: LeExampleSnippetPreviewHeightChanged send: #onSnippetPreviewHeightChanged: to: self.
]

{ #category : #'api - annotation coder view model' }
LeExampleSnippetViewModel >> unsetAnnotationCoderViewModel [
	<propertyUnsetter: #annotationCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousAnnotationCoderViewModel |

	self hasAnnotationCoderViewModel
		ifFalse: [ ^ self ].

	aPreviousAnnotationCoderViewModel := annotationCoderViewModel.
	annotationCoderViewModel := nil.
	self onPreviousAnnotationCoderViewModelUnset: aPreviousAnnotationCoderViewModel.
	self notifyAnnotationCoderViewModelChanged
]

{ #category : #'api - snippet model' }
LeExampleSnippetViewModel >> unsubscribeFromSnippetModel [
	"Is sent before a new snippetModel is assigned to the receiver.
	Objects that subscribe to snippetModel are required to implement this method."
	<modelUnsubscriber: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	super unsubscribeFromSnippetModel.
	self snippetModel unsubscribe: self.
]

{ #category : #'private - updating' }
LeExampleSnippetViewModel >> updateAnnotationText [
	annotationCoderViewModel
		sourceText: self snippetModel asAnnotationString asRopedText
		from: self
		synchronously: false
]

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> updateSnippetStateBasedOn: aNewSnippet [ 
	| updateCommand |
	
	updateCommand := self snippetModel  commandBuilder 
		updateSnippetStateCommandBasedOn:  aNewSnippet.
		
	updateCommand execute.
]

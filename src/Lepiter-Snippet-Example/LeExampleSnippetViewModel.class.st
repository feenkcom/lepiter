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
LeExampleSnippetViewModel >> cacheExamplePreview: anElement [
	mutex critical: [ self optionAt: self cachedExamplePreviewKey put: anElement ]
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

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> cachedExamplePreviewKey [
	^ #cachedExamplePreview
]

{ #category : #'api - cache' }
LeExampleSnippetViewModel >> clearCachedExamplePreview [
	mutex
		critical: [ self clearOption: self cachedExamplePreviewKey ifAbsent: [  "ignore" ] ]
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

	"Try to retrieve a GtExample for an example snippet"

	<return: #GtExample>
	| anExampleClass anExampleMethod gtExample anInstanceSideBehaviorName isClassSide |
	self
		optionAt: #gtExample
		ifPresent: [ :aGtExample | 
			aGtExample exists and: [ 
				((aGtExample methodClass name sameContentAs: self exampleBehaviorName) and: [ 
					 aGtExample selector = self exampleSelector ]) ifTrue: [ 
					^ aBlock value: aGtExample ] ] ]
		ifAbsent: [  ].

	self snippetModel hasExampleBehaviorName ifFalse: [ absentBlock value. ^ self ].

	self snippetModel hasExampleSelector ifFalse: [ absentBlock value. ^ self ].

	anInstanceSideBehaviorName := self exampleBehaviorName trimBoth.
	isClassSide := anInstanceSideBehaviorName endsWith: ' class'.
	anInstanceSideBehaviorName := isClassSide
		ifTrue: [ self exampleBehaviorName allButLast: ' class' size ]
		ifFalse: [ self exampleBehaviorName ].

	anExampleClass := self class environment
		                  at: anInstanceSideBehaviorName asSymbol
		                  ifAbsent: [ nil ].

	anExampleClass ifNil: [ absentBlock value. ^ self ].
	
	isClassSide ifTrue: [ anExampleClass := anExampleClass classSide ].

	anExampleMethod := (anExampleClass lookupSelector:
		                    self exampleSelector asSymbol) ifNil: [ absentBlock value. ^ self ].

	gtExample := anExampleMethod gtExample.
	gtExample ifNil: [ absentBlock value. ^ self ].
	self optionAt: #gtExample put: gtExample.
	aBlock value: gtExample
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
	self gtExampleDo: [ :aGtExample |
		(aClassAnnouncement affectsClass: aGtExample methodClass)
			ifFalse: [ ^ self ].
			
		self
			clearOption: #gtExample
			ifAbsent: [ ] ].

	self announce: LeExampleSnippetViewModelExampleChanged new
]

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> handleSystemMethodAnnouncement: aMethodAnnouncement [
	true ifTrue: [ ^ self ].
	self gtExampleDo: [ :aGtExample |
		(aMethodAnnouncement affectsMethod: aGtExample method)
			ifFalse: [ ^ self ].
			
		self
			clearOption: #gtExample
			ifAbsent: [ ] ].
	self announce: LeExampleSnippetViewModelExampleChanged new
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
	
	self annotationCoderViewModel: (annotationCoder asCoderViewModel 
		addStyler: LeExampleSnippetStyler new).
	
	self weak 
		when: LeExampleSnippetContentChanged 
		send: #requestUpdateAnnotationText 
		to: self.
	
	true ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak 
		when: ClassAnnouncement
			send: #handleSystemClassAnnouncement:
			to: self;
		when: MethodAnnouncement
			send: #handleSystemMethodAnnouncement:
			to: self
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

{ #category : #'api - code expanded' }
LeExampleSnippetViewModel >> onSnippetCodeExpandedChanged: aLeExampleSnippetCodeExpandedChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetCodeExpandedChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self clearCachedExamplePreview.
	self announce: aLeExampleSnippetCodeExpandedChanged
]

{ #category : #'api - example behavior name' }
LeExampleSnippetViewModel >> onSnippetExampleBehaviorNameChanged: aLeExampleSnippetExampleBehaviorNameChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetExampleBehaviorNameChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self clearCachedExamplePreview.
	self announce: aLeExampleSnippetExampleBehaviorNameChanged
]

{ #category : #'api - example selector' }
LeExampleSnippetViewModel >> onSnippetExampleSelectorChanged: aLeExampleSnippetExampleSelectorChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetExampleSelectorChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>

	self clearCachedExamplePreview.
	self announce: aLeExampleSnippetExampleSelectorChanged
]

{ #category : #'api - snippet model' }
LeExampleSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	self clearCachedExamplePreview.
	self updateAnnotationText.
]

{ #category : #'api - no code' }
LeExampleSnippetViewModel >> onSnippetNoCodeChanged: aLeExampleSnippetNoCodeChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetNoCodeChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self clearCachedExamplePreview.
	self announce: aLeExampleSnippetNoCodeChanged
]

{ #category : #'api - preview expanded' }
LeExampleSnippetViewModel >> onSnippetPreviewExpandedChanged: aLeExampleSnippetPreviewExpandedChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewExpandedChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self clearCachedExamplePreview.
	self announce: aLeExampleSnippetPreviewExpandedChanged
]

{ #category : #'api - preview height' }
LeExampleSnippetViewModel >> onSnippetPreviewHeightChanged: aLeExampleSnippetPreviewHeightChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewHeightChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self clearCachedExamplePreview.
	self announce: aLeExampleSnippetPreviewHeightChanged
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> onSnippetPreviewSelectSelectorChanged: aLeExampleSnippetPreviewSelectorSelectorChanged [
	
	self clearCachedExamplePreview.
	self announce: aLeExampleSnippetPreviewSelectorSelectorChanged
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> onSnippetPreviewShowSelectorChanged: aLeExampleSnippetPreviewShowSelectorChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewShowSelectorChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self clearCachedExamplePreview.
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

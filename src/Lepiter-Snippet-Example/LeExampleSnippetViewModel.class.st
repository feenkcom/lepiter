Class {
	#name : #LeExampleSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#instVars : [
		'annotationCoderViewModel'
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
	
	self annotationCoderViewModel focused: true
]

{ #category : #'api - accessing' }
LeExampleSnippetViewModel >> gtExampleDo: aBlock [
	"Try to retrieve a GtExample for an example snippet"
	<return: #GtExample>
	| anExampleClass anExampleMethod gtExample |
	
	self
		optionAt: #gtExample
		ifPresent: [ :aGtExample |
			(aGtExample methodClass name = self exampleBehaviorName
				and: [ aGtExample selector = self exampleSelector ])
					ifTrue: [ ^ aBlock value: aGtExample ] ]
		ifAbsent: [ ].
	
	self snippetModel hasExampleBehaviorName
		ifFalse: [ ^ self ].

	self snippetModel hasExampleSelector
		ifFalse: [ ^ self ].
	
	anExampleClass := self class evaluate: self exampleBehaviorName.
	
	anExampleClass ifNil: [ ^ self ].
	
	anExampleMethod := (anExampleClass lookupSelector: self exampleSelector asSymbol)
		ifNil: [ ^ self ].
	
	gtExample := anExampleMethod gtExample.
	self
		optionAt: #gtExample
		put: gtExample.
	aBlock value: gtExample
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
	
	annotationCoder := GtTextCoder new
		parser: LeAnnotationParser;
		parserStartingState: LeAnnotationParser startingStateForExampleAnnotation.
	
	self annotationCoderViewModel: (annotationCoder asCoderViewModel addStyler: LeExampleSnippetStyler new).
	
	self when: LeExampleSnippetContentChanged send: #requestUpdateAnnotationText to: self
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

{ #category : #'private - event handling' }
LeExampleSnippetViewModel >> onAnnotationAstChanged: anAstChangedAnnouncement [
	| anAst |
	
	anAst := anAstChangedAnnouncement ast.
	anAst
		allNodesDo: [ :eachNode | eachNode isErrorNode ifTrue: [ ^ self ] ]
		andTokensDo: [ :eachToken | ]
		includeErrors: true.
	
	"it is possible that multiple parameters were changes as part of the ast update.
	we should queue them up and request annotation update only once at the very end"
	self optionAt: #doNotUpdateText put: true.
	[
		LeExampleSnippetAnnotationVisitor new
			exampleSnippet: self;
			accept: anAst.
	] ensure: [ self optionAt: #doNotUpdateText put: false ].

	self requestUpdateAnnotationText
]

{ #category : #'api - annotation coder view model' }
LeExampleSnippetViewModel >> onNewAnnotationCoderViewModelSet: aNewAnnotationCoderViewModel [
	"Is sent after a new value of the annotationCoderViewModel is assigned"
	<propertySetHook: #annotationCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
	
	aNewAnnotationCoderViewModel weak
		when: GtTextualCoderViewModelAstChanged
		send: #onAnnotationAstChanged:
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
	
	self announce: aLeExampleSnippetCodeExpandedChanged
]

{ #category : #'api - example behavior name' }
LeExampleSnippetViewModel >> onSnippetExampleBehaviorNameChanged: aLeExampleSnippetExampleBehaviorNameChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetExampleBehaviorNameChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aLeExampleSnippetExampleBehaviorNameChanged
]

{ #category : #'api - example selector' }
LeExampleSnippetViewModel >> onSnippetExampleSelectorChanged: aLeExampleSnippetExampleSelectorChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetExampleSelectorChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>

	self announce: aLeExampleSnippetExampleSelectorChanged
]

{ #category : #'api - snippet model' }
LeExampleSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	self updateAnnotationText
]

{ #category : #'api - no code' }
LeExampleSnippetViewModel >> onSnippetNoCodeChanged: aLeExampleSnippetNoCodeChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetNoCodeChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aLeExampleSnippetNoCodeChanged
]

{ #category : #'api - preview expanded' }
LeExampleSnippetViewModel >> onSnippetPreviewExpandedChanged: aLeExampleSnippetPreviewExpandedChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewExpandedChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aLeExampleSnippetPreviewExpandedChanged
]

{ #category : #'api - preview height' }
LeExampleSnippetViewModel >> onSnippetPreviewHeightChanged: aLeExampleSnippetPreviewHeightChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewHeightChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aLeExampleSnippetPreviewHeightChanged
]

{ #category : #'api - preview show selector' }
LeExampleSnippetViewModel >> onSnippetPreviewShowSelectorChanged: aLeExampleSnippetPreviewShowSelectorChanged [
	<modelEventHandler: #snippet event: #LeExampleSnippetPreviewShowSelectorChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aLeExampleSnippetPreviewShowSelectorChanged
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

	self snippetModel when: LeExampleSnippetExampleBehaviorNameChanged send: #onSnippetExampleBehaviorNameChanged: to: self.
	self snippetModel when: LeExampleSnippetExampleSelectorChanged send: #onSnippetExampleSelectorChanged: to: self.
	self snippetModel when: LeExampleSnippetCodeExpandedChanged send: #onSnippetCodeExpandedChanged: to: self.
	self snippetModel when: LeExampleSnippetNoCodeChanged send: #onSnippetNoCodeChanged: to: self.
	self snippetModel when: LeExampleSnippetPreviewExpandedChanged send: #onSnippetPreviewExpandedChanged: to: self.
	self snippetModel when: LeExampleSnippetPreviewShowSelectorChanged send: #onSnippetPreviewShowSelectorChanged: to: self.
	self snippetModel when: LeExampleSnippetPreviewHeightChanged send: #onSnippetPreviewHeightChanged: to: self.
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

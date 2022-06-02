Class {
	#name : #LeChangesSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#instVars : [
		'changes',
		'fileNameCoderViewModel'
	],
	#category : #'Lepiter-Snippet-Changes-Snippet'
}

{ #category : #'api - changes' }
LeChangesSnippetViewModel >> changes [
	<return: #GtEpicea>
	<propertyGetter: #changes>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ changes
]

{ #category : #'api - changes' }
LeChangesSnippetViewModel >> changes: aNewChanges [
	<propertySetter: #changes>
	<propertyAnnouncement: #LeChangesSnippetViewModelChangesChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasChanges
		and: [ self changes = aNewChanges ])
			ifTrue: [ ^ self ].
	
	self hasChanges
		ifTrue: [
			| aPreviousChanges |
			aPreviousChanges := changes.
			changes := nil.
			self onPreviousChangesUnset: aPreviousChanges ].
	changes := aNewChanges.
	self onNewChangesSet: aNewChanges.
	self notifyChangesChanged
]

{ #category : #'api - file name' }
LeChangesSnippetViewModel >> fileName [
	<return: #String>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel fileName
]

{ #category : #'api - file name' }
LeChangesSnippetViewModel >> fileName: aFileName [
	<propertySetter: #fileName>
	<propertyAnnouncement: #LeChangesSnippetFileNameChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel fileName: aFileName
]

{ #category : #'api - file name coder view model' }
LeChangesSnippetViewModel >> fileNameCoderViewModel [
	<return: #GtTextCoder>
	<propertyGetter: #fileNameCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ fileNameCoderViewModel
]

{ #category : #'api - file name coder view model' }
LeChangesSnippetViewModel >> fileNameCoderViewModel: aNewFileNameCoderViewModel [
	<propertySetter: #fileNameCoderViewModel>
	<propertyAnnouncement: #LeChangesSnippetViewModelFileNameCoderViewModelChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasFileNameCoderViewModel
		and: [ self fileNameCoderViewModel = aNewFileNameCoderViewModel ])
			ifTrue: [ ^ self ].
	
	self hasFileNameCoderViewModel
		ifTrue: [
			| aPreviousFileNameCoderViewModel |
			aPreviousFileNameCoderViewModel := fileNameCoderViewModel.
			fileNameCoderViewModel := nil.
			self onPreviousFileNameCoderViewModelUnset: aPreviousFileNameCoderViewModel ].
	fileNameCoderViewModel := aNewFileNameCoderViewModel.
	self onNewFileNameCoderViewModelSet: aNewFileNameCoderViewModel.
	self notifyFileNameCoderViewModelChanged
]

{ #category : #'api - focus' }
LeChangesSnippetViewModel >> focusAfterCreation [
	super focusAfterCreation.
	
	self fileNameCoderViewModel
		focused: true;
		moveCursorAtEnd
]

{ #category : #'api - focus' }
LeChangesSnippetViewModel >> focusDueToNavigationDown [
	super focusDueToNavigationDown.
	
	self fileNameCoderViewModel
		focused: true;
		moveCursorAtEnd
]

{ #category : #'api - focus' }
LeChangesSnippetViewModel >> focusDueToNavigationUp [
	super focusDueToNavigationUp.
	
	self fileNameCoderViewModel
		focused: true;
		moveCursorAtEnd
]

{ #category : #'api - changes' }
LeChangesSnippetViewModel >> hasChanges [
	<return: #Boolean>
	<propertyTester: #changes>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ changes notNil
]

{ #category : #'api - accessing' }
LeChangesSnippetViewModel >> hasChangesFile [
	"Return true if changes file exists"
	<return: #Boolean>

	^ (self hasChanges and: [ self changes ombuFileExists ])
]

{ #category : #'api - file name coder view model' }
LeChangesSnippetViewModel >> hasFileNameCoderViewModel [
	<return: #Boolean>
	<propertyTester: #fileNameCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ fileNameCoderViewModel notNil
]

{ #category : #initialization }
LeChangesSnippetViewModel >> initialize [
	super initialize.
	
	self fileNameCoderViewModel: GtTextCoder new asCoderViewModel.
	
	self when: LeChangesSnippetFileNameChanged send: #onFileNameChanged to: self
]

{ #category : #'api - changes' }
LeChangesSnippetViewModel >> notifyChangesChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #changes>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (LeChangesSnippetViewModelChangesChanged new
		changes: self changes).
]

{ #category : #'api - file name coder view model' }
LeChangesSnippetViewModel >> notifyFileNameCoderViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #fileNameCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (LeChangesSnippetViewModelFileNameCoderViewModelChanged new
		fileNameCoderViewModel: self fileNameCoderViewModel).
]

{ #category : #'private - event handling' }
LeChangesSnippetViewModel >> onFileNameChanged [
	self updateChanges
]

{ #category : #'private - event handling' }
LeChangesSnippetViewModel >> onFileNameCoderTextChanged: anAnnouncement [
	self fileName: anAnnouncement text asString
]

{ #category : #'api - changes' }
LeChangesSnippetViewModel >> onNewChangesSet: aNewChanges [
	"Is sent after a new value of the changes is assigned"
	<propertySetHook: #changes>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - file name coder view model' }
LeChangesSnippetViewModel >> onNewFileNameCoderViewModelSet: aNewFileNameCoderViewModel [
	"Is sent after a new value of the fileNameCoderViewModel is assigned"
	<propertySetHook: #fileNameCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
	
	aNewFileNameCoderViewModel weak
		when: GtTextualCoderViewModelTextChanged
		send: #onFileNameCoderTextChanged:
		to: self
]

{ #category : #'api - changes' }
LeChangesSnippetViewModel >> onPreviousChangesUnset: aPreviousChanges [
	"Is sent after a previous value of the changes is de-assigned"
	<propertyUnsetHook: #changes>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - file name coder view model' }
LeChangesSnippetViewModel >> onPreviousFileNameCoderViewModelUnset: aPreviousFileNameCoderViewModel [
	"Is sent after a previous value of the fileNameCoderViewModel is de-assigned"
	<propertyUnsetHook: #fileNameCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
	
	aPreviousFileNameCoderViewModel unsubscribe: self
]

{ #category : #'api - file name' }
LeChangesSnippetViewModel >> onSnippetFileNameChanged: aLeChangesSnippetFileNameChanged [
	<modelEventHandler: #snippet event: #LeChangesSnippetFileNameChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aLeChangesSnippetFileNameChanged
]

{ #category : #'api - snippet model' }
LeChangesSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	self updateChanges
]

{ #category : #'api - preview height' }
LeChangesSnippetViewModel >> onSnippetPreviewHeightChanged: aLeChangesSnippetPreviewHeightChanged [
	<modelEventHandler: #snippet event: #LeChangesSnippetPreviewHeightChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aLeChangesSnippetPreviewHeightChanged
]

{ #category : #'api - preview height' }
LeChangesSnippetViewModel >> previewHeight [
	<return: #Number>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self snippetModel previewHeight
]

{ #category : #'api - preview height' }
LeChangesSnippetViewModel >> previewHeight: aPreviewHeight [
	<propertySetter: #previewHeight>
	<propertyAnnouncement: #LeChangesSnippetPreviewHeightChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self snippetModel previewHeight: aPreviewHeight
]

{ #category : #'api - accessing' }
LeChangesSnippetViewModel >> shouldCreateChangesFile [
	"Return true if a changes file should be created"
	<return: #Boolean>

	^ (self hasChanges and: [ self changes ombuFileExists not ])
]

{ #category : #'api - accessing' }
LeChangesSnippetViewModel >> snippetElementClass [
	^ LeChangesSnippetElement
]

{ #category : #'api - snippet model' }
LeChangesSnippetViewModel >> subscribeToSnippetModel [
	"Is sent after a new snippetModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSnippetModel if the receiver subscribes to them"
	<modelSubscriber: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	super subscribeToSnippetModel.
	self snippetModel weak when: LeChangesSnippetFileNameChanged send: #onSnippetFileNameChanged: to: self.
	self snippetModel weak when: LeChangesSnippetPreviewHeightChanged send: #onSnippetPreviewHeightChanged: to: self.
]

{ #category : #'api - changes' }
LeChangesSnippetViewModel >> unsetChanges [
	<propertyUnsetter: #changes>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousChanges |

	self hasChanges
		ifFalse: [ ^ self ].

	aPreviousChanges := changes.
	changes := nil.
	self onPreviousChangesUnset: aPreviousChanges.
	self notifyChangesChanged
]

{ #category : #'api - file name coder view model' }
LeChangesSnippetViewModel >> unsetFileNameCoderViewModel [
	<propertyUnsetter: #fileNameCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousFileNameCoderViewModel |

	self hasFileNameCoderViewModel
		ifFalse: [ ^ self ].

	aPreviousFileNameCoderViewModel := fileNameCoderViewModel.
	fileNameCoderViewModel := nil.
	self onPreviousFileNameCoderViewModelUnset: aPreviousFileNameCoderViewModel.
	self notifyFileNameCoderViewModelChanged
]

{ #category : #'api - snippet model' }
LeChangesSnippetViewModel >> unsubscribeFromSnippetModel [
	"Is sent before a new snippetModel is assigned to the receiver.
	Objects that subscribe to snippetModel are required to implement this method."
	<modelUnsubscriber: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	super unsubscribeFromSnippetModel.
	self snippetModel unsubscribe: self.
]

{ #category : #'private - updating' }
LeChangesSnippetViewModel >> updateChanges [
	| fileNameWithExtension aFile theChanges |

	self fileNameCoderViewModel
		sourceText: (self snippetModel hasFileName ifTrue: [ self snippetModel fileName ] ifFalse: [ '' ]) asRopedText
		from: self
		synchronously: false.

	self snippetModel hasFileName
		ifFalse: [ ^ self unsetChanges ].
		
	self snippetModel fileName isEmpty
		ifTrue: [ ^ self unsetChanges ].

	fileNameWithExtension := (self snippetModel fileName
		endsWith: LepiterConstants changesFileExtension)
		ifTrue: [ self snippetModel fileName ]
		ifFalse: [ self snippetModel fileName , LepiterConstants changesFileExtension ].

	aFile := self resolveFileName: fileNameWithExtension.

	theChanges := GtEpicea new.
	theChanges ombuFile: aFile.
	self changes: theChanges
]

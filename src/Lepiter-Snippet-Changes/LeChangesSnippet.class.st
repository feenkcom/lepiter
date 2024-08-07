Class {
	#name : #LeChangesSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'fileName',
		'previewHeight'
	],
	#category : #'Lepiter-Snippet-Changes-Snippet'
}

{ #category : #'api - accessing menu' }
LeChangesSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LeChangesSnippet class >> description [
	^ 'Changes'
]

{ #category : #factory }
LeChangesSnippet class >> empty [
	"Return a content (page or block) with empty values (title or text).
	Required by ${method:LeContent>>#addBlockOfClass:after:}$"
	^ self new
]

{ #category : #jsonV3 }
LeChangesSnippet class >> leJsonV4AttributeMapping [
	"To retries properties:
	(Pragma allNamed: #propertyGetter: in: self) collect: [ :eachPragma | (eachPragma argumentAt: 1) -> (eachPragma argumentAt: 1) ]"
	^ super leJsonV4AttributeMapping
		addAll: {#previewHeight->#previewHeight. #fileName->#fileName};
		yourself
]

{ #category : #'lepiter-store' }
LeChangesSnippet class >> leJsonV4Name [

	^ 'changesSnippet'
]

{ #category : #visiting }
LeChangesSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitChangesSnippet: self
]

{ #category : #converting }
LeChangesSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LeChangesSnippetViewModel new snippetModel: self
]

{ #category : #'api - accessing' }
LeChangesSnippet >> contentAsString [
	^ '{{gtChanges:'
			, (self fileName ifNil: ['<missing>']), 
			'}}'
]

{ #category : #'api - file name' }
LeChangesSnippet >> fileName [
	<return: #String>
	<propertyGetter: #fileName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ fileName
]

{ #category : #'api - file name' }
LeChangesSnippet >> fileName: aNewFileName [
	<propertySetter: #fileName>
	<propertyAnnouncement: #LeChangesSnippetFileNameChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasFileName
		and: [ self fileName = aNewFileName ])
			ifTrue: [ ^ self ].
	
	self hasFileName
		ifTrue: [
			| aPreviousFileName |
			aPreviousFileName := fileName.
			fileName := nil.
			self onPreviousFileNameUnset: aPreviousFileName ].
	fileName := aNewFileName.
	self onNewFileNameSet: aNewFileName.
	self notifyFileNameChanged
]

{ #category : #'api - file name' }
LeChangesSnippet >> hasFileName [
	<return: #Boolean>
	<propertyTester: #fileName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ fileName notNil
]

{ #category : #'api - preview height' }
LeChangesSnippet >> hasPreviewHeight [
	<return: #Boolean>
	<propertyTester: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ previewHeight notNil
]

{ #category : #initialization }
LeChangesSnippet >> initialize [
	super initialize.
	
	previewHeight := 200
]

{ #category : #'private - exporting' }
LeChangesSnippet >> markdownOn: stream level: anInteger [
	"Here we should inline the ombu file."

	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		cr;
		<< '```';
		cr;
		<< self contentAsString trimBoth;
		<< '```';
		cr.
	self
		childrenDo: [ :child | 
			stream cr.
			child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #'api - file name' }
LeChangesSnippet >> notifyFileNameChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #fileName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeChangesSnippetFileNameChanged new
		source: self;
		snippet: self;
		fileName: self fileName).
]

{ #category : #'api - preview height' }
LeChangesSnippet >> notifyPreviewHeightChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self notifyAnnouncement: (LeChangesSnippetPreviewHeightChanged new
		source: self;
		snippet: self;
		previewHeight: self previewHeight).
]

{ #category : #'api - file name' }
LeChangesSnippet >> onNewFileNameSet: aNewFileName [
	"Is sent after a new value of the fileName is assigned"
	<propertySetHook: #fileName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - preview height' }
LeChangesSnippet >> onNewPreviewHeightSet: aNewPreviewHeight [
	"Is sent after a new value of the previewHeight is assigned"
	<propertySetHook: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - file name' }
LeChangesSnippet >> onPreviousFileNameUnset: aPreviousFileName [
	"Is sent after a previous value of the fileName is de-assigned"
	<propertyUnsetHook: #fileName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - preview height' }
LeChangesSnippet >> onPreviousPreviewHeightUnset: aPreviousPreviewHeight [
	"Is sent after a previous value of the previewHeight is de-assigned"
	<propertyUnsetHook: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - preview height' }
LeChangesSnippet >> previewHeight [
	<return: #Number>
	<propertyGetter: #previewHeight>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ previewHeight
]

{ #category : #'api - preview height' }
LeChangesSnippet >> previewHeight: aNewPreviewHeight [
	<propertySetter: #previewHeight>
	<propertyAnnouncement: #LeChangesSnippetPreviewHeightChanged>
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

{ #category : #printing }
LeChangesSnippet >> storeOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new fileName:'.
	self fileName storeOn: aStream.
	aStream nextPut: $)
]

{ #category : #'api - file name' }
LeChangesSnippet >> unsetFileName [
	<propertyUnsetter: #fileName>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousFileName |

	self hasFileName
		ifFalse: [ ^ self ].

	aPreviousFileName := fileName.
	fileName := nil.
	self onPreviousFileNameUnset: aPreviousFileName.
	self notifyFileNameChanged
]

{ #category : #'api - preview height' }
LeChangesSnippet >> unsetPreviewHeight [
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

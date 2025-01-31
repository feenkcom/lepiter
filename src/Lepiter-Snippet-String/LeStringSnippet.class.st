Class {
	#name : #LeStringSnippet,
	#superclass : #LeCodeSnippet,
	#instVars : [
		'contentString',
		'bindingName',
		'format'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #'api - accessing menu' }
LeStringSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LeStringSnippet class >> description [
	^ 'String'
]

{ #category : #accessing }
LeStringSnippet class >> empty [
	^ self new
]

{ #category : #accessing }
LeStringSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #contentString -> #contentString;
		add: #bindingName -> #bindingName;
		add: #format -> #format;
		yourself
]

{ #category : #accessing }
LeStringSnippet class >> leJsonV4Name [
	^ 'stringSnippet'
]

{ #category : #visiting }
LeStringSnippet >> acceptVisitor: aVisitor [
 
	^ aVisitor visitStringSnippet: self
]

{ #category : #'api - editing' }
LeStringSnippet >> announceTextChangedBy: anObject withTextEditCommand: aTextEditCommand [ 
	"Notify all dependents that the receiver's text has changed"

	self notifyAnnouncement: (LeSnippetTextChanged new
		source: anObject;
		snippet: self;
		textEditCommand: aTextEditCommand)
]

{ #category : #'api - editing' }
LeStringSnippet >> appendText: aText source: anObject [
	"Text attributes aren't part of the model, so appending an empty text with attributes is meaningless and can be ignored"

	aText ifEmpty: [ ^ self ].

	self assertText: aText.

	self contentString: self contentString , aText asString.

	self updateEditTimeAndEmail.

	self announceTextChangedBy: anObject
]

{ #category : #converting }
LeStringSnippet >> asPhlowTool [
	^ GtPhlowCompositeTool new
		addTool: (LeIsolatedSnippetPhlowTool snippet: self);
		addTool: (GtPhlowTool default object: self)
]

{ #category : #converting }
LeStringSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeStringSnippetViewModel new snippetModel: self
]

{ #category : #'private - asserting' }
LeStringSnippet >> assertText: aText [
	self 
		assert: [ aText isNotNil ] 
		description: [ 'Text must be non-nil' ]. 
	self 
		assert: [ aText isKindOf: BlText ] 
		description: [ 'Text must be a ', BlText name, ' instance' ]. 
]

{ #category : #accessing }
LeStringSnippet >> ast [
	self parser ifNil: [ ^ nil ].
	self contentString ifEmpty: [ ^ nil ].
	^ self parser parseWithErrors: self contentAsString
]

{ #category : #accessing }
LeStringSnippet >> bindingName [
	^ bindingName
]

{ #category : #accessing }
LeStringSnippet >> bindingName: aNameString [
	| anOldName |
	bindingName = aNameString ifTrue: [ ^ self ].
	anOldName := bindingName.
	bindingName := aNameString.
	self notifyBindingNameChangedFrom: anOldName to: aNameString
]

{ #category : #accessing }
LeStringSnippet >> contentAsString [
	^ self contentString ifNil: [ String new ]
]

{ #category : #accessing }
LeStringSnippet >> contentString [
	^ contentString ifNil: [ contentString := String empty ]
]

{ #category : #accessing }
LeStringSnippet >> contentString: aString [
	contentString := aString
]

{ #category : #initialization }
LeStringSnippet >> defaultPreviewHeight [
	^ 300
]

{ #category : #accessing }
LeStringSnippet >> format [
	^ format
]

{ #category : #accessing }
LeStringSnippet >> format: aFormatString [
	format = aFormatString ifTrue: [ ^ self ].
	format := aFormatString.
	self notifyFormatChanged
]

{ #category : #initialization }
LeStringSnippet >> newCoder [
	^ GtTextCoder new
]

{ #category : #'private - notifying' }
LeStringSnippet >> notifyBindingNameChangedFrom: anOldName to: aNewName [
	self notifier
		local;
		announce: (LeStringBindingNameChanged new
				oldName: anOldName;
				newName: aNewName)
]

{ #category : #'private - notifying' }
LeStringSnippet >> notifyFormatChanged [
	self notifier
		local;
		announce: (LeStringFormatChanged new
				parser: self parser;
				format: self format)
]

{ #category : #'api - accessing' }
LeStringSnippet >> paragraphStyle [
	^ LeParagraphStyle text
]

{ #category : #accessing }
LeStringSnippet >> parser [
	^ self format
		ifNotNil: [ :aParserName | self class environment at: aParserName asSymbol ifAbsent: [ nil ] ]
]

{ #category : #'as yet unclassified' }
LeStringSnippet >> selectParserClass: aParserClass [
	self format: aParserClass name
]

{ #category : #printing }
LeStringSnippet >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new contentString: '.
	self contentString storeOn: aStream.
	aStream nextPutAll: '; bindingName: '.
	self bindingName storeOn: aStream.
	aStream nextPutAll: '; format: '.
	self format storeOn: aStream.
	aStream nextPutAll: '; yourself)'
]

{ #category : #accessing }
LeStringSnippet >> text [
	^ self contentString asRopedText
]

{ #category : #'api - editing' }
LeStringSnippet >> updateFromTextEditCommand: aCommand source: anObject [	
	"Update the contet of the snippet using the given command."
	| targetText|
	targetText := self text.
	aCommand applyTextChangeOn:  targetText.
	self contentString: targetText asString.
	
	self 
		announceTextChangedBy: anObject 
		withTextEditCommand: aCommand.
]

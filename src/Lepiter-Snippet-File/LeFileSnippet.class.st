Class {
	#name : #LeFileSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'fileReference',
		'bindingName'
	],
	#category : #'Lepiter-Snippet-File'
}

{ #category : #'api - accessing menu' }
LeFileSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LeFileSnippet class >> description [
	^ 'File'
]

{ #category : #accessing }
LeFileSnippet class >> empty [
	^ self new
]

{ #category : #accessing }
LeFileSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #fileReferenceRepresentation -> #fileReference;
		add: #bindingName -> #bindingName;
		yourself
]

{ #category : #accessing }
LeFileSnippet class >> leJsonV4Name [
	^ 'fileSnippet'
]

{ #category : #converting }
LeFileSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeFileSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeFileSnippet >> bindingName [
	^ bindingName
]

{ #category : #accessing }
LeFileSnippet >> bindingName: aNameString [
	bindingName := aNameString
]

{ #category : #testing }
LeFileSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : #accessing }
LeFileSnippet >> contentAsString [
	self fileReference ifNil: [ ^ String new ].
	^ self fileReferenceRepresentation
]

{ #category : #accessing }
LeFileSnippet >> fileReference [
	^ fileReference
]

{ #category : #accessing }
LeFileSnippet >> fileReference: aFileReference [
	aFileReference ifNil: [ ^ fileReference := nil ].
	fileReference := aFileReference asFileReference
]

{ #category : #accessing }
LeFileSnippet >> fileReferenceRepresentation [
	self fileReference ifNil: [ ^ nil ].
	^ self fileReference asUrl asString
]

{ #category : #accessing }
LeFileSnippet >> fileReferenceRepresentation: aString [
	| url |
	aString ifNil: [ ^ self fileReference: nil ].
	url := aString asUrl.
	^ self fileReference: url
]

{ #category : #printing }
LeFileSnippet >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new fileReference:'.
	self fileReference storeOn: aStream.
	aStream nextPutAll: '; bindingName:'.
	self bindingName storeOn: aStream.
	aStream nextPutAll: '; yourself)'
]

Class {
	#name : #LeStringSnippet,
	#superclass : #LeSnippet,
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
		title: 'String'
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

{ #category : #converting }
LeStringSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeStringSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeStringSnippet >> bindingName [
	^ bindingName
]

{ #category : #accessing }
LeStringSnippet >> bindingName: aNameString [
	bindingName := aNameString
]

{ #category : #accessing }
LeStringSnippet >> contentAsString [
	^ self contentString ifNil: [ String new ]
]

{ #category : #accessing }
LeStringSnippet >> contentString [
	^ contentString
]

{ #category : #accessing }
LeStringSnippet >> contentString: aString [
	contentString := aString
]

{ #category : #accessing }
LeStringSnippet >> format [
	^ format
]

{ #category : #accessing }
LeStringSnippet >> format: aFormatString [
	format := aFormatString
]

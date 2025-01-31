Class {
	#name : #LeJenkinsSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'jenkinsUrl'
	],
	#category : #'Lepiter-Snippet-Jenkins-Model'
}

{ #category : #'api - accessing menu' }
LeJenkinsSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LeJenkinsSnippet class >> description [
	^ 'Jenkins'
]

{ #category : #accessing }
LeJenkinsSnippet class >> empty [ 
	^ self new jenkinsUrl: ''.
]

{ #category : #accessing }
LeJenkinsSnippet class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		add: (#jenkinsUrl -> #jenkinsUrl);
		yourself 
]

{ #category : #accessing }
LeJenkinsSnippet class >> leJsonV3Name [
	^ 'jenkinsSnippet'
]

{ #category : #accessing }
LeJenkinsSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: (#jenkinsUrl -> #jenkinsUrl);
		yourself 
]

{ #category : #accessing }
LeJenkinsSnippet class >> leJsonV4Name [
	^ 'jenkinsSnippet'
]

{ #category : #accessing }
LeJenkinsSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeJenkinsSnippetViewModel new jenkinsSnippetModel: self
]

{ #category : #testing }
LeJenkinsSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : #accessing }
LeJenkinsSnippet >> contentAsString [
	<return: #String>
	^ String streamContents: [ :aStream |
			aStream
				nextPutAll: (self jenkinsUrl ifEmpty: [ '<jenkinsUrl>' ])]
]

{ #category : #accessing }
LeJenkinsSnippet >> jenkinsUrl [
	^ jenkinsUrl
]

{ #category : #accessing }
LeJenkinsSnippet >> jenkinsUrl: aJenkinsUrl [
	jenkinsUrl := aJenkinsUrl
]

{ #category : #printing }
LeJenkinsSnippet >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new jenkinsUrl:'.
	self jenkinsUrl storeOn: aStream.
	aStream nextPutAll: '; yourself)'
]

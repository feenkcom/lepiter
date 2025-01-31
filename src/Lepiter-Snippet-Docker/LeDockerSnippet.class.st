Class {
	#name : #LeDockerSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'url'
	],
	#category : #'Lepiter-Snippet-Docker-Model'
}

{ #category : #accessing }
LeDockerSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #accessing }
LeDockerSnippet class >> description [
	^ 'Docker'
]

{ #category : #'instace creation' }
LeDockerSnippet class >> empty [ 
	^ self new url: 'http://localhost:2375'.
]

{ #category : #'mapping - model' }
LeDockerSnippet class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		add: (#url -> #url);
		yourself 
]

{ #category : #accessing }
LeDockerSnippet class >> leJsonV3Name [
	^ 'com.feenk.docker.api.snippet'
]

{ #category : #'mapping - model' }
LeDockerSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: (#url -> #url);
		yourself 
]

{ #category : #accessing }
LeDockerSnippet class >> leJsonV4Name [
	^ 'com.feenk.docker.api.snippet'
]

{ #category : #accessing }
LeDockerSnippet >> asSnippetViewModel [
	<return: #LeDockerSnippetViewModel>
	^ LeDockerSnippetViewModel new snippetModel: self
]

{ #category : #testing }
LeDockerSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : #'api - accessing' }
LeDockerSnippet >> contentAsString [
	<return: #String>
	^ String streamContents: [ :aStream |
			aStream
				nextPutAll: (self url ifEmpty: [ '<dockerUrl>' ])]
]

{ #category : #notifications }
LeDockerSnippet >> notifyUrlChanged [
	self notifyAnnouncement: (LeDockerSnippetUrlChanged new
		source: self;
		snippet: self;
		url: self url).
]

{ #category : #printing }
LeDockerSnippet >> storeOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new url: '.
	self url storeOn: aStream.
	self childrenDo: [ :snippet | 
		aStream nextPutAll: '; addSnippet: '.
		snippet storeOn: aStream ].
	aStream nextPutAll: '; yourself)'
]

{ #category : #accessing }
LeDockerSnippet >> url [
	^ url
]

{ #category : #accessing }
LeDockerSnippet >> url: dockerApiUrl [
	self url = dockerApiUrl ifTrue: [ ^ self ].
			
	url := dockerApiUrl.
	self notifyUrlChanged.
]

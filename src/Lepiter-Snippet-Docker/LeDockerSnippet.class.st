Class {
	#name : #LeDockerSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'url'
	],
	#category : #'Lepiter-Snippet-Docker-Model'
}

{ #category : #accessing }
LeDockerSnippet class >> contextMenuItemSpefication [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Docker'
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

{ #category : #'api - accessing' }
LeDockerSnippet >> contentAsString [
	<return: #String>
	^ String streamContents: [ :aStream |
			aStream
				nextPutAll: (self url ifEmpty: [ '<dockerUrl>' ])]
]

{ #category : #accessing }
LeDockerSnippet >> url [
	^ url
]

{ #category : #accessing }
LeDockerSnippet >> url: dockerApiUrl [
	url := dockerApiUrl
]

Class {
	#name : #LeGitHubTagSnippet,
	#superclass : #LeGitHubSnippet,
	#instVars : [
		'tagName'
	],
	#category : #'Lepiter-GitHub-Snippets'
}

{ #category : #'api - accessing menu' }
LeGitHubTagSnippet class >> contextMenuItemSpecification [
	"<leSnippetSpecification>"
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LeGitHubTagSnippet class >> description [
	^ 'GitHub tag'
]

{ #category : #jsonV3 }
LeGitHubTagSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#tagName -> #tagName);
		yourself
]

{ #category : #jsonV3 }
LeGitHubTagSnippet class >> leJsonV3Name [

	^ 'githubTagSnippet'
]

{ #category : #jsonV3 }
LeGitHubTagSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#tagName -> #tagName);
		yourself
]

{ #category : #jsonV3 }
LeGitHubTagSnippet class >> leJsonV4Name [

	^ 'githubTagSnippet'
]

{ #category : #visiting }
LeGitHubTagSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitGitHubTagSnippet: self
]

{ #category : #converting }
LeGitHubTagSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeGitHubTagViewModel new snippetModel: self
]

{ #category : #'api - accessing' }
LeGitHubTagSnippet >> contentAsString [
	<return: #String>
	^ String streamContents: [ :aStream |
			aStream
				nextPutAll: (self ownerName ifEmpty: [ '<username>' ]);
				nextPut: $/;
				nextPutAll: (self projectName ifEmpty: [ '<project>' ]);
				nextPutAll: '#';
				nextPutAll: (self tagName ifEmpty: [ '<tag>' ]) ]
]

{ #category : #initialization }
LeGitHubTagSnippet >> defaultModel [
	^ LeGitHubTagModel new
]

{ #category : #'api - model' }
LeGitHubTagSnippet >> tagName [
	^ self model tagName ifNil: [ String empty ]
]

{ #category : #'api - model' }
LeGitHubTagSnippet >> tagName: aString [
	self model tagName: aString
]

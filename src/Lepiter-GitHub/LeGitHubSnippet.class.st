Class {
	#name : #LeGitHubSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'model',
		'responseCacheName'
	],
	#category : #'Lepiter-GitHub-Snippets'
}

{ #category : #factory }
LeGitHubSnippet class >> empty [
	^ self new
]

{ #category : #testing }
LeGitHubSnippet class >> isAbstract [
	^ self name = #LeGitHubSnippet
]

{ #category : #jsonV3 }
LeGitHubSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#ownerName -> #ownerName);
		add: (#projectName -> #projectName);
		add: (#responseCacheName -> #responseCacheName);
		yourself
]

{ #category : #jsonV3 }
LeGitHubSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#ownerName -> #ownerName);
		add: (#projectName -> #projectName);
		add: (#responseCacheName -> #responseCacheName);
		yourself
]

{ #category : #visiting }
LeGitHubSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitGitHubSnippet: self
]

{ #category : #initialization }
LeGitHubSnippet >> defaultModel [
	<return: #LeGitHubModel>
	^ self subclassResponsibility
]

{ #category : #initialization }
LeGitHubSnippet >> initialize [
	super initialize.
	model := self defaultModel.
	model weak
		when: LeGitHubModelConfigurationChangedAnnouncement
		send: #onModelConfigurationChanged:
		to: self.
	model weak
		when: LeGitHubModelResponseChangedAnnouncement
		send: #onModelResponseChanged:
		to: self.
	
]

{ #category : #'api - accessing' }
LeGitHubSnippet >> model [
	<return: #LeGitHubModel>
	^ model
]

{ #category : #accessing }
LeGitHubSnippet >> onAddedToDatabase [
	super onAddedToDatabase.
	self responseCacheName ifNil: [ ^ self ].
	self updateModelResponseSource: nil.
]

{ #category : #'private - announcement handling' }
LeGitHubSnippet >> onModelChanged: anAnnouncement [
	self onModelConfigurationChanged: anAnnouncement
]

{ #category : #'private - announcement handling' }
LeGitHubSnippet >> onModelConfigurationChanged: anAnnouncement [
	self announceContentChangedBy: anAnnouncement source
]

{ #category : #'private - announcement handling' }
LeGitHubSnippet >> onModelResponseChanged: anAnnouncement [

	| aDatabase |
	self model hasSuccessResponse ifFalse: [ ^ self ].

	aDatabase := self database.
	aDatabase isDatabase ifFalse: [ ^ self ].
	aDatabase monitor ifNil: [ ^ self ].

	self responseCacheName
		ifNil: [ 
			| aFileName |
			aFileName := aDatabase
				             addAttachmentWithContent: self responseCacheContent
				             named: 'github-response-cache.json'.
			self responseCacheName: aFileName source: anAnnouncement source ]
		ifNotNil: [ 
			aDatabase readOnly ifFalse: [ 
				aDatabase
					updateAttachmentNamed: self responseCacheName
					content: self responseCacheContent ] ]
]

{ #category : #'api - model' }
LeGitHubSnippet >> ownerName [
	^ self model ownerName ifNil: [ String empty ]
]

{ #category : #'api - model' }
LeGitHubSnippet >> ownerName: aString [
	self model ownerName: aString
]

{ #category : #'as yet unclassified' }
LeGitHubSnippet >> paragraphStyle [
	^ LeParagraphStyle text
]

{ #category : #'api - model' }
LeGitHubSnippet >> projectName [
	^ self model projectName ifNil: [ String empty ]
]

{ #category : #'api - model' }
LeGitHubSnippet >> projectName: aString [
	self model projectName: aString
]

{ #category : #'private - accessing' }
LeGitHubSnippet >> responseCacheContent [
	^ STONJSON toString: self model response rawData
]

{ #category : #'api - accessing' }
LeGitHubSnippet >> responseCacheName [
	<return: #String or: nil>
	^ responseCacheName
]

{ #category : #'api - accessing' }
LeGitHubSnippet >> responseCacheName: aString [
	self responseCacheName: aString source: nil
]

{ #category : #'api - accessing' }
LeGitHubSnippet >> responseCacheName: aString source: aSource [
	self responseCacheName = aString
		ifTrue: [ ^ self ].
	responseCacheName := aString.
	self updateModelResponseSource: aSource.
	self announceContentChangedBy: aSource
]

{ #category : #'private - updating' }
LeGitHubSnippet >> updateModelResponseSource: aSource [
	| aDatabase aFile aContent aRawData aResponse |
	self model hasResponse ifTrue: [ ^ self ].
	
	aDatabase := self database.
	aDatabase isDatabase ifFalse: [ ^ self ].
	aDatabase monitor ifNil: [ ^ self ].
	
	aFile := aDatabase resolveDbFile: self responseCacheName.
	aFile exists ifFalse: [ ^ self ].
	
	aContent := aFile readStreamEncoded: #utf8 do: [ :aStream | aStream contents ].
	aRawData := STONJSON fromString: aContent.
	aResponse := LeGitHubSuccess new rawData: aRawData.
	self model response: aResponse source: aSource.
]

{ #category : #deprecated }
LeGitHubSnippet >> userName [
	^ self ownerName
]

{ #category : #deprecated }
LeGitHubSnippet >> userName: aString [ 
	self ownerName: aString
]

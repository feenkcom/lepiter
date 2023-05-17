Class {
	#name : #LeGitHubModel,
	#superclass : #LeGitHubAnnouncingModel,
	#instVars : [
		'ownerName',
		'projectName',
		'response'
	],
	#category : #'Lepiter-GitHub-Model'
}

{ #category : #'private - announcing' }
LeGitHubModel >> announceConfigurationChangedBy: aSource [
	self announce: (LeGitHubModelConfigurationChangedAnnouncement new
		model: self;
		source: aSource)
]

{ #category : #'api - response' }
LeGitHubModel >> clearResponse [
	response := nil.
]

{ #category : #'private - execution' }
LeGitHubModel >> download [
	^ Dictionary new
]

{ #category : #'gt-extensions' }
LeGitHubModel >> gtResponseRawDataFor: aView [
	<gtView>
	self hasResponse ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Response data';
		priority: 10;
		object: [ self response ];
		view: #gtRawDataFor:
]

{ #category : #'public - testing' }
LeGitHubModel >> hasErrorResponse [
	^ self hasResponse and: [ self response isSuccess not ]
]

{ #category : #'public - testing' }
LeGitHubModel >> hasResponse [
	^ response isNotNil
]

{ #category : #'public - testing' }
LeGitHubModel >> hasSuccessResponse [
	^ self hasResponse and: [ self response isSuccess ]
]

{ #category : #'api - testing' }
LeGitHubModel >> ifError: aSuccessBlock otherwise: aOtherwiseBlock [
	^ self hasErrorResponse
		ifTrue: aSuccessBlock 
		ifFalse: aOtherwiseBlock
]

{ #category : #'api - testing' }
LeGitHubModel >> ifSuccess: aSuccessBlock otherwise: aOtherwiseBlock [
	^ self hasSuccessResponse
		ifTrue: aSuccessBlock 
		ifFalse: aOtherwiseBlock
]

{ #category : #initialization }
LeGitHubModel >> initialize [
	super initialize.
	ownerName := String empty .
	projectName := String empty.
]

{ #category : #'api - accessing' }
LeGitHubModel >> ownerName [
	^ ownerName
]

{ #category : #'api - accessing' }
LeGitHubModel >> ownerName: aString [
	self ownerName: aString source: nil.
]

{ #category : #'api - accessing' }
LeGitHubModel >> ownerName: aString source: aSource [
	self ownerName = aString ifTrue: [ ^ self ].
	ownerName := aString.
	self announceConfigurationChangedBy: aSource
]

{ #category : #'api - accessing' }
LeGitHubModel >> projectName [
	^ projectName
]

{ #category : #'api - accessing' }
LeGitHubModel >> projectName: aString [
	self projectName: aString source: nil
]

{ #category : #'api - accessing' }
LeGitHubModel >> projectName: aString source: aSource [
	self projectName = aString ifTrue: [ ^ self ].
	projectName := aString.
	self announceConfigurationChangedBy: aSource
]

{ #category : #'api - accessing' }
LeGitHubModel >> response [
	<return: #LeGitHubResponse>
	^ self responseFrom: nil
]

{ #category : #accessing }
LeGitHubModel >> response: aResponse source: aSource [
	response := aResponse.
	self announce: (LeGitHubModelResponseChangedAnnouncement new
		source: aSource;
		model: self)
]

{ #category : #'api - response' }
LeGitHubModel >> responseAtPath: anArray ifAbsent: anAbsentBlock [
	^ self hasResponse
		ifTrue: [ self response atPath: anArray ifAbsent: anAbsentBlock ] 
		ifFalse: anAbsentBlock
]

{ #category : #'api - accessing' }
LeGitHubModel >> responseFrom: aSource [
	<return: #LeGitHubResponse>
	response ifNil: [
		self response: self download source: aSource ].
	^ response
]

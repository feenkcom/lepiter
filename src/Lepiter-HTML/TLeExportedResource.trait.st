Trait {
	#name : #TLeExportedResource,
	#instVars : [
		'state'
	],
	#category : #'Lepiter-HTML-Model'
}

{ #category : #visiting }
TLeExportedResource >> accept: aVisitor [
	^ self acceptVisitor: aVisitor
]

{ #category : #visiting }
TLeExportedResource >> acceptVisitor: aVisitor [
	^ self explicitRequirement
]

{ #category : #'api - state' }
TLeExportedResource >> beAssemblingException: anException [
	self state: (LeExportResourceState assemblingException: anException)
]

{ #category : #'api - state' }
TLeExportedResource >> beAssemblingState [
	self state: LeExportResourceState assembling
]

{ #category : #'api - state' }
TLeExportedResource >> beProblemMessage: aMessage [
	self state: (LeExportResourceState problemMessage: aMessage)
]

{ #category : #'api - state' }
TLeExportedResource >> beReadyState [
	self state: LeExportResourceState ready
]

{ #category : #initialization }
TLeExportedResource >> defaultState [
	<return: #LeExportResourceState>
	^ self explicitRequirement
]

{ #category : #testing }
TLeExportedResource >> isAssetResource [
	^ false
]

{ #category : #accessing }
TLeExportedResource >> path [
	"Return a path of the export"

	<return: #RelativePath>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportedResource >> pathName [
	"Return a full name of the export"

	<return: #String>
	^ self path fullName
]

{ #category : #accessing }
TLeExportedResource >> source [
	"Return a source of the export"

	^ self explicitRequirement
]

{ #category : #'api - state' }
TLeExportedResource >> state [
	"Return resource state, indicating whether the resource is ready for export."

	<return: #LeExportResourceState>
	^ state ifNil: [ state := self defaultState ]
]

{ #category : #'api - state' }
TLeExportedResource >> state: aState [
	"Set resource state, indicating whether the resource is ready for export."

	self explicitRequirement
]

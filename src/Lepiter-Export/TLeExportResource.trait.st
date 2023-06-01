Trait {
	#name : #TLeExportResource,
	#instVars : [
		'state'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
TLeExportResource >> accept: aVisitor [
	^ self acceptVisitor: aVisitor
]

{ #category : #visiting }
TLeExportResource >> acceptVisitor: aVisitor [
	^ self explicitRequirement
]

{ #category : #'api - state' }
TLeExportResource >> beAssemblingException: anException [
	self state: (LeExportResourceState assemblingException: anException)
]

{ #category : #'api - state' }
TLeExportResource >> beAssemblingState [
	self state: LeExportResourceState assembling
]

{ #category : #'api - state' }
TLeExportResource >> beProblemMessage: aMessage [
	self state: (LeExportResourceState problemMessage: aMessage)
]

{ #category : #'api - state' }
TLeExportResource >> beReadyState [
	self state: LeExportResourceState ready
]

{ #category : #initialization }
TLeExportResource >> defaultState [
	<return: #LeExportResourceState>
	^ self explicitRequirement
]

{ #category : #testing }
TLeExportResource >> isAssetResource [
	^ false
]

{ #category : #accessing }
TLeExportResource >> path [
	"Return a path of the export"

	<return: #RelativePath>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportResource >> pathName [
	"Return a full name of the export"

	<return: #String>
	^ self path fullName
]

{ #category : #accessing }
TLeExportResource >> source [
	"Return a source of the export"

	^ self explicitRequirement
]

{ #category : #'api - state' }
TLeExportResource >> state [
	"Return resource state, indicating whether the resource is ready for export."

	<return: #LeExportResourceState>
	^ state ifNil: [ state := self defaultState ]
]

{ #category : #'api - state' }
TLeExportResource >> state: aState [
	"Set resource state, indicating whether the resource is ready for export."

	self explicitRequirement
]

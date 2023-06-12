Class {
	#name : #LeExportNewResourceCondition,
	#superclass : #Object,
	#traits : 'TLeExportAssembleResourceCondition',
	#classTraits : 'TLeExportAssembleResourceCondition classTrait',
	#instVars : [
		'rootDirectory'
	],
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #testing }
LeExportNewResourceCondition >> canAssemble: aResource [
	"Return true if a resource can be assembled, false otherwise."

	<return: #Boolean>
	self
		assert: [ rootDirectory isNotNil ]
		description: [ 'Root directory must be non-nil' ].

	^ aResource state isReady not
		and: [ (rootDirectory resolve: aResource path) exists not ]
]

{ #category : #accessing }
LeExportNewResourceCondition >> rootDirectory [
	^ rootDirectory
]

{ #category : #accessing }
LeExportNewResourceCondition >> rootDirectory: aDirectory [
	self
		assert: [ aDirectory isNotNil ]
		description: [ 'Directory must be non-nil' ].
	self
		assert: [ aDirectory exists ]
		description: [ 'Directory must exist: {1}' format: { aDirectory } ].
	self
		assert: [ aDirectory isDirectory ]
		description: [ 'Directory must be a directory: {1}' format: { aDirectory } ].

	rootDirectory := aDirectory
]

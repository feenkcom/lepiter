Class {
	#name : #LeHtmlAssetsInDirectoryResourceBuilder,
	#superclass : #Object,
	#instVars : [
		'resources',
		'rootDiretory'
	],
	#category : #'Lepiter-HTML-Resources - Buiders'
}

{ #category : #accessing }
LeHtmlAssetsInDirectoryResourceBuilder >> allResources [
	^ rootDiretory allFiles
		collect: [ :aFile | 
			| aResource |
			(aFile basename beginsWith: '.')
				ifFalse: [ aResource := LeHtmlFileAssetResource new
							sourceFile: aFile;
							path: (self convertFile: aFile) ]
				ifTrue: [ nil ] ]
		thenReject: #isNil
]

{ #category : #'api - building' }
LeHtmlAssetsInDirectoryResourceBuilder >> build [
	self allResources do: [ :each |
		resources addResource: each ]
]

{ #category : #private }
LeHtmlAssetsInDirectoryResourceBuilder >> convertFile: aFile [
	^ (aFile relativeTo: rootDiretory parent)
]

{ #category : #accessing }
LeHtmlAssetsInDirectoryResourceBuilder >> resources [
	^ resources
]

{ #category : #accessing }
LeHtmlAssetsInDirectoryResourceBuilder >> resources: anObject [
	resources := anObject
]

{ #category : #accessing }
LeHtmlAssetsInDirectoryResourceBuilder >> rootDiretory [
	^ rootDiretory
]

{ #category : #accessing }
LeHtmlAssetsInDirectoryResourceBuilder >> rootDiretory: aDirectory [
	self
		assert: [ aDirectory isNotNil ]
		description: [ 'Directory must be non-nil' ].
	self
		assert: [ aDirectory exists ]
		description: [ 'Directory must exist: {1}' format: { aDirectory } ].
	self
		assert: [ aDirectory isDirectory ]
		description: [ 'Directory must be a directory: {1}' format: { aDirectory } ].

	rootDiretory := aDirectory
]

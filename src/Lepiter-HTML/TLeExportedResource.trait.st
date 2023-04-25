Trait {
	#name : #TLeExportedResource,
	#category : #'Lepiter-HTML-Model'
}

{ #category : #visiting }
TLeExportedResource >> accept: aVisitor [
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
TLeExportedResource >> source [
	"Return a source of the export"

	^ self explicitRequirement
]

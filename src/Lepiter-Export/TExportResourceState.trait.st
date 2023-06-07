Trait {
	#name : #TExportResourceState,
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #accessing }
TExportResourceState >> color [
	^ Color black
]

{ #category : #testing }
TExportResourceState >> isAssembledState [
	"Return true if the resource was assembled (and therefore it nows the assembling duration)"

	^ false
]

{ #category : #testing }
TExportResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ self explicitRequirement
]

{ #category : #testing }
TExportResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ self explicitRequirement
]

{ #category : #accessing }
TExportResourceState >> label [
	^ self name asRopedText foreground: self color
]

{ #category : #accessing }
TExportResourceState >> name [
	^ self className
]

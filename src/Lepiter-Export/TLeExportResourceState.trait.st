Trait {
	#name : #TLeExportResourceState,
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #accessing }
TLeExportResourceState >> color [
	^ Color black
]

{ #category : #testing }
TLeExportResourceState >> isAssembledState [
	"Return true if the resource was assembled (and therefore it nows the assembling duration)"

	^ false
]

{ #category : #testing }
TLeExportResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ self explicitRequirement
]

{ #category : #testing }
TLeExportResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportResourceState >> label [
	^ self name asRopedText foreground: self color
]

{ #category : #accessing }
TLeExportResourceState >> name [
	^ self className
]

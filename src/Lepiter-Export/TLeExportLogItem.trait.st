Trait {
	#name : #TLeExportLogItem,
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #accessing }
TLeExportLogItem >> color [
	^ Color black
]

{ #category : #accessing }
TLeExportLogItem >> description [
	^ self explicitRequirement
]

{ #category : #testing }
TLeExportLogItem >> isProblemLog [
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportLogItem >> label [
	^ self name asRopedText foreground: self color
]

{ #category : #accessing }
TLeExportLogItem >> name [
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportLogItem >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping logs by this type."

	^ self explicitRequirement
]

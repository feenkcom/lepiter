"
A discovered preview that no renderer has requested. It is neither assembled nor saved, even if a cached output exists.
"
Class {
	#name : #LeExportOptionalResourceState,
	#superclass : #LeExportUninitializedResourceState,
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #accessing }
LeExportOptionalResourceState >> color [
	^ Color gray
]

{ #category : #accessing }
LeExportOptionalResourceState >> name [
	^ 'optional'
]

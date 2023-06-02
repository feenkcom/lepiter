Class {
	#name : #LeExportUninitializedResourceState,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance + TExportResourceState',
	#classTraits : 'TGtUniqueInstance classTrait + TExportResourceState classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Lepiter-HTML-Old-! New - Model - Resource State'
}

{ #category : #accessing }
LeExportUninitializedResourceState >> color [
	^ BrGlamorousColors failureBackgroundColor
]

{ #category : #testing }
LeExportUninitializedResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ false
]

{ #category : #testing }
LeExportUninitializedResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ false
]

{ #category : #accessing }
LeExportUninitializedResourceState >> name [
	^ 'uninitialized'
]

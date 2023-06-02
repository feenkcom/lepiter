Class {
	#name : #LeExportReadyResourceState,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance + TExportResourceState',
	#classTraits : 'TGtUniqueInstance classTrait + TExportResourceState classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Lepiter-HTML-Old-! New - Model - Resource State'
}

{ #category : #accessing }
LeExportReadyResourceState >> color [
	^ BrGlamorousColors successBackgroundColor
]

{ #category : #testing }
LeExportReadyResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ false
]

{ #category : #testing }
LeExportReadyResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ true
]

{ #category : #accessing }
LeExportReadyResourceState >> name [
	^ 'ready'
]

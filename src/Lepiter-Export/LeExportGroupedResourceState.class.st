Class {
	#name : #LeExportGroupedResourceState,
	#superclass : #Object,
	#traits : 'TLeExportResourceState',
	#classTraits : 'TLeExportResourceState classTrait',
	#instVars : [
		'states',
		'name',
		'label'
	],
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #accessing }
LeExportGroupedResourceState >> color [
	states ifEmpty: [ ^ Color black ].
	
	(states allSatisfy: #isReady) ifTrue: [
		^ BrGlamorousColors successBackgroundColor ].
	
	(states anySatisfy: #isFailure) ifTrue: [
		^ BrGlamorousColors errorBackgroundColor ].
		
	^ Color black
]

{ #category : #testing }
LeExportGroupedResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	states ifEmpty: [ ^ false ].

	states anySatisfy: #isFailure
]

{ #category : #testing }
LeExportGroupedResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	states ifEmpty: [ ^ true ].

	^ states allSatisfy: #isReady
]

{ #category : #accessing }
LeExportGroupedResourceState >> label [
	^ label
]

{ #category : #accessing }
LeExportGroupedResourceState >> label: anObject [
	label := anObject
]

{ #category : #accessing }
LeExportGroupedResourceState >> name [
	^ name
]

{ #category : #accessing }
LeExportGroupedResourceState >> name: anObject [
	name := anObject
]

{ #category : #accessing }
LeExportGroupedResourceState >> states [
	^ states
]

{ #category : #accessing }
LeExportGroupedResourceState >> states: anObject [
	states := anObject
]

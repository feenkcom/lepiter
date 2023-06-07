Class {
	#name : #LeExportGroupedResourceChild,
	#superclass : #Object,
	#instVars : [
		'resource'
	],
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #accessing }
LeExportGroupedResourceChild >> children [
	^ #()
]

{ #category : #accessing }
LeExportGroupedResourceChild >> object [
	^ resource
]

{ #category : #accessing }
LeExportGroupedResourceChild >> pathName [
	^ resource pathName
]

{ #category : #accessing }
LeExportGroupedResourceChild >> resource [
	^ resource
]

{ #category : #accessing }
LeExportGroupedResourceChild >> resource: anObject [
	resource := anObject
]

{ #category : #accessing }
LeExportGroupedResourceChild >> source [
	^ resource source
]

{ #category : #accessing }
LeExportGroupedResourceChild >> state [
	^ resource state
]

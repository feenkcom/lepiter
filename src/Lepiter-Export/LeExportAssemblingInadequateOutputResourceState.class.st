Class {
	#name : #LeExportAssemblingInadequateOutputResourceState,
	#superclass : #Object,
	#traits : 'TExportResourceState',
	#classTraits : 'TExportResourceState classTrait',
	#instVars : [
		'exception'
	],
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #accessing }
LeExportAssemblingInadequateOutputResourceState >> color [
	^ BrGlamorousColors failureBackgroundColor
]

{ #category : #accessing }
LeExportAssemblingInadequateOutputResourceState >> exception [
	^ exception
]

{ #category : #accessing }
LeExportAssemblingInadequateOutputResourceState >> exception: anObject [
	exception := anObject
]

{ #category : #testing }
LeExportAssemblingInadequateOutputResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ true
]

{ #category : #testing }
LeExportAssemblingInadequateOutputResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ true
]

{ #category : #accessing }
LeExportAssemblingInadequateOutputResourceState >> name [
	^ 'inadequate output ({1})' format: {exception}
]

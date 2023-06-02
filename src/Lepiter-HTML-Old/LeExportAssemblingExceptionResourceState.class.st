Class {
	#name : #LeExportAssemblingExceptionResourceState,
	#superclass : #Object,
	#traits : 'TExportResourceState',
	#classTraits : 'TExportResourceState classTrait',
	#instVars : [
		'exception'
	],
	#category : #'Lepiter-HTML-Old-! New - Model - Resource State'
}

{ #category : #accessing }
LeExportAssemblingExceptionResourceState >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeExportAssemblingExceptionResourceState >> exception [
	^ exception
]

{ #category : #accessing }
LeExportAssemblingExceptionResourceState >> exception: anObject [
	exception := anObject
]

{ #category : #testing }
LeExportAssemblingExceptionResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ true
]

{ #category : #testing }
LeExportAssemblingExceptionResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ false
]

{ #category : #accessing }
LeExportAssemblingExceptionResourceState >> name [
	^ 'assembling problem ({1})' format: {exception}
]

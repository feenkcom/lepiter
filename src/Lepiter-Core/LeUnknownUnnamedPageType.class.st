Class {
	#name : #LeUnknownUnnamedPageType,
	#superclass : #LeUnnamedPageType,
	#traits : 'TLeUnknownPageType',
	#classTraits : 'TLeUnknownPageType classTrait',
	#category : #'Lepiter-Core-Model'
}

{ #category : #initialization }
LeUnknownUnnamedPageType class >> initialize [
	super initialize
]

{ #category : #accesing }
LeUnknownUnnamedPageType class >> leJsonV4Name [

	^ 'unknownUnnamedCustomPage'
]

{ #category : #printing }
LeUnknownUnnamedPageType class >> niceClassName [
	^ 'Unknown Unnamed Custom Page'
]

{ #category : #ui }
LeUnknownUnnamedPageType >> asPreviewElement [
	^ self defaultPhlowTool asElement
]

{ #category : #printing }
LeUnknownUnnamedPageType >> printOn: aStream [
	aStream nextPutAll: 'Unknown Unnamed Custom Page'
]

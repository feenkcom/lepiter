Class {
	#name : #LeUnknownNamedPageType,
	#superclass : #LeNamedPageType,
	#traits : 'TLeUnknownPageType',
	#classTraits : 'TLeUnknownPageType classTrait',
	#category : #'Lepiter-Core-Model'
}

{ #category : #initialization }
LeUnknownNamedPageType class >> initialize [
	super initialize
]

{ #category : #accesing }
LeUnknownNamedPageType class >> leJsonV4Name [

	^ 'unknownNamedCustomPage'
]

{ #category : #printing }
LeUnknownNamedPageType class >> niceClassName [
	^ 'Unknown Named Custom Page'
]

{ #category : #ui }
LeUnknownNamedPageType >> asPreviewElement [
	^ self defaultPhlowTool asElement
]

{ #category : #printing }
LeUnknownNamedPageType >> printOn: aStream [

	aStream 
		nextPutAll: 'Unknown Named Custom Page: ';
		print: title
]

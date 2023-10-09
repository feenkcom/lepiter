Class {
	#name : #LeExportBookPageLink,
	#superclass : #Object,
	#traits : 'TLeExportBookPageLink',
	#classTraits : 'TLeExportBookPageLink classTrait',
	#instVars : [
		'fileName',
		'id',
		'page',
		'fileExtension'
	],
	#category : #'Lepiter-Export-Page Links - Model'
}

{ #category : #accessing }
LeExportBookPageLink >> fileExtension [
	^ fileExtension
]

{ #category : #accessing }
LeExportBookPageLink >> fileExtension: aString [
	fileExtension := aString
]

{ #category : #accessing }
LeExportBookPageLink >> fileName [
	<return: #String>
	^ fileName
]

{ #category : #accessing }
LeExportBookPageLink >> fileName: aString [
	fileName := aString
]

{ #category : #accessing }
LeExportBookPageLink >> fileNameWithExtension [
	^ fileExtension
		ifNil: [ fileName ]
		ifNotNil: [ fileName , '.' , fileExtension ]
]

{ #category : #accessing }
LeExportBookPageLink >> id [
	^ id
]

{ #category : #accessing }
LeExportBookPageLink >> id: anObject [
	id := anObject
]

{ #category : #accessing }
LeExportBookPageLink >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeExportBookPageLink >> page: aLePage [
	page := aLePage
]

{ #category : #printing }
LeExportBookPageLink >> printOn: aStream [
	super printOn: aStream.

	self page ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self pageTitle asString;
		nextPut: $)
]

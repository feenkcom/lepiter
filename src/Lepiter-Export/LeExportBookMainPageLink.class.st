Class {
	#name : #LeExportBookMainPageLink,
	#superclass : #Object,
	#traits : 'TLeExportBookPageLink',
	#classTraits : 'TLeExportBookPageLink classTrait',
	#instVars : [
		'page',
		'fileName',
		'fileExtension'
	],
	#category : #'Lepiter-Export-Page Links - Model'
}

{ #category : #accessing }
LeExportBookMainPageLink >> fileExtension [
	^ fileExtension
]

{ #category : #accessing }
LeExportBookMainPageLink >> fileExtension: anObject [
	fileExtension := anObject
]

{ #category : #accessing }
LeExportBookMainPageLink >> fileName [
	<return: #String>
	^ fileName
]

{ #category : #accessing }
LeExportBookMainPageLink >> fileName: aString [
	fileName := aString
]

{ #category : #accessing }
LeExportBookMainPageLink >> fileNameWithExtension [
	<return: #String>
	^ fileExtension
		ifNil: [ fileName ]
		ifNotNil: [ fileName , '.' , fileExtension ]
]

{ #category : #testing }
LeExportBookMainPageLink >> isMainPage [
	^ true
]

{ #category : #accessing }
LeExportBookMainPageLink >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeExportBookMainPageLink >> page: aLePage [
	page := aLePage
]

{ #category : #printing }
LeExportBookMainPageLink >> printOn: aStream [
	super printOn: aStream.

	self page ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self pageTitle asString;
		nextPut: $)
]

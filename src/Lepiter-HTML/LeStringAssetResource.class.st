Class {
	#name : #LeStringAssetResource,
	#superclass : #Object,
	#traits : 'TLeExportedResource',
	#classTraits : 'TLeExportedResource classTrait',
	#instVars : [
		'content',
		'remoteUrl',
		'localName'
	],
	#category : #'Lepiter-HTML-Model'
}

{ #category : #visiting }
LeStringAssetResource >> accept: aVisitor [
	^ aVisitor visitStringAssetResource: self
]

{ #category : #accessing }
LeStringAssetResource >> content [
	<return: #String>
	^ content
]

{ #category : #accessing }
LeStringAssetResource >> content: aString [
	content := aString
]

{ #category : #testing }
LeStringAssetResource >> isAssetResource [
	^ true
]

{ #category : #accessing }
LeStringAssetResource >> localName [
	^ localName
]

{ #category : #accessing }
LeStringAssetResource >> localName: anObject [
	localName := anObject
]

{ #category : #accessing }
LeStringAssetResource >> path [
	"Return a path of the export"

	<return: #RelativePath>
	^ Path * self localName
]

{ #category : #accessing }
LeStringAssetResource >> remoteUrl [
	<return: #ZnUrl>
	^ remoteUrl
]

{ #category : #accessing }
LeStringAssetResource >> remoteUrl: aZnUrl [
	remoteUrl := aZnUrl
]

{ #category : #accessing }
LeStringAssetResource >> source [
	"Return a source of the export"

	^ self remoteUrl
]

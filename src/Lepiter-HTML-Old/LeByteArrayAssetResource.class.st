Class {
	#name : #LeByteArrayAssetResource,
	#superclass : #Object,
	#traits : 'TLeExportResource',
	#classTraits : 'TLeExportResource classTrait',
	#instVars : [
		'remoteUrl',
		'localName',
		'bytes'
	],
	#category : #'Lepiter-HTML-Old-Model'
}

{ #category : #visiting }
LeByteArrayAssetResource >> accept: aVisitor [
	^ aVisitor visitByteArrayAssetResource: self
]

{ #category : #accessing }
LeByteArrayAssetResource >> bytes [
	<return: #ByteArray>
	^ bytes
]

{ #category : #accessing }
LeByteArrayAssetResource >> bytes: aByteArray [
	bytes := aByteArray
]

{ #category : #testing }
LeByteArrayAssetResource >> isAssetResource [
	^ true
]

{ #category : #accessing }
LeByteArrayAssetResource >> localName [
	^ localName
]

{ #category : #accessing }
LeByteArrayAssetResource >> localName: anObject [
	localName := anObject
]

{ #category : #accessing }
LeByteArrayAssetResource >> path [
	"Return a path of the export"

	<return: #RelativePath>
	^ Path * self localName
]

{ #category : #accessing }
LeByteArrayAssetResource >> remoteUrl [
	^ remoteUrl
]

{ #category : #accessing }
LeByteArrayAssetResource >> remoteUrl: anObject [
	remoteUrl := anObject
]

{ #category : #accessing }
LeByteArrayAssetResource >> source [
	"Return a source of the export"

	^ self remoteUrl
]

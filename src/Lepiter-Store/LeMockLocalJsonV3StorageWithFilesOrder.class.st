Class {
	#name : #LeMockLocalJsonV3StorageWithFilesOrder,
	#superclass : #LeLocalJsonV3Storage,
	#category : 'Lepiter-Store-Mocks'
}

{ #category : #enumerating }
LeMockLocalJsonV3StorageWithFilesOrder >> dbFilesIn: aDirectory [
	^ (super dbFilesIn: aDirectory) sorted: [ :aFile :anotherFile |
		aFile basename < anotherFile basename ]
]

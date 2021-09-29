Class {
	#name : #LeLocalSTONStorage,
	#superclass : #LeLocalStorage,
	#category : 'Lepiter-Store-LocalJSON-Store'
}

{ #category : #loading }
LeLocalSTONStorage >> loadFromFile: aFileReference [

	^ aFileReference readStreamDo: [ :stream |
			STON fromStream: stream ]
]

{ #category : #accessing }
LeLocalSTONStorage >> pageFilename: aPage [

	^ self titleFilename: aPage title
]

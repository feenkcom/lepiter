Class {
	#name : #LeTweetMedia,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'Lepiter-Core-Twitter'
}

{ #category : #'api - raw data' }
LeTweetMedia >> end [
	^ self rawData at: 'end'
]

{ #category : #accessing }
LeTweetMedia >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 10;
		stencil: [
			BrAsyncFileWidget new
				url: (self url asZnUrl & ('format' -> 'jpg')) asString;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ] ]
		
]

{ #category : #'gt-extensions' }
LeTweetMedia >> gtRawDataFor: aView [
	<gtView>
	self hasRawData ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Raw data';
		priority: 25;
		object: [ self rawData ];
		view: #gtItemsFor:
]

{ #category : #'api - testing' }
LeTweetMedia >> hasRawData [
	<return: #Boolean>
	^ self rawData isNotNil
]

{ #category : #'api - item testing' }
LeTweetMedia >> isPhoto [
	^ self type = 'photo'
]

{ #category : #'api - item accessing' }
LeTweetMedia >> mediaKey [
	^ self rawData at: 'media_key'
]

{ #category : #printing }
LeTweetMedia >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self type asString;
		space;
		nextPutAll: self url;
		nextPut: $)
]

{ #category : #'api - raw data' }
LeTweetMedia >> rawData [
	^ rawData
]

{ #category : #'api - raw data' }
LeTweetMedia >> rawData: anObject [
	rawData := anObject
]

{ #category : #'api - raw data' }
LeTweetMedia >> start [
	^ self rawData at: 'start' 
]

{ #category : #'api - item accessing' }
LeTweetMedia >> type [
	^ self rawData at: 'type'
]

{ #category : #'api - item accessing' }
LeTweetMedia >> url [
	^ self rawData at: 'url' ifAbsent: [ self rawData at: 'preview_url' ifAbsent: [self rawData at: 'preview_image_url']]
]

Class {
	#name : #LeHeadingStyle,
	#superclass : #LeParagraphStyle,
	#instVars : [
		'level'
	],
	#category : 'Lepiter-Core-Model'
}

{ #category : #comparing }
LeHeadingStyle >> = anObject [

	^ self class = anObject class and:
		[ self level = anObject level ]
]

{ #category : #'private - asserting' }
LeHeadingStyle >> assertLevel: anInteger [
	self 
		assert: [ anInteger isNotNil ]
		description: [ 'Heading level must be non-nil' ].
	self 
		assert: [ anInteger isInteger ]
		description: [ 'Heading level must be an integer' ].
	
]

{ #category : #comparing }
LeHeadingStyle >> hash [ 

	^ self class hash bitXor: level hash
]

{ #category : #'api - accessing' }
LeHeadingStyle >> level [
	^ level ifNil: 0
]

{ #category : #'api - accessing' }
LeHeadingStyle >> level: anInteger [
	self assertLevel: anInteger.
	level := anInteger
]

{ #category : #accessing }
LeHeadingStyle >> printOn: aStream [
	aStream 
		nextPutAll: 'Heading ';
		print: self level;
		nextPutAll: ' Style'
]

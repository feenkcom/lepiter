Class {
	#name : #LeTime,
	#superclass : #LeModel,
	#instVars : [
		'time'
	],
	#category : 'Lepiter-Core-Model'
}

{ #category : #accessing }
LeTime class >> now [ 

	^ self new 
		time: DateAndTime now;
		yourself.
]

{ #category : #comparing }
LeTime >> < aTime [
	^ self class = aTime class and: [ 
		self time < aTime time ]
]

{ #category : #comparing }
LeTime >> <= aTime [
	^ (self > aTime) not
]

{ #category : #comparing }
LeTime >> = aTime [
	^ self class = aTime class and: [ 
		self time = aTime time ]
]

{ #category : #comparing }
LeTime >> > aTime [
	^ aTime < self
]

{ #category : #comparing }
LeTime >> >= aTime [
	^ aTime <= self
]

{ #category : #'api - accessing' }
LeTime >> asDate [
	<return: #Date>
	^ self time asDate
]

{ #category : #'private - asserting' }
LeTime >> assertTime: aDateAndTime [
	self 
		assert: [ aDateAndTime isNotNil ] 
		description: [ 'Date and time must be non-nil' ].
]

{ #category : #comparing }
LeTime >> hash [
	^ self class hash bitXor: self time hash
]

{ #category : #comparing }
LeTime >> max: aLeTime [

	^ (self > aLeTime)
		ifTrue: [ self ]
		ifFalse: [ aLeTime ]
]

{ #category : #printing }
LeTime >> printOn: aStream [
	self time ifNil: [ ^ super printOn: aStream ].
	self time printSeparateDateAndTimeOn: aStream.
]

{ #category : #'api - accessing' }
LeTime >> time [
	<return: #DateAndTime>
	^ time
]

{ #category : #'api - accessing' }
LeTime >> time: aDateAndTime [
	self assertTime: aDateAndTime.
	time := aDateAndTime
]

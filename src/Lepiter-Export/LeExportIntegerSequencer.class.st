Class {
	#name : #LeExportIntegerSequencer,
	#superclass : #Object,
	#traits : 'TLeExportSequencer',
	#classTraits : 'TLeExportSequencer classTrait',
	#instVars : [
		'counter'
	],
	#category : #'Lepiter-Export-Sequencers'
}

{ #category : #constants }
LeExportIntegerSequencer class >> initialCounterValue [
	"The first used value will be 1000"

	^ 999
]

{ #category : #'gt - extensions' }
LeExportIntegerSequencer >> gtNextIdsFor: aView [
	<gtView>
	counter ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Next IDs';
		items: [ | aCopy |
			aCopy := self copy.
			12 timesCollect: [ aCopy nextId ] ];
		column: 'Next ID' text: #yourself
]

{ #category : #initialization }
LeExportIntegerSequencer >> initialize [
	super initialize.
	counter := self class initialCounterValue
]

{ #category : #accessing }
LeExportIntegerSequencer >> nextId [
	<return: #String>
	counter := counter + 1.
	^ counter asString
]

{ #category : #printing }
LeExportIntegerSequencer >> printOn: aStream [
	super printOn: aStream.

	counter ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: 'next number is ';
		print: counter + 1;
		nextPut: $)
]

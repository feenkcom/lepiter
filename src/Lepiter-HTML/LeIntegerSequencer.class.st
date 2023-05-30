Class {
	#name : #LeIntegerSequencer,
	#superclass : #Object,
	#traits : 'TLeSequencer',
	#classTraits : 'TLeSequencer classTrait',
	#instVars : [
		'counter'
	],
	#category : #'Lepiter-HTML-! New - Support'
}

{ #category : #constants }
LeIntegerSequencer class >> initialCounterValue [
	"The first used value will be 1000"

	^ 999
]

{ #category : #'gt - extensions' }
LeIntegerSequencer >> gtNextIdsFor: aView [
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
LeIntegerSequencer >> initialize [
	super initialize.
	counter := self class initialCounterValue
]

{ #category : #accessing }
LeIntegerSequencer >> nextId [
	<return: #String>
	counter := counter + 1.
	^ counter asString
]

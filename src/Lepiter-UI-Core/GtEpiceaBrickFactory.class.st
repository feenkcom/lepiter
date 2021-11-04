Class {
	#name : #GtEpiceaBrickFactory,
	#superclass : #Object,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'Lepiter-UI-Core-Epicea'
}

{ #category : #accessing }
GtEpiceaBrickFactory class >> default [
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #strings }
GtEpiceaBrickFactory >> emphasizedStringFor: aString [
	
	^ self stringFor: (aString asRopedText bold; glamorousRegularFont)
]

{ #category : #colors }
GtEpiceaBrickFactory >> softerTextColor [

	^ self textColor mixed: 0.1 with: Color gray
]

{ #category : #strings }
GtEpiceaBrickFactory >> stringFor: aString [

	^ BlTextElement new 
		text: aString asRopedText glamorousRegularFont;
		padding: (BlInsets top: 0 left: 0 bottom: 0 right: 3);
		constraintsDo: [ :c | 
			c linear vertical alignCenter ]
]

{ #category : #strings }
GtEpiceaBrickFactory >> stringFor: aString color: aColor [

	^ self stringFor: (aString asRopedText foreground: aColor; glamorousRegularFont)
]

{ #category : #colors }
GtEpiceaBrickFactory >> textColor [

	^ Smalltalk ui theme textColor
]

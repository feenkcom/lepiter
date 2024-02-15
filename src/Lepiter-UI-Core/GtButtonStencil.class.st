Class {
	#name : #GtButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'action',
		'label',
		'iconStencilBuilder',
		'tooltip'
	],
	#category : #'Lepiter-UI-Core-Brick - Stencils'
}

{ #category : #accessing }
GtButtonStencil >> action [
	^ action
]

{ #category : #accessing }
GtButtonStencil >> action: aValuable [
	action := aValuable
]

{ #category : #'api - instantiation' }
GtButtonStencil >> create [
	| aLook |
	aLook := BrGlamorousButtonWithIconAptitude.
	self hasLabel ifTrue: [ aLook := aLook + BrGlamorousButtonLabelAptitude ].

	^ BrButton new
		aptitude: aLook;
		beSmallSize;
		icon: self icon;
		label: (self label ifNil: [ self tooltip ]);
		action: self action
]

{ #category : #testing }
GtButtonStencil >> hasLabel [
	^ self label notNil and: [ self label isEmpty not ]
]

{ #category : #accessing }
GtButtonStencil >> icon [
	<return: #BlElement>

	^ iconStencilBuilder asElement
]

{ #category : #accessing }
GtButtonStencil >> icon: aStencilBuilder [
	iconStencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #initialization }
GtButtonStencil >> initialize [
	super initialize.

	self icon: BrGlamorousVectorIcons playinspect.
"	self label: 'Run'."
	self action: [ :aWidget :aButtonModel | self inform: 'Executed' ]
]

{ #category : #accessing }
GtButtonStencil >> label [
	^ label
]

{ #category : #accessing }
GtButtonStencil >> label: aStringOrText [
	label := aStringOrText
]

{ #category : #accessing }
GtButtonStencil >> tooltip [
	^ tooltip
]

{ #category : #accessing }
GtButtonStencil >> tooltip: anObject [
	tooltip := anObject
]

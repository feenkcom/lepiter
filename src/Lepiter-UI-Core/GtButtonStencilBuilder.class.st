Class {
	#name : #GtButtonStencilBuilder,
	#superclass : #BrTextAdornmentStencilBuilder,
	#instVars : [
		'label',
		'icon',
		'action'
	],
	#category : #'Lepiter-UI-Core-Brick - Stencils'
}

{ #category : #accessing }
GtButtonStencilBuilder class >> stencilProperties [
	^ #(action icon label)
]

{ #category : #accessing }
GtButtonStencilBuilder >> action [
	^ action
]

{ #category : #accessing }
GtButtonStencilBuilder >> action: anObject [
	action := anObject
]

{ #category : #'api - instantiation' }
GtButtonStencilBuilder >> buildDefault [
	^ GtButtonStencil new
		label: self label;
		icon: self icon;
		action: self action
]

{ #category : #accessing }
GtButtonStencilBuilder >> icon [
	^ icon
]

{ #category : #accessing }
GtButtonStencilBuilder >> icon: anObject [
	icon := anObject
]

{ #category : #initialization }
GtButtonStencilBuilder >> initialize [
	super initialize.
	label := 'Button'.
	icon := BrGlamorousVectorIcons play.
	action := [ :aWidget :aButtonModel | self inform: 'Action!' ]
]

{ #category : #accessing }
GtButtonStencilBuilder >> label [
	^ label
]

{ #category : #accessing }
GtButtonStencilBuilder >> label: anObject [
	label := anObject
]

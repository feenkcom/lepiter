Class {
	#name : #BrGlamorousSlideExteriorAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#instVars : [
		'backgroundPaint',
		'borderWidth',
		'borderPaint'
	],
	#category : #'Lepiter-UI-Core-Brick - Looks'
}

{ #category : #accessing }
BrGlamorousSlideExteriorAptitude >> backgroundPaint [
	^ backgroundPaint ifNil: [ self theme button defaultBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousSlideExteriorAptitude >> backgroundPaint: aPaint [
	backgroundPaint := aPaint
]

{ #category : #accessing }
BrGlamorousSlideExteriorAptitude >> borderPaint [
	^ borderPaint ifNil: [ self theme button defaultBorderColor ]
]

{ #category : #accessing }
BrGlamorousSlideExteriorAptitude >> borderPaint: aColor [
	borderPaint := aColor
]

{ #category : #accessing }
BrGlamorousSlideExteriorAptitude >> borderWidth [
	^ borderWidth ifNil: [ 1 ]
]

{ #category : #accessing }
BrGlamorousSlideExteriorAptitude >> borderWidth: anInteger [
	borderWidth := anInteger
]

{ #category : #initialization }
BrGlamorousSlideExteriorAptitude >> initialize [
	super initialize.

	self default: [ :aStyle |
		aStyle
			background: self backgroundPaint;
			border: (BlBorder paint: self borderPaint width: self borderWidth) ].

	self focused: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: self theme button hoveredBorderColor
				width: self borderWidth) ].
	
	self hovered: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: self theme button fadedBackgroundColor darker
				width: self borderWidth) ].

	self pressed: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: self theme button pressedBorderColor
				width: self borderWidth) ].

	self disabled: [ :aSyle |
		aSyle
			background: self theme button disabledBackgroundColor;
			border:
				(BlBorder
					paint: self theme button disabledBorderColor
					width: self borderWidth) ]
]

Class {
	#name : #GtCachedTextExpandButtonAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'onCachingAction'
	],
	#category : #'Lepiter-UI-Core-Text - Attributes'
}

{ #category : #initialization }
GtCachedTextExpandButtonAttribute >> initialize [
	super initialize.
	onCachingAction := [ :aBoolean :theAttribute | "do nothing" ].
]

{ #category : #accessing }
GtCachedTextExpandButtonAttribute >> isExpanded: aBoolean [
	super isExpanded: aBoolean.
	onCachingAction gtValueWithArgs: { aBoolean. self }
]

{ #category : #accessing }
GtCachedTextExpandButtonAttribute >> onCachingDo: aBlock [
	self 
		assert: [ aBlock notNil ]
		description: [ 'On caching block must be non-nil' ].
	onCachingAction := aBlock
]

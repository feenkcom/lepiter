Class {
	#name : #GtEpiceaDiffBuilder,
	#superclass : #TextDiffBuilder,
	#instVars : [
		'isMethod'
	],
	#category : #'Lepiter-UI-Core-Epicea'
}

{ #category : #initialization }
GtEpiceaDiffBuilder >> initialize [
	super initialize.
	isMethod := true
]

{ #category : #accessing }
GtEpiceaDiffBuilder >> isMethod [
	^ isMethod
]

{ #category : #accessing }
GtEpiceaDiffBuilder >> isMethod: aBoolean [
	isMethod := aBoolean
]

{ #category : #'instance creation' }
GtEpiceaDiffBuilder >> newStyler [
	^ GtEpiceaRBTextStyler new
		isForWorkspace: isMethod not;
		yourself
]

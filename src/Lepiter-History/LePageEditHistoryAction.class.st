Class {
	#name : #LePageEditHistoryAction,
	#superclass : #Object,
	#instVars : [
		'pageHistory',
		'editEvent'
	],
	#category : #'Lepiter-History-Storage'
}

{ #category : #actions }
LePageEditHistoryAction >> applyOn: aPage [
	self subclassResponsibility
]

{ #category : #accessing }
LePageEditHistoryAction >> editEvent [

	^ editEvent
]

{ #category : #accessing }
LePageEditHistoryAction >> editEvent: anObject [

	editEvent := anObject
]

{ #category : #accessing }
LePageEditHistoryAction >> eventDescriptionText [
	^ self editEvent mainCommandLabel gtDisplayText
]

{ #category : #accessing }
LePageEditHistoryAction >> label [
	self subclassResponsibility
]

{ #category : #accessing }
LePageEditHistoryAction >> labelText [
	^ self label gtDisplayText
]

{ #category : #accessing }
LePageEditHistoryAction >> pageHistory [

	^ pageHistory
]

{ #category : #accessing }
LePageEditHistoryAction >> pageHistory: aPageHistory [

	pageHistory := aPageHistory
]

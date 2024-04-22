Class {
	#name : #LeBindingNameUpdater,
	#superclass : #Object,
	#instVars : [
		'oldName',
		'newName',
		'newValue',
		'bindings',
		'onSuccess'
	],
	#category : #'Lepiter-UI-Snippet-Support'
}

{ #category : #accessing }
LeBindingNameUpdater >> bindings [
	^ bindings
]

{ #category : #accessing }
LeBindingNameUpdater >> bindings: anObject [
	bindings := anObject
]

{ #category : #initialization }
LeBindingNameUpdater >> initialize [
	super initialize.
	onSuccess := [ nil ]
]

{ #category : #accessing }
LeBindingNameUpdater >> newName [
	^ newName
]

{ #category : #accessing }
LeBindingNameUpdater >> newName: aString [
	newName := aString
]

{ #category : #accessing }
LeBindingNameUpdater >> newValue [
	^ newValue
]

{ #category : #accessing }
LeBindingNameUpdater >> newValue: anObject [
	newValue := anObject
]

{ #category : #accessing }
LeBindingNameUpdater >> oldName [
	^ oldName
]

{ #category : #accessing }
LeBindingNameUpdater >> oldName: aString [
	oldName := aString
]

{ #category : #accessing }
LeBindingNameUpdater >> onSuccess [
	^ onSuccess
]

{ #category : #accessing }
LeBindingNameUpdater >> onSuccess: aValuable [
	onSuccess := aValuable
]

{ #category : #updating }
LeBindingNameUpdater >> update [
	self oldName ifNil: [ ^ self ].
	self oldName ifEmpty: [ ^ self ].
	self newName ifNil: [ ^ self ].
	self newName ifEmpty: [ ^ self ].

	self bindings removeBindingOf: self oldName.
	(self bindings bindingOf: self newName) value: self newValue.
	self onSuccess value
]

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

{ #category : #testing }
LeBindingNameUpdater >> hasNewName [
	^ self newName isNotNil and: [ self newName isNotEmpty ]
]

{ #category : #testing }
LeBindingNameUpdater >> hasOldName [
	^ self oldName isNotNil and: [ self oldName isNotEmpty ]
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
	self hasOldName ifTrue: [ self bindings removeBindingOf: self oldName ].

	self hasNewName ifFalse: [ ^ self ].
	(self bindings bindingOf: self newName) value: self newValue.
	self onSuccess value
]

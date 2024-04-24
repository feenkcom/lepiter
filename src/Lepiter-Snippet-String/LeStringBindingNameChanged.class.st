Class {
	#name : #LeStringBindingNameChanged,
	#superclass : #Announcement,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #accessing }
LeStringBindingNameChanged >> newName [
	^ newName
]

{ #category : #accessing }
LeStringBindingNameChanged >> newName: anObject [
	newName := anObject
]

{ #category : #accessing }
LeStringBindingNameChanged >> oldName [
	^ oldName
]

{ #category : #accessing }
LeStringBindingNameChanged >> oldName: anObject [
	oldName := anObject
]

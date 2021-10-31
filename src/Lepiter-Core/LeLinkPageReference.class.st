Class {
	#name : #LeLinkPageReference,
	#superclass : #LeLinkContentReference,
	#category : 'Lepiter-Core-Links'
}

{ #category : #'instance creation' }
LeLinkPageReference class >> forPage: aLePage [
	^ self forContent: aLePage
]

{ #category : #testing }
LeLinkPageReference >> isPageReference [
	^ true
]

{ #category : #accessing }
LeLinkPageReference >> page [
	^ self content
]

{ #category : #printing }
LeLinkPageReference >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(';
		print: self description;
		nextPutAll: ')'
]

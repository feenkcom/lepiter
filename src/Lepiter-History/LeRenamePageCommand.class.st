Class {
	#name : #LeRenamePageCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'newTitle'
	],
	#category : #'Lepiter-History'
}

{ #category : #accessing }
LeRenamePageCommand class >> commandDescription [ 
	^ 'Page Renamed'
]

{ #category : #'instance creation' }
LeRenamePageCommand class >> forPage: aPage [
	^ self new
		initializeForPage: aPage
]

{ #category : #printing }
LeRenamePageCommand >> descriptionOn: aStream [
	aStream 
		<< 'pageUid: ';
		print: self targetPageUid;
		<< ', newTitle: ';
		print: self newTitle
]

{ #category : #initialization }
LeRenamePageCommand >> initializeForPage: aPage [
	
	self newTitle: aPage title
]

{ #category : #accessing }
LeRenamePageCommand >> newTitle [

	^ newTitle
]

{ #category : #accessing }
LeRenamePageCommand >> newTitle: aPageTitle [

	newTitle := aPageTitle
]

{ #category : #printing }
LeRenamePageCommand >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize:  [ 
		aStream print: self newTitle ]
]

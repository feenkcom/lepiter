Class {
	#name : #LePageRenameCommand,
	#superclass : #LePageEditCommand,
	#instVars : [
		'newTitle'
	],
	#category : #'Lepiter-History'
}

{ #category : #accessing }
LePageRenameCommand class >> commandDescription [ 
	^ 'Page Renamed'
]

{ #category : #'instance creation' }
LePageRenameCommand class >> forPage: aPage [
	^ self new
		initializeForPage: aPage
]

{ #category : #printing }
LePageRenameCommand >> descriptionOn: aStream [
	aStream 
		<< 'pageUid: ';
		print: self targetPageUid;
		<< ', newTitle: ';
		print: self newTitle
]

{ #category : #initialization }
LePageRenameCommand >> initializeForPage: aPage [
	self targetPageUid: aPage uid.
	self newTitle: aPage title
]

{ #category : #accessing }
LePageRenameCommand >> newTitle [

	^ newTitle
]

{ #category : #accessing }
LePageRenameCommand >> newTitle: aPageTitle [

	newTitle := aPageTitle
]

{ #category : #printing }
LePageRenameCommand >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize:  [ 
		aStream print: self newTitle ]
]

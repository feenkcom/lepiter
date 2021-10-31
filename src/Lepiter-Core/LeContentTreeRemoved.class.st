"
LeContentTreeAdded is used to announce that content has been removed from a page.


"
Class {
	#name : #LeContentTreeRemoved,
	#superclass : #LeContentTreeChanged,
	#instVars : [
		'page',
		'database'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeContentTreeRemoved >> database [
	^ database
]

{ #category : #accessing }
LeContentTreeRemoved >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeContentTreeRemoved >> page [
	^ page
]

{ #category : #accessing }
LeContentTreeRemoved >> page: anObject [
	page := anObject
]

Class {
	#name : #LePageBuilder,
	#superclass : #LeContentBuilder,
	#category : 'Lepiter-Core-Builders'
}

{ #category : #'api - building' }
LePageBuilder >> build [
	<return: #LePage>
	^ self page
]

{ #category : #defaults }
LePageBuilder >> defaultContent [
	^ LePage named: ''.
]

{ #category : #'api - configuration' }
LePageBuilder >> noteOf: aDate [
	| aTitle |
	aTitle := LeDailyNoteTitleBuilder new title: aDate asDate.
	self title: aTitle.
]

{ #category : #'private - accessing' }
LePageBuilder >> page [
	<return: #LePage>
	^ content
]

{ #category : #'api - configuration' }
LePageBuilder >> title: aTitle [
	self page title: aTitle
]

{ #category : #'api - configuration' }
LePageBuilder >> todayNote [
	| aTitle |
	aTitle := LeDailyNoteTitleBuilder new title: Date today.
	self title: aTitle.
]

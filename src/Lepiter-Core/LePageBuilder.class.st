Class {
	#name : #LePageBuilder,
	#superclass : #LeContentBuilder,
	#category : #'Lepiter-Core-Builders'
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

{ #category : #'private - accessing' }
LePageBuilder >> page [
	<return: #LePage>
	^ content
]

{ #category : #'api - configuration' }
LePageBuilder >> title: aTitle [
	self page title: aTitle
]

Class {
	#name : #LeHtmlBookMainPageLink,
	#superclass : #Object,
	#traits : 'TLeHtmlBookPageLink',
	#classTraits : 'TLeHtmlBookPageLink classTrait',
	#instVars : [
		'page',
		'fileName'
	],
	#category : #'Lepiter-HTML-Book Helpers'
}

{ #category : #accessing }
LeHtmlBookMainPageLink >> fileName [
	<return: #String>
	^ fileName
]

{ #category : #accessing }
LeHtmlBookMainPageLink >> fileName: aString [
	fileName := aString
]

{ #category : #testing }
LeHtmlBookMainPageLink >> isMainPage [
	^ true
]

{ #category : #accessing }
LeHtmlBookMainPageLink >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeHtmlBookMainPageLink >> page: aLePage [
	page := aLePage
]

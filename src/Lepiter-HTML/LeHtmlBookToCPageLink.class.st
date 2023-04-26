Class {
	#name : #LeHtmlBookToCPageLink,
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
LeHtmlBookToCPageLink >> fileName [
	<return: #String>
	^ fileName
]

{ #category : #accessing }
LeHtmlBookToCPageLink >> fileName: aString [
	fileName := aString
]

{ #category : #testing }
LeHtmlBookToCPageLink >> isToC [
	^ true
]

{ #category : #accessing }
LeHtmlBookToCPageLink >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeHtmlBookToCPageLink >> page: aLePage [
	page := aLePage
]

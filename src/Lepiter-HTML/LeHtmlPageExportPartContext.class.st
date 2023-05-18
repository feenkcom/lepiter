Class {
	#name : #LeHtmlPageExportPartContext,
	#superclass : #Object,
	#instVars : [
		'stream',
		'page'
	],
	#category : #'Lepiter-HTML-Helpers'
}

{ #category : #accessing }
LeHtmlPageExportPartContext >> page [
	^ page
]

{ #category : #accessing }
LeHtmlPageExportPartContext >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeHtmlPageExportPartContext >> stream [
	^ stream
]

{ #category : #accessing }
LeHtmlPageExportPartContext >> stream: aStream [
	(aStream isKindOf: LeHtmlOutputPrettyStream)
		ifTrue: [ stream := aStream ]
		ifFalse: [ stream := LeHtmlOutputPrettyStream on: aStream ]
]

Class {
	#name : #LeStringFormatChanged,
	#superclass : #Announcement,
	#instVars : [
		'format',
		'parser'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #accessing }
LeStringFormatChanged >> format [
	^ format
]

{ #category : #accessing }
LeStringFormatChanged >> format: anObject [
	format := anObject
]

{ #category : #accessing }
LeStringFormatChanged >> parser [
	^ parser
]

{ #category : #accessing }
LeStringFormatChanged >> parser: anObject [
	parser := anObject
]

Class {
	#name : #LeImage,
	#superclass : #Object,
	#instVars : [
		'version',
		'timestamp'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'Lepiter-Utilities-Versioning'
}

{ #category : #accessing }
LeImage class >> instance [
	singleton ifNil: [
		singleton := self new.
	].
	^ singleton
]

{ #category : #accessing }
LeImage class >> stampVersion [
	| v |
	v := LeReleaserCommandline new buildWorkflow rootProjectRelease repositoryRelease version.
	self instance version: v.
	self instance timestamp: DateAndTime now.
]

{ #category : #accessing }
LeImage >> timestamp [
	^ timestamp
]

{ #category : #accessing }
LeImage >> timestamp: aTimestamp [
	timestamp := aTimestamp
]

{ #category : #accessing }
LeImage >> version [
	^ version
]

{ #category : #accessing }
LeImage >> version: aVersion [
	version := aVersion
]

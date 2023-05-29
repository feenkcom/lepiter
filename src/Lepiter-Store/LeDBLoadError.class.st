"
LeDBLoadError is resignaled when exceptions are caught during the DB load process.  The offending file will be renamed to corrupt, and reported in the exception, allowing the DB load process to continue and the offending file to be reported.

"
Class {
	#name : #LeDBLoadError,
	#superclass : #Error,
	#instVars : [
		'reason',
		'originalException',
		'pageUid',
		'properties',
		'pageTitle'
	],
	#category : #'Lepiter-Store-Exceptions'
}

{ #category : #accessing }
LeDBLoadError >> initialize [

	super initialize.
	properties := Dictionary new.
]

{ #category : #accessing }
LeDBLoadError >> originalException [
	^ originalException
]

{ #category : #accessing }
LeDBLoadError >> originalException: anObject [
	originalException := anObject
]

{ #category : #accessing }
LeDBLoadError >> pageTitle [
	^ pageTitle
]

{ #category : #accessing }
LeDBLoadError >> pageTitle: anObject [
	pageTitle := anObject
]

{ #category : #accessing }
LeDBLoadError >> pageUid [
	^ pageUid
]

{ #category : #accessing }
LeDBLoadError >> pageUid: anObject [
	pageUid := anObject
]

{ #category : #printing }
LeDBLoadError >> printOn: aStream [

	aStream
		print: reason;
		<< ' in page ';
		print: pageTitle
]

{ #category : #accessing }
LeDBLoadError >> properties [
	^ properties
]

{ #category : #accessing }
LeDBLoadError >> reason [
	^ reason
]

{ #category : #accessing }
LeDBLoadError >> reason: anObject [
	reason := anObject
]

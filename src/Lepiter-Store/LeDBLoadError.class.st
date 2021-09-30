"
LeDBLoadError is resignaled when exceptions are caught during the DB load process.  The offending file will be renamed to corrupt, and reported in the exception, allowing the DB load process to continue and the offending file to be reported.

"
Class {
	#name : #LeDBLoadError,
	#superclass : #Error,
	#instVars : [
		'fileReference',
		'reason',
		'originalException'
	],
	#category : 'Lepiter-Store-Exceptions'
}

{ #category : #accessing }
LeDBLoadError >> fileReference [
	^ fileReference
]

{ #category : #accessing }
LeDBLoadError >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #accessing }
LeDBLoadError >> originalException [
	^ originalException
]

{ #category : #accessing }
LeDBLoadError >> originalException: anObject [
	originalException := anObject
]

{ #category : #printing }
LeDBLoadError >> printOn: aStream [

	aStream
		print: reason;
		<< ' in ';
		print: fileReference
]

{ #category : #accessing }
LeDBLoadError >> reason [
	^ reason
]

{ #category : #accessing }
LeDBLoadError >> reason: anObject [
	reason := anObject
]

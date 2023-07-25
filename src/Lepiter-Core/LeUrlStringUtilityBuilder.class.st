Class {
	#name : #LeUrlStringUtilityBuilder,
	#superclass : #Object,
	#instVars : [
		'database',
		'urlStringUtility',
		'urlString'
	],
	#category : #'Lepiter-Core-Utility'
}

{ #category : #convenience }
LeUrlStringUtilityBuilder >> asString [
	^ urlStringUtility asString
]

{ #category : #'api - building' }
LeUrlStringUtilityBuilder >> build [
	| db rootDir fixedUrlString |
	db := self database.

	rootDir := (db isDatabase not or: [ db monitor isNil ])
			ifTrue: [ FileLocator workingDirectory ]
			ifFalse: [ db monitor localRoot ].
			
	fixedUrlString := LeUrlStringUtilityTwoSlashesFixer new
		urlString: self urlString;
		fix;
		fixedUrlString.

	urlStringUtility := GtUrlStringUtility new
			rootDirectory: rootDir;
			urlString: fixedUrlString
]

{ #category : #accessing }
LeUrlStringUtilityBuilder >> database [
	^ database ifNil: [ database := LeNullDatabase default ]
]

{ #category : #accessing }
LeUrlStringUtilityBuilder >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeUrlStringUtilityBuilder >> urlString [
	^ urlString
]

{ #category : #accessing }
LeUrlStringUtilityBuilder >> urlString: anObject [
	urlString := anObject
]

{ #category : #accessing }
LeUrlStringUtilityBuilder >> urlStringUtility [
	<return: #GtUrlStringUtility>
	^ urlStringUtility
]

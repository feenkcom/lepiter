Class {
	#name : #LeDatabaseTool,
	#superclass : #LePhlowTool,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-UI-Phlow Tools'
}

{ #category : #'api - instance creation' }
LeDatabaseTool class >> database: aDatabase [
	^ self new database: aDatabase 
]

{ #category : #'api - converting' }
LeDatabaseTool >> asElementDo: aOneArgBlock [
	| anElement |
	anElement := self database asToolElement.
	^ aOneArgBlock cull: anElement
]

{ #category : #'api - accessing' }
LeDatabaseTool >> database [
	<return: #LeDatabase>
	^ database
]

{ #category : #'api - accessing' }
LeDatabaseTool >> database: aDatabase [
	database := aDatabase
]

{ #category : #'api - accessing' }
LeDatabaseTool >> object [
	^ self database
]

{ #category : #'api - accessing' }
LeDatabaseTool >> title [
	^ self database filename 
		ifNil: [ 'database' ]
		ifNotNil: [ :aFileReference | aFileReference basename ]
]

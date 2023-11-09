"
I am an abstract class.
My subclasses are commands are (will be) executed to reload a {{gtClass: LeLogicalDatabase}} instance.
I am used by {{gtClass: LeLogicalDatabaseReload}}. 

"
Class {
	#name : #LeLogicalDatabaseReloadCommand,
	#superclass : #Object,
	#instVars : [
		'contentReloadErrorStrategy'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadCommand >> addIn: aLogicalDatabase [
	self subclassResponsibility
]

{ #category : #accessing }
LeLogicalDatabaseReloadCommand >> contentReloadErrorStrategy [
	^ contentReloadErrorStrategy ifNil: [
		self defaultContentReloadErrorStrategy]
]

{ #category : #accessing }
LeLogicalDatabaseReloadCommand >> contentReloadErrorStrategy: aContentReloadErrorStrategy [
	self assert: [ aContentReloadErrorStrategy notNil ].
	
	contentReloadErrorStrategy := aContentReloadErrorStrategy
]

{ #category : #accessing }
LeLogicalDatabaseReloadCommand >> defaultContentReloadErrorStrategy [
	^ LeDatabaseContentReloadErrorStrategy forkDebuggerOnErrorStrategy
]

{ #category : #printing }
LeLogicalDatabaseReloadCommand >> printOn: aStream [
	| separate |
	super printOn: aStream.

	self class isAbstract ifTrue: [ ^ self ].

	aStream nextPut: $(.
	separate := false.
	self
		toBeUsedDatabasesDo: [ :aDb | 
			separate ifTrue: [ aStream nextPutAll: ', ' ].
			separate := false.

			aStream print: aDb ].
	aStream nextPut: $)
]

{ #category : #updating }
LeLogicalDatabaseReloadCommand >> reloadAndStartMonitoringIn: aLogicalDatabase [
	"Existing (reused) databases should be reloaded and monitoring started"

	
]

{ #category : #updating }
LeLogicalDatabaseReloadCommand >> removeIn: aLogicalDatabase [
]

{ #category : #evaluating }
LeLogicalDatabaseReloadCommand >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	self subclassResponsibility
]

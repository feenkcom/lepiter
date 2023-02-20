Class {
	#name : #LeLogicalDatabaseReloadCommand,
	#superclass : #Object,
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadCommand >> addIn: aLogicalDatabase [
	self subclassResponsibility
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

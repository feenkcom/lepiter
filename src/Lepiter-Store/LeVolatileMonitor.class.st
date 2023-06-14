"
LeVolatileMonitor provides just enough functionality to allow testing of {{gtClass:LeDatabase}} in memory.
"
Class {
	#name : #LeVolatileMonitor,
	#superclass : #Object,
	#instVars : [
		'uuid',
		'databaseName'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeVolatileMonitor >> databaseName [

	^ databaseName ifNil: [ '<an unnamed volatile knowledgebase>' ]
]

{ #category : #accessing }
LeVolatileMonitor >> databaseName: anObject [

	databaseName := anObject
]

{ #category : #initialization }
LeVolatileMonitor >> initialize [

	super initialize.
	uuid := UUID new.
]

{ #category : #accessing }
LeVolatileMonitor >> uuid [

	^ uuid
]

{ #category : #accessing }
LeVolatileMonitor >> uuidString [

	^ uuid asString36
]

"
LeVolatileMonitor provides just enough functionality to allow testing of {{gtClass:LeDatabase}} in memory.
"
Class {
	#name : #LeVolatileMonitor,
	#superclass : #Object,
	#instVars : [
		'uuid',
		'databaseName',
		'tableOfContentsPageID',
		'dbProperties'
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

{ #category : #accessing }
LeVolatileMonitor >> dbProperties [
	^ dbProperties ifNil: [ dbProperties := {} asDictionary ]
]

{ #category : #initialization }
LeVolatileMonitor >> initialize [

	super initialize.
	uuid := UUID new.
]

{ #category : #testing }
LeVolatileMonitor >> isVolatileMonitor [
	^ true
]

{ #category : #compatibility }
LeVolatileMonitor >> jsLink [
	"Copied from LeDatabaseStore>>#jsLink"
	<return: #Dictionary>
	^ self dbProperties
		at: #jsLink
		ifPresent: [ :aDictionary | aDictionary ]
		ifAbsent: [ Dictionary new ]
]

{ #category : #compatibility }
LeVolatileMonitor >> jsLinkSettings [
	"Copied from LeDatabaseStore>>#jsLinkSettings"
	<return: #LeJSLinkSettings>
	^ LeJSLinkSettings new dbProperties: self
]

{ #category : #compatibility }
LeVolatileMonitor >> localRoot [
	"Copied from LeDatabaseStore>>#localRoot"
	^ LepiterCoreDefaults defaultLocalDirectory
]

{ #category : #accessing }
LeVolatileMonitor >> tableOfContentsPageID [
	"Answer the page UUID for the Table Of Contents, or nil if not set"

	^ tableOfContentsPageID
]

{ #category : #accessing }
LeVolatileMonitor >> tableOfContentsPageID: aUUID [
	tableOfContentsPageID := aUUID
]

{ #category : #accessing }
LeVolatileMonitor >> uuid [

	^ uuid
]

{ #category : #accessing }
LeVolatileMonitor >> uuidString [

	^ uuid asString36
]

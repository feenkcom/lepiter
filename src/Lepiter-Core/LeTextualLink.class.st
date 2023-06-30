"
Link to a page or snippet.


## Implementation Points

targetDatabaseUUID must be nil if the link is for the origin's database.  This allows a single physical database to be operated without a monitor (which is responsible for storing the database uuid).

"
Class {
	#name : #LeTextualLink,
	#superclass : #LeExplicitLink,
	#instVars : [
		'origin',
		'node',
		'targetReference'
	],
	#category : #'Lepiter-Core-Links'
}

{ #category : #'instance creation' }
LeTextualLink class >> fromPageAnnotation: aLePageAnnotationNode [
	"Answer an instance of the appropriate subclass based on the supplied annotation"

	^ aLePageAnnotationNode isLinkByName ifTrue:
		[ LeTextualPageLink new
			node: aLePageAnnotationNode;
			targetPageTitle: aLePageAnnotationNode pageName;
			targetDatabaseUUID: aLePageAnnotationNode dbUuidString ]
	ifFalse:
		[ LeUidPageLink new
			node: aLePageAnnotationNode;
			targetPageUidString: aLePageAnnotationNode pageUidString;
			targetDatabaseUUID: aLePageAnnotationNode dbUuidString ].
]

{ #category : #accessing }
LeTextualLink >> acceptVisitor: aVisitor [

	node acceptVisitor: aVisitor.
	aVisitor visitTextualLink: self.
]

{ #category : #accessing }
LeTextualLink >> database [ 
	^ self origin database
]

{ #category : #'api - accessing' }
LeTextualLink >> editTime [ 
	"Answer the edit time of the receiver's origin"
	<return: #LeTime>

	^ origin editTime
]

{ #category : #'api - testing' }
LeTextualLink >> hasTarget [
	^ self target isNotNil
]

{ #category : #'api - testing' }
LeTextualLink >> isForeign [
	"Answer a boolean indicating whether the receiver links to a foreign database"

	^ self targetDatabaseUUID isNotNil
]

{ #category : #'api - testing' }
LeTextualLink >> isLocalLink [
	"Answer a boolean indicating whether the target database is local"

	^ self targetDatabaseUUID isNil
]

{ #category : #'api - testing' }
LeTextualLink >> isTextualLink [
	^ true
]

{ #category : #'api - testing' }
LeTextualLink >> isTextualPageLink [
	"Answer a boolean indicating whether the receiver is a link to a page derived from snippet source"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
LeTextualLink >> isTextualSnippetLink [
	^ false
]

{ #category : #'api - accepting' }
LeTextualLink >> node [
	<return: #LeContentNode>
	^ node
]

{ #category : #'api - accepting' }
LeTextualLink >> node: aNode [
	self
		assert: [ node isNil ] 
		description: [ 'Link node can be set just once' ].
	node := aNode
]

{ #category : #callbacks }
LeTextualLink >> onAddedToDatabase: aDatabase [
	self assert: [ self database isNotNil ] description: 'There should be no database explicitly set'.
	super onAddedToDatabase: aDatabase.
	
	self resolveReferences
]

{ #category : #hooks }
LeTextualLink >> onTargetChanged [
	self origin linkedTarget: self target in: self.
]

{ #category : #hooks }
LeTextualLink >> onTargetRemoved: aTarget [
	self origin unlinkedTarget: aTarget in: self.
]

{ #category : #'api - accepting' }
LeTextualLink >> origin [
	^ origin
]

{ #category : #'api - accepting' }
LeTextualLink >> origin: aLeSnippet [

	self
		assert: [ origin isNil ] 
		description: [ 'Link origin can be set just once' ].
	
	origin := aLeSnippet.
	
	"Ensure that if the target database is the origin's, the variable is nil.
	(During parsing, the origin database isn't known)"
	origin database uuid asString36 = self targetDatabaseUUID ifTrue: 
		[ self targetReference targetDatabaseUUID: nil ].

]

{ #category : #accessing }
LeTextualLink >> originReference [
	^ (LeLinkSnippetUidReference forSnippet: origin)
			explicitLink: self
]

{ #category : #actions }
LeTextualLink >> resolveReferences [ 
	self targetReference resolveAndLinkReference
]

{ #category : #accessing }
LeTextualLink >> target [
	^ self targetReference content
]

{ #category : #'api - accessing' }
LeTextualLink >> targetDatabaseUUID [
	"Answer the UUID of the database containing the link.
	Links within the origins database should have UUID = nil"
	<return: #String>

	^ self targetReference targetDatabaseUUID
]

{ #category : #'api - accessing' }
LeTextualLink >> targetDatabaseUUID: aUUIDString36 [
	"Set the UUID of the database containing the link.
	Links within the origins database should have UUID = nil"

	self targetReference targetDatabaseUUID: aUUIDString36
]

{ #category : #accessing }
LeTextualLink >> targetReference [
	^ targetReference
]

{ #category : #'api - accepting' }
LeTextualLink >> targetUID [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'api - updating' }
LeTextualLink >> unlinkReferences [
	self targetReference unlink. 
]

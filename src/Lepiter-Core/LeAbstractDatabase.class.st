"
Lepiter supports multiple types of databases:

- The 'normal' database is {{gtClass:LeDatabase}}, which represents a single instance of a database on-disk.
- {{gtClass:LeLogicalDatabase}} is a collection of databases that can be used in a single UI.
- {{gtClass:LePharoClassDatabase}} acts as a view on to the class comments in a Pharo image.

"
Class {
	#name : #LeAbstractDatabase,
	#superclass : #LeModel,
	#traits : 'TGtAnnouncer + TLeSpotterChildrenEnumerationSearch + TLeSpotterPagesSearch',
	#classTraits : 'TGtAnnouncer classTrait + TLeSpotterChildrenEnumerationSearch classTrait + TLeSpotterPagesSearch classTrait',
	#instVars : [
		'announcer',
		'parent',
		'readOnly'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #visiting }
LeAbstractDatabase >> acceptVisitor: aVisitor [

	^ aVisitor visitDatabase: self
]

{ #category : #announcer }
LeAbstractDatabase >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'api - query' }
LeAbstractDatabase >> asyncPageClassReferencesTo: aString [
	^ ((self asyncSnippetClassReferencesTo: aString) collect: #page)
		withoutDuplicates
]

{ #category : #'api - query' }
LeAbstractDatabase >> asyncPageReferencesTo: aString [
	^ ((self asyncSnippetReferencesTo: aString) collect: #page) withoutDuplicates
]

{ #category : #'api - query' }
LeAbstractDatabase >> asyncSnippetClassReferencesTo: aString [
	^ #() asAsyncStream
]

{ #category : #'api - query' }
LeAbstractDatabase >> asyncSnippetReferencesTo: aString [
	^ #() asAsyncStream
]

{ #category : #initialization }
LeAbstractDatabase >> initialize [

	super initialize.
	announcer := Announcer new.

]

{ #category : #'api - accessing' }
LeAbstractDatabase >> logicalDatabase [
	"Answer the logical database for the receiver.
	This is either the receiver's parent, if it has one, or the receiver itself"

	^ parent ifNil: [ self ]
]

{ #category : #'api - accessing' }
LeAbstractDatabase >> pageNamed: aString [

	^ self subclassResponsibility 
]

{ #category : #'api - accessing' }
LeAbstractDatabase >> parent [ 
	"Answer the parent database of the receiver (a LeLogicalDatabase) or nil"
	<return: #LeLogicalDatabase>

	^ parent
]

{ #category : #'api - accessing' }
LeAbstractDatabase >> parent: aLeLogicalDatabase [
	"Set the parent database of the receiver (a LeLogicalDatabase)"

	parent := aLeLogicalDatabase
]

{ #category : #'api - reference' }
LeAbstractDatabase >> pictureReferenceIds [
	^ self
		optionAt: #pictureReferenceIds
		ifAbsentPut: [ LeDatabaseReferenceIds picture ]
]

{ #category : #'api - reference' }
LeAbstractDatabase >> pictureReferenceNextId [
	^ LeDatabaseReferenceIdBuilder new
		database: self;
		referenceIds: self pictureReferenceIds;
		nextReference
]

{ #category : #accessing }
LeAbstractDatabase >> readOnly [
	^ readOnly
]

{ #category : #accessing }
LeAbstractDatabase >> readOnly: aBoolean [
	readOnly := aBoolean
]

{ #category : #'api - enumerating' }
LeAbstractDatabase >> snippetsIterator [
	^ LeDatabaseToCSnippetsIterator new database: self
]

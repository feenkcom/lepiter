Class {
	#name : #LeDatabaseClassJsonV4Storage,
	#superclass : #LeDatabaseClassStorage,
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #versions }
LeDatabaseClassJsonV4Storage class >> currentVersion [ 

	^ LeDbVersion fromString: self currentVersionString
]

{ #category : #versions }
LeDatabaseClassJsonV4Storage class >> currentVersionString [
	"Answer the string representation of the current version number"

	^ '4.1'
]

{ #category : #saving }
LeDatabaseClassJsonV4Storage >> serialize: anObject on: aStream prettyPrint: aBoolean [

	LeJsonV4 uniqueInstance serialize: anObject on: aStream prettyPrint: aBoolean
]

{ #category : #'schema updating' }
LeDatabaseClassJsonV4Storage >> updateDbStore: store [
	"Update the store to the latest minor version.
	Class base storage was added with schema 4.1.  Until there is a new schema version, nothing to do."
]

Class {
	#name : #LeJSLinkSettings,
	#superclass : #Object,
	#instVars : [
		'dbProperties'
	],
	#category : 'Lepiter-JavaScript'
}

{ #category : #accessing }
LeJSLinkSettings >> dbProperties [
	^ dbProperties
]

{ #category : #accessing }
LeJSLinkSettings >> dbProperties: anObject [
	dbProperties := anObject
]

{ #category : #'accessing - db properties' }
LeJSLinkSettings >> directory [
	"Answer the FileReference where PythonBridge should be located for this database"
	<return: #FileReference or: nil>

	^ dbProperties jsLink at: #directory
		ifPresent: [ :aString | dbProperties fileReferenceFrom: aString ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LeJSLinkSettings >> directory: aFileReferenceStringOrNil [
	"Store the directory as a string.
	Keep relative paths relative."

	self updateProperty: #directory 
		value: (dbProperties fileReferenceString: aFileReferenceStringOrNil)
]

{ #category : #'accessing - db properties' }
LeJSLinkSettings >> nodejsPath [
	"Answer the FileReference where node[js] is located"
	<return: #FileReference or: nil>

	^ dbProperties jsLink at: #nodejsPath
		ifPresent: [ :aString | aString asFileReference ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LeJSLinkSettings >> nodejsPath: aFileReferenceStringOrNil [

	self updateProperty: #nodejsPath 
		value: (dbProperties fileReferenceString: aFileReferenceStringOrNil)
]

{ #category : #'accessing - db properties' }
LeJSLinkSettings >> serverDebugMode [
	"Answer a boolean indicating whether the server should be started in debug mode"
	<return: #Boolean>

	^ dbProperties jsLink at: #serverDebugMode
		ifPresent: [ :aBoolean | aBoolean ]
		ifAbsent: [ false ]
]

{ #category : #'accessing - db properties' }
LeJSLinkSettings >> serverDebugMode: aBooleanOrNil [
	"Set a boolean indicating whether the server should be started in debug mode"

	^ self updateProperty: #serverDebugMode value: aBooleanOrNil
]

{ #category : #private }
LeJSLinkSettings >> updateProperty: propertyName value: aJSONObject [
	| jsDictionary |

	jsDictionary := self dbProperties jsLink copy.
	aJSONObject ifNil: 
		[ jsDictionary removeKey: propertyName ifAbsent: [ ].
		^ dbProperties jsLink: jsDictionary ].
	(jsDictionary at: propertyName ifAbsent: [nil]) = aJSONObject ifTrue: [ ^ self ].
	jsDictionary at: propertyName put: aJSONObject.
	dbProperties jsLink: jsDictionary.
]

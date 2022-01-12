"
LePythonBridgeSettings provides a wrapper around the DB properties to group PythonBridge settings together.

"
Class {
	#name : #LePythonBridgeSettings,
	#superclass : #Object,
	#instVars : [
		'dbProperties'
	],
	#category : 'Lepiter-Python-Settings'
}

{ #category : #accessing }
LePythonBridgeSettings >> dbProperties [
	^ dbProperties
]

{ #category : #accessing }
LePythonBridgeSettings >> dbProperties: anObject [
	dbProperties := anObject
]

{ #category : #'accessing - db properties' }
LePythonBridgeSettings >> directory [
	"Answer the FileReference where PythonBridge should be located for this database"
	<return: #FileReference or: nil>

	^ dbProperties pythonBridge at: #directory
		ifPresent: [ :aString | aString asFileReference ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LePythonBridgeSettings >> directory: aFileReferenceStringOrNil [
	"Store the directory as a string."

	self updateProperty: #directory 
		value: (dbProperties fileReferenceString: aFileReferenceStringOrNil)
]

{ #category : #'accessing - db properties' }
LePythonBridgeSettings >> pipenvPath [
	"Answer the FileReference where pipenv is located"
	<return: #FileReference or: nil>

	^ dbProperties pythonBridge at: #pipenvPath
		ifPresent: [ :aString | aString asFileReference ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LePythonBridgeSettings >> pipenvPath: aFileReferenceStringOrNil [

	self updateProperty: #pipenvPath 
		value: (dbProperties fileReferenceString: aFileReferenceStringOrNil)
]

{ #category : #accessing }
LePythonBridgeSettings >> serverDebugMode [
	"Answer a boolean indicating whether the server should be started in debug mode"
	<return: #Boolean>

	^ dbProperties pythonBridge at: #serverDebugMode
		ifPresent: [ :aBoolean | aBoolean ]
		ifAbsent: [ false ]
]

{ #category : #accessing }
LePythonBridgeSettings >> serverDebugMode: aBooleanOrNil [
	"Set a boolean indicating whether the server should be started in debug mode"

	^ self updateProperty: #serverDebugMode value: aBooleanOrNil
]

{ #category : #private }
LePythonBridgeSettings >> updateProperty: propertyName value: aJSONObject [
	| pbDictionary |

	pbDictionary := self dbProperties pythonBridge copy.
	aJSONObject ifNil: 
		[ pbDictionary removeKey: propertyName ifAbsent: [ ].
		^ dbProperties pythonBridge: pbDictionary ].
	(pbDictionary at: propertyName ifAbsent: [nil]) = aJSONObject ifTrue: [ ^ self ].
	pbDictionary at: propertyName put: aJSONObject.
	dbProperties pythonBridge: pbDictionary.
]

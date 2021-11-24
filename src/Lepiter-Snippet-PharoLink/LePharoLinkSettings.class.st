"
LePharoLinkSettings provides a wrapper around the DB properties to group PythonBridge settings together.

"
Class {
	#name : #LePharoLinkSettings,
	#superclass : #LeSubSettings,
	#category : #'Lepiter-Snippet-PharoLink-Settings'
}

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> associations [ 
	"Answer an array of associations of the receiver's properties"

	^ #(serverExecutable serverImage clientAddress serverAddress serverDebugMode manualProcess) collect: 
		[ :name | name -> (name value: self) ]
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> clientAddress [
	"Answer the host:port string the client should listen on"
	<return: #String or: nil>

	^ self subProperties at: #clientAddress ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> clientAddress: aStringOrNil [
	"Set the host:port string the client should listen on"

	self validateAddress: aStringOrNil.
	^ self updateProperty: #clientAddress value: aStringOrNil
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> clientSocketAddress [ 
	<return: #LanguageLinkSocketAddress>

	^ self socketAddressFrom: self clientAddress
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> manualProcess [
	"Answer a boolean indicating whether the server is externally managed"
	<return: #Boolean>

	^ self subProperties at: #manualProcess
		ifPresent: [ :aBoolean | aBoolean ]
		ifAbsent: [ false ]
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> manualProcess: aBooleanOrNil [
	"Set a boolean indicating whether the server process is externally managed"

	^ self updateProperty: #manualProcess value: aBooleanOrNil
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverAddress [
	"Answer the host:port string the client should listen on"
	<return: #String or: nil>

	^ self subProperties at: #serverAddress ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverAddress: aStringOrNil [
	"Set the host:port string the server should listen on"

	^ self updateProperty: #serverAddress value: aStringOrNil
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverDebugMode [
	"Answer a boolean indicating whether the server should be started in debug mode"
	<return: #Boolean>

	^ self subProperties at: #serverDebugMode
		ifPresent: [ :aBoolean | aBoolean ]
		ifAbsent: [ false ]
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverDebugMode: aBooleanOrNil [
	"Set a boolean indicating whether the server should be started in debug mode"

	^ self updateProperty: #serverDebugMode value: aBooleanOrNil
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverExecutable [
	"Answer the FileReference representing the server executable to use"
	<return: #FileReference or: nil>

	^ self subProperties at: #serverExecutable
		ifPresent: [ :aString | aString asFileReference ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverExecutable: aFileReferenceStringOrNil [
	"Store the serverExecutable as a string."

	self updateProperty: #serverExecutable 
		value: (dbProperties fileReferenceString: aFileReferenceStringOrNil)
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverImage [
	"Answer the FileReference representing the server image to use"
	<return: #FileReference or: nil>

	^ self subProperties at: #serverImage
		ifPresent: [ :aString | aString asFileReference ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverImage: aFileReferenceStringOrNil [
	"Store the serverImage as a string."

	self updateProperty: #serverImage
		value: (dbProperties fileReferenceString: aFileReferenceStringOrNil)
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> serverSocketAddress [ 
	<return: #LanguageLinkSocketAddress>

	^ self socketAddressFrom: self serverAddress
]

{ #category : #'accessing - db properties' }
LePharoLinkSettings >> settingsNames [
	"Answer the names of the receiver's properties"

	^ #(serverExecutable serverImage clientAddress serverAddress serverDebugMode manualProcess)
]

{ #category : #private }
LePharoLinkSettings >> socketAddressFrom: aString [

	aString ifNil: [ ^ nil ].
	^ LanguageLinkSocketAddress from: aString
]

{ #category : #'private - accessing' }
LePharoLinkSettings >> subProperties [

	^ dbProperties pharoLink
]

{ #category : #'private - accessing' }
LePharoLinkSettings >> subProperties: aDictionary [

	dbProperties pharoLink: aDictionary
]

{ #category : #private }
LePharoLinkSettings >> validateAddress: aStringOrNil [
	"Ensure that the supplied string is in the form <host>:<port>.
	Currently no checking is done on the host format"
	| segments |

	aStringOrNil ifNil: [ ^ self ].

	segments := $: split: aStringOrNil.
	segments size = 2 ifFalse: 
		[ self error: aStringOrNil printString, ' must be formatted <host>:<port>' ].
	(segments second allSatisfy: #isDigit) ifFalse: 
		[ self error: aStringOrNil printString, ' the port must be a number' ].

]

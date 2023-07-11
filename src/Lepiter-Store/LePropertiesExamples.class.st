Class {
	#name : #LePropertiesExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Store-Examples'
}

{ #category : #private }
LePropertiesExamples >> newProperties [
	"Answer a default Lepiter properties object"

	^ LeLocalStore forJsonV4 localRoot: FileSystem memory root
]

{ #category : #accessing }
LePropertiesExamples >> pathFrom: anArray [
	^ String streamContents: [ :aStream | 
			anArray 
				asStringOn: aStream 
				delimiter: FileSystem disk delimiter asString ]
]

{ #category : #private }
LePropertiesExamples >> propertiesDictionaryFrom: settings [
	"Answer the properties dictionary for the supplied settings"

	^ STONJSON fromString: (settings dbProperties localRoot / 'lepiter.properties') contents
]

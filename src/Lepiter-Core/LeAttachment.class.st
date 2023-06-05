Class {
	#name : #LeAttachment,
	#superclass : #LeModel,
	#instVars : [
		'originalReference',
		'uploadedBy',
		'uploadDate'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #accessing }
LeAttachment class >> basename [ 
	"Answer the file name used to store attachment properties"

	^ 'lepiter_attachment.properties'
]

{ #category : #'instance creation' }
LeAttachment class >> forAttachedFile: aFileReference [
	"The supplied file is presumed to have lepiter_attachment.properties in the same directory"

	^ self loadFrom: aFileReference parent / self basename
]

{ #category : #'instance creation' }
LeAttachment class >> loadFrom: aFileReference [
	"Load the receiver from the supplied file"

	^ LeLocalStore currentStorageClass new loadFromFile: aFileReference
]

{ #category : #'instance creation' }
LeAttachment class >> loadFromFolder: aFolderReference [
	^ LeLocalStore currentStorageClass new 
		loadFromFile: aFolderReference /  self basename
]

{ #category : #visiting }
LeAttachment >> acceptVisitor: aVisitor [

	^ aVisitor visitAttachment: self
]

{ #category : #accessing }
LeAttachment >> originalReference [
	^ originalReference
]

{ #category : #accessing }
LeAttachment >> originalReference: anObject [
	originalReference := anObject
]

{ #category : #saving }
LeAttachment >> saveTo: aFileReference for: aLeDatabase [
	"Save the receiver in the supplied directory in JSON format.
	Only include personal information if explicitly flagged in the database"
	| saveVersion propertiesFile |

	saveVersion := aLeDatabase monitor savePersonalInformation 
		ifTrue: [ self ]
		ifFalse: [ self copy originalReference: nil ].
	propertiesFile := aFileReference / self class basename.
	propertiesFile ensureDelete.
	propertiesFile writeStreamDo: [ :stream |
		LeLocalStore currentStorageClass new 
			serialize: saveVersion
			on: (ZnNewLineWriterStream on: stream) 
			prettyPrint: false ].

]

{ #category : #printing }
LeAttachment >> storeOn: aStream [

	aStream
		nextPut: $(;
		<< self class name;
		<< ' new';
		<< ' instVarNamed: ''options'' put: ';
			<< (self instVarNamed: 'options') storeString;
			<< ';';
		<< ' instVarNamed: ''originalReference'' put: ';
			<< (self instVarNamed: 'originalReference') storeString;
			<< ';';
		<< ' instVarNamed: ''uploadDate'' put: ';
			<< (self instVarNamed: 'uploadDate') storeString;
			<< ';';
		<< ' instVarNamed: ''uploadedBy'' put: ';
			<< (self instVarNamed: 'uploadedBy') storeString;
			<< ';';
		<< ' yourself)'

]

{ #category : #accessing }
LeAttachment >> uploadDate [
	^ uploadDate
]

{ #category : #accessing }
LeAttachment >> uploadDate: anObject [
	uploadDate := anObject
]

{ #category : #accessing }
LeAttachment >> uploadedBy [
	^ uploadedBy
]

{ #category : #accessing }
LeAttachment >> uploadedBy: anObject [
	uploadedBy := anObject
]

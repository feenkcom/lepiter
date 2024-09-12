Class {
	#name : #LeAttachment,
	#superclass : #LeModel,
	#instVars : [
		'originalReference',
		'uploadedBy',
		'uploadDate',
		'originalBasename'
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

{ #category : #visiting }
LeAttachment >> acceptVisitor: aVisitor [

	^ aVisitor visitAttachment: self
]

{ #category : #printing }
LeAttachment >> fileNameDescription [
	^ self originalReference 
		ifNil: [ 
			self originalBasename
				ifNil: [ '<none>' ] ]
		ifNotNil: #basename 
]

{ #category : #printing }
LeAttachment >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	
	aStream parenthesize: [
		aStream << self fileNameDescription ]
]

{ #category : #accessing }
LeAttachment >> originalBasename [
	"This is a new field that can be missing for older attachments.
	The reason we added it is to keep the name of the file even if 
	the originalReference is missing, so that we can identify the 
	actual attachment file, without needing callers to pass the file name"
	
	^ originalBasename
]

{ #category : #accessing }
LeAttachment >> originalBasename: aFilename [
	originalBasename := aFilename
]

{ #category : #accessing }
LeAttachment >> originalExtension [
	| basename |
	basename := self originalBasename ifNil: [
		self originalReference ifNotNil: [ :aFile | aFile basename ] ].
	
	^ basename ifNotNil: [ :aBasename |
		aBasename copyAfterLast: Path extensionDelimiter ]
]

{ #category : #accessing }
LeAttachment >> originalReference [
	^ originalReference
]

{ #category : #accessing }
LeAttachment >> originalReference: anObject [
	originalReference := anObject
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
		<< ' instVarNamed: ''originalBasename'' put: ';
			<< (self instVarNamed: 'originalBasename') storeString;
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

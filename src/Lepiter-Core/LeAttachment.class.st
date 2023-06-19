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

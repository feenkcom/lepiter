Class {
	#name : #LeAttachmentWithClassStorageData,
	#superclass : #LeAttachmentWithData,
	#category : #'Lepiter-Core-Model'
}

{ #category : #ui }
LeAttachmentWithClassStorageData >> createPictureWidget [
	^ BrAsyncFileWidget new 
		formContentsBlock:  [ self readData  ]
]

{ #category : #printing }
LeAttachmentWithClassStorageData >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< self id;
			<< ', ';
			<< self metadata fileNameDescription ]
]

{ #category : #'gt - extensions' }
LeAttachmentWithClassStorageData >> gtFigureFor: aView [
	<gtView>
	
	metadata originalExtension ifNil: [ ^ aView empty ].
	(ImageReadWriter allTypicalFileExtensions 
		includes: metadata originalExtension asLowercase) 
			ifFalse: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ self createPictureWidget
			margin: (BlInsets all: 10);
			constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent. ] ]
]

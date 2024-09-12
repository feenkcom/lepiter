Extension { #name : #LeAttachment }

{ #category : #'*Lepiter-Store' }
LeAttachment class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#originalReference -> #originalReference);
		add: (#uploadDate -> #uploadDate);
		add: (#uploadedBy -> #uploadedBy);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeAttachment class >> leJsonV3Name [

	^ 'attachment'
]

{ #category : #'*Lepiter-Store' }
LeAttachment class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#originalReference -> #originalReference);
		add: (#originalBasename -> #originalBasename);
		add: (#uploadDate -> #uploadDate);
		add: (#uploadedBy -> #uploadedBy);
		yourself
]

{ #category : #'*Lepiter-Store' }
LeAttachment class >> leJsonV4Name [

	^ 'attachment'
]

{ #category : #'*Lepiter-Store' }
LeAttachment class >> loadFrom: aFileReference [
	"Load the receiver from the supplied file"

	^ LeLocalStore currentStorageClass new loadFromFile: aFileReference
]

{ #category : #'*Lepiter-Store' }
LeAttachment class >> loadFromFolder: aFolderReference [
	^ LeLocalStore currentStorageClass new 
		loadFromFile: aFolderReference /  self basename
]

{ #category : #'*Lepiter-Store' }
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

"
LeImageImport visits the supplied lepiter model and updates all textual and picture snippets so that references to external images are copied as local attachments in the database.

The database must have a monitor, i.e. a root directory where the images are attached.

The database can either be implicitly supplied by visiting it, or explicitly set with {{gtMethod:name=LeImageImportVisitor>>#database:}}.

If the original source URL of the image is to be saved as metadata, the database must have savePersonalInformation true, i.e.:

```
myLeDatabase monitor savePersonalInformation: true.
```

Typical usage is:

```
visitor := LeImageImportVisitor new
myLeDatabase monitor savePersonalInformation: true.
myLeDatabase acceptVisitor: visitor.
visitor cleanUp.
```

See {{gtClass:name=LeImageImportExamples}} for example use.

"
Class {
	#name : #LeImageImportVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'database',
		'addedImages',
		'failedImages',
		'pageChanged',
		'downloadDirectory'
	],
	#category : #'Lepiter-Utilities-ImageImport'
}

{ #category : #accessing }
LeImageImportVisitor >> addedImages [
	^ addedImages
]

{ #category : #'private - assertions' }
LeImageImportVisitor >> assertDatabaseOk: aLeDatabase [

	self assert: [ aLeDatabase isNotNil and: [ aLeDatabase hasMonitor ] ]
		description: 'The supplied database must have a monitor (root directory)'.
]

{ #category : #'private - attaching' }
LeImageImportVisitor >> attachURL: aUrlString [
	"Attempt to download and add the image at the supplied URL as an attachment"
	| downloadFile attachedFile attachedFileReference metadata |

	downloadFile := self downloadURL: aUrlString.
	downloadFile ifNil: [ ^ nil ].
	attachedFile := database addAttachmentByMove: downloadFile.
	attachedFileReference := self rootDirectory / attachedFile.
	metadata := LeAttachment forAttachedFile: attachedFileReference.
	metadata originalReference: aUrlString.
	metadata saveTo: attachedFileReference parent for: database.
	addedImages at: aUrlString put: attachedFileReference.
	^ attachedFile
]

{ #category : #cleanup }
LeImageImportVisitor >> cleanUp [ 
	"Remove any temporary resources left behind"

	downloadDirectory ifNotNil:
		[ downloadDirectory ensureDeleteAll ]
]

{ #category : #accessing }
LeImageImportVisitor >> database [
	^ database
]

{ #category : #accessing }
LeImageImportVisitor >> database: anObject [
	database := anObject
]

{ #category : #'private - attaching' }
LeImageImportVisitor >> downloadURL: aUrlString [
	"Attempt to download the supplied URL.
	If successful, answer the file reference, otherwise nil."
	| znUrl file |

	znUrl := aUrlString asZnUrl.
	(znUrl isHttp or: [ znUrl isHttps ]) ifFalse: [ ^ nil ].
	file := downloadDirectory / znUrl file.
	^ [ znUrl saveContentsToFile: file.
		file ]
			on: Error 
			do: [ :ex | failedImages at: aUrlString put: ex. nil ]
]

{ #category : #accessing }
LeImageImportVisitor >> failedImages [
	^ failedImages
]

{ #category : #ui }
LeImageImportVisitor >> gtAddedImagesFor: aView [
	<gtView>

	addedImages ifEmpty: [ ^ aView empty ].
	^ aView list 
		title: 'Added images';
		priority: 10;
		items: [ addedImages associations ];
		itemText: [ :item | item key ];
		send: [ :item | item value ]
]

{ #category : #ui }
LeImageImportVisitor >> gtFailedImagesFor: aView [
	<gtView>

	addedImages ifEmpty: [ ^ aView empty ].
	^ aView list 
		title: 'Failed images';
		priority: 11;
		items: [ failedImages associations ];
		itemText: [ :item | item key ];
		send: [ :item | item value ]
]

{ #category : #initialization }
LeImageImportVisitor >> initialize [

	super initialize.
	addedImages := Dictionary new.
	failedImages := Dictionary new.
	downloadDirectory := FileReference newTempFilePrefix: 'LeImageImport-' suffix: '-downloads'.
	downloadDirectory ensureCreateDirectory.
]

{ #category : #accessing }
LeImageImportVisitor >> rootDirectory [ 

	^ database monitor localRoot
]

{ #category : #visiting }
LeImageImportVisitor >> visitDatabase: aLeDatabase [

	self assertDatabaseOk: aLeDatabase.
	database := aLeDatabase.
	aLeDatabase pagesDo: [ :page |
		page acceptVisitor: self ].

]

{ #category : #visiting }
LeImageImportVisitor >> visitPictureSnippet: aLePictureSnippet [
	| newUrl |

	newUrl := self attachURL: aLePictureSnippet urlString.
	newUrl ifNotNil: [ aLePictureSnippet urlString: newUrl ].
	^ self visitSnippet: aLePictureSnippet 
]

{ #category : #visiting }
LeImageImportVisitor >> visitTextSnippet: aLeTextSnippet [
	| textVisitor |

	textVisitor := LeImageImportTextVisitor new 
		snippet: aLeTextSnippet;
		importer: self.
	aLeTextSnippet ast acceptVisitor: textVisitor.
	^ self visitTextualSnippet: aLeTextSnippet
]

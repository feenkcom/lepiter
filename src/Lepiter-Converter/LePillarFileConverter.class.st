"
Convert the supplied file and add it to the receivers Lepiter database.

Pillar paragraphs are converted to separate snippets.

If references to files can be found, i.e. the file exists, they are added as attachments in the db and the references updated.
"
Class {
	#name : #LePillarFileConverter,
	#superclass : #LePillarConverter,
	#instVars : [
		'pillarFileReference',
		'snippets',
		'leDatabase',
		'title'
	],
	#category : #'Lepiter-Converter'
}

{ #category : #converting }
LePillarFileConverter class >> convert: aFileReference in: aLeDatabase [

	^ self new convert: aFileReference in: aLeDatabase
]

{ #category : #converting }
LePillarFileConverter >> convert: aFileReference in: aLeDatabase [
	| newTitle newPage |

	pillarFileReference := aFileReference.
	leDatabase := aLeDatabase.
	source := aFileReference contents.
	"snippets is a Collection of LeSnippet"
	snippets := OrderedCollection new.
	self visit: (GtDocumenterParser new parse: source).
	newTitle := title ifNil: [ aFileReference basename ].
	newPage := LePage named: newTitle.
	snippets do: [ :snippet |
		newPage addBlock: snippet ].
	leDatabase addPage: newPage.
	^ newPage
]

{ #category : #private }
LePillarFileConverter >> startNewSnippet [
	"Write the contents of the output stream to a snippet, if it's not empty, and start a new snippet"
	| snippetSource |

	snippetSource := outStream contents trimBoth.
	snippetSource ifNotEmpty: [ snippets add: (LeTextBlock string: snippetSource) ].
	outStream := String new writeStream.
]

{ #category : #'visiting-annotations' }
LePillarFileConverter >> visitAnnotation: anAnnotation [

	^ (anAnnotation class = GtChangesAnnotation)
		ifTrue: [ self visitChangesAnnotation: anAnnotation ]
		ifFalse: [ super visitAnnotation: anAnnotation ].

]

{ #category : #visiting }
LePillarFileConverter >> visitChangesAnnotation: anAnnotation [
	| changesFile changesPathString |

	changesFile := pillarFileReference parent / anAnnotation pathParameterValue.
	changesFile exists ifTrue: 
		[ changesPathString := leDatabase addAttachmentByCopy: changesFile.
		outStream
			<< '{{gtChanges:';
			<< changesPathString.
		self visitDocumentGroup: anAnnotation.
		outStream
			<< '}}' ]
	ifFalse:
		[ super visitAnnotation: anAnnotation ].

]

{ #category : #'visiting-document' }
LePillarFileConverter >> visitExternalLink: aPRExternalLink [

	(aPRExternalLink reference beginsWith: 'file://') ifFalse: 
		[ ^ super visitExternalLink: aPRExternalLink ].

	"Add the code to copy the file to the db (if possible)"
	self error: 'Links to local files aren''t yet copied'.
]

{ #category : #'visiting-document' }
LePillarFileConverter >> visitFigure: aPRFigure [
	| filename fileReference filePathString |

	(aPRFigure reference beginsWith: #'file://') ifFalse: 
		[ ^ super visitFigure: aPRFigure ].
	filename := aPRFigure reference copyFrom: 8 to: aPRFigure reference size.
	fileReference := pillarFileReference parent / filename.
	fileReference exists ifFalse: 
		[ ^ super visitFigure: aPRFigure ].
	filePathString := leDatabase addAttachmentByCopy: fileReference.

	outStream << '!['.
	self visitReference: aPRFigure.
	outStream 
		<< '](file://';
		<< filePathString;
		<< ')'.

]

{ #category : #'visiting-document' }
LePillarFileConverter >> visitHeader: aPRHeader [
	"If this is a level 1 header and the title is nil:
	1. store the heading text as the page title.
	2. remove the heading from the document.
	Otherwise, place the header in its own snippet"

	(title isNil and: [ aPRHeader level = 1]) ifTrue: 
		[ title := aPRHeader text.
		^ self ].
	self startNewSnippet.
	super visitHeader: aPRHeader.
	self startNewSnippet.
]

{ #category : #'visiting-document' }
LePillarFileConverter >> visitListItem: aPRListItem [
	| listSnippet |

	super visitListItem: aPRListItem.
	"List items become the child of the previous snippet"
	self startNewSnippet.
	listSnippet := snippets removeLast.
	snippets last addBlock: listSnippet.
]

{ #category : #'visiting-document' }
LePillarFileConverter >> visitParagraph: anObject [

	super visitParagraph: anObject.
	self startNewSnippet.
]

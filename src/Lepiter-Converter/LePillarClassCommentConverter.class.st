Class {
	#name : #LePillarClassCommentConverter,
	#superclass : #LePillarConverter,
	#instVars : [
		'sourceClass',
		'leDatabase'
	],
	#category : #'Lepiter-Converter'
}

{ #category : #converting }
LePillarClassCommentConverter class >> convert: aClass in: aLeDatabase [

	^ self new convert: aClass in: aLeDatabase
]

{ #category : #converting }
LePillarClassCommentConverter >> convert: aClass in: aLeDatabase [
	| sourceString newPage |

	sourceClass := aClass.
	leDatabase := aLeDatabase.
	sourceString := aClass comment.
	self source: sourceString.
	self visit: (GtDocumenterParser new parse: sourceString).
	newPage := LePage named: sourceClass name.
	newPage addBlock: (LeTextBlock string: source asString).
	leDatabase addPage: newPage.
	^ newPage
]

{ #category : #'visiting-annotations' }
LePillarClassCommentConverter >> visitAnnotation: anAnnotation [

	^ (anAnnotation class = GtChangesAnnotation)
		ifTrue: [ self visitChangesAnnotation: anAnnotation ]
		ifFalse: [ super visitAnnotation: anAnnotation ].

]

{ #category : #visiting }
LePillarClassCommentConverter >> visitChangesAnnotation: anAnnotation [
	| changesFile changesPathString |

	self error: 'No root file directory yet'.
	"changesFile := pillarFileReference parent / anAnnotation pathParameterValue."
	changesFile exists ifTrue: 
		[ changesPathString := leDatabase addAttachmentByCopy: changesFile.
		source
			replaceFrom: anAnnotation start 
			to: anAnnotation stop 
			with: (String streamContents: [ :stream |
				stream
					<< '{{gtChanges:';
					<< changesPathString;
					<< '}}']).
		self visitDocumentGroup: anAnnotation ]
	ifFalse:
		[ super visitAnnotation: anAnnotation ].

]

{ #category : #'visiting-document' }
LePillarClassCommentConverter >> visitExternalLink: aPRExternalLink [

	(aPRExternalLink reference beginsWith: 'file://') ifFalse: 
		[ ^ super visitExternalLink: aPRExternalLink ].

	"Add the code to copy the file to the db (if possible)"
	self error: 'Links to local files aren''t yet copied'.
]

{ #category : #'visiting-document' }
LePillarClassCommentConverter >> visitFigure: aPRFigure [
	| filename fileReference filePathString labelEndIndex urlWithClose |

	self error: 'No root file directory yet'.
	(aPRFigure reference beginsWith: #'file://') ifFalse: 
		[ ^ super visitFigure: aPRFigure ].
	filename := aPRFigure reference copyFrom: 8 to: aPRFigure reference size.
	"fileReference := pillarFileReference parent / filename."
	fileReference exists ifFalse: 
		[ ^ super visitFigure: aPRFigure ].
	filePathString := leDatabase addAttachmentByCopy: fileReference.

	source
		replaceFrom: aPRFigure start
		to: aPRFigure start
		with: '!['.
	labelEndIndex := aPRFigure children 
		ifEmpty: [ aPRFigure start + 1 ]
		ifNotEmpty: [ aPRFigure children last stop + 1 ].
	source
		replaceFrom: labelEndIndex
		to: labelEndIndex
		with: ']('.
	urlWithClose := String streamContents: [ :stream |
		stream 
			<< #'file://';
			<< filePathString;
			<< ')' ].
	source
		replaceFrom: labelEndIndex + 1
		to: aPRFigure stop
		with: urlWithClose.
	self visitReference: aPRFigure.
]

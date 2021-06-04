"
Convert class comments from pillar format to lepiter format.

The conversion may be tested by setting dryRun to true, in which case the conversion answers the lepiter format string.

``` 
LePillarClassCommentConverter convert: MyOldClass dryRun: true
```

While the class comment is updated, it isn't saved externally, e.g. committed with Iceberg.

"
Class {
	#name : #LePillarClassCommentConverter,
	#superclass : #LePillarConverter,
	#instVars : [
		'sourceClass',
		'dryRun'
	],
	#category : #'Lepiter-Converter'
}

{ #category : #converting }
LePillarClassCommentConverter class >> convert: aClass [

	^ self new convert: aClass
]

{ #category : #converting }
LePillarClassCommentConverter class >> convert: aClass dryRun: aBoolean [

	^ self new 
		dryRun: aBoolean;
		convert: aClass
]

{ #category : #converting }
LePillarClassCommentConverter >> convert: aClass [
	<return: #String>
	| newSource |

	sourceClass := aClass.
	sourceClass hasComment ifFalse: [ ^ nil ].
	self source: aClass comment.
	self visit: (GtDocumenterParser new parse: source asString).
	newSource := self newSource.
	newSource = source ifTrue: [ ^ nil ].
	dryRun ifFalse: [ aClass comment: newSource ].
	^ newSource
]

{ #category : #accessing }
LePillarClassCommentConverter >> dryRun [
	^ dryRun
]

{ #category : #accessing }
LePillarClassCommentConverter >> dryRun: anObject [
	dryRun := anObject
]

{ #category : #visiting }
LePillarClassCommentConverter >> initialize [ 

	super initialize.
	dryRun := false.
]

{ #category : #'visiting-annotations' }
LePillarClassCommentConverter >> visitAnnotation: anAnnotation [

	^ (anAnnotation class = GtIcebergFileAnnotation)
		ifTrue: [ self visitIcebergFileAnnotation: anAnnotation ]
		ifFalse: [ super visitAnnotation: anAnnotation ].

]

{ #category : #visiting }
LePillarClassCommentConverter >> visitIcebergFileAnnotation: anAnnotation [
	"IcebergFile annotations are changed from:
	${icebergFile:path=repository/project/path/to/file}$
	with:
	[file](fileLocator://gtResource/repository/project/path/to/file)"
	| path basename |

	path := anAnnotation path.
	basename := path asPath basename.
	outStream
		<< '[';
		<< basename;
		<< '](fileLocator://gtResource/';
		<< path;
		<< ')'.

]

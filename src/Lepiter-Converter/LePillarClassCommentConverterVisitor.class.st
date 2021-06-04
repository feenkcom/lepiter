Class {
	#name : #LePillarClassCommentConverterVisitor,
	#superclass : #Object,
	#instVars : [
		'classFilterBlock',
		'dryRun',
		'convertedClasses'
	],
	#category : #'Lepiter-Converter'
}

{ #category : #accessing }
LePillarClassCommentConverterVisitor >> classFilterBlock [
	^ classFilterBlock
]

{ #category : #accessing }
LePillarClassCommentConverterVisitor >> classFilterBlock: anObject [
	classFilterBlock := anObject
]

{ #category : #convenience }
LePillarClassCommentConverterVisitor >> classFilterBlockRepositoryNameBeginsWith: aString [
	"Set the class filter block to select classes where the associated Iceberg repository name begins with the supplied string"

	self classFilterBlock: [ :cls | 
		((IceRepository registeredRepositoryIncludingPackage: cls package)
			ifNil: [ '' ]
			ifNotNil: [ :package | package name ]) beginsWith: aString ]
]

{ #category : #private }
LePillarClassCommentConverterVisitor >> classesToConvert [
	"Answer the collection of classes that should be converted"
	<return: #Array>

	^ Object withAllSubclasses select: classFilterBlock
]

{ #category : #corrections }
LePillarClassCommentConverterVisitor >> classesWithExampleShowEquals [
	"Lots of class comments appear to include the example key 'expandedPreview', when it should be 'previewExpanded'.
	Correct all of those with simple string replacement."
	| matchingClasses |

	matchingClasses := Object withAllSubclasses select: 
		[ :each | (each comment includesSubstring: '${example') and: [ each comment includesSubstring: '|show=' ] ].

	matchingClasses do: [ :cls |
		cls comment: (cls comment copyReplaceAll: '|show=' with: '|previewShow=') ].

	^ matchingClasses
]

{ #category : #corrections }
LePillarClassCommentConverterVisitor >> classesWithExpandedPreview [
	"Lots of class comments appear to include the example key 'expandedPreview', when it should be 'previewExpanded'.
	Correct all of those with simple string replacement."
	| matchingClasses |

	matchingClasses := Object withAllSubclasses select: 
		[ :each | each comment includesSubstring: #expandedPreview ].

	matchingClasses do: [ :cls |
		cls comment: (cls comment copyReplaceAll: #expandedPreview with: #previewExpanded) ].
]

{ #category : #running }
LePillarClassCommentConverterVisitor >> convert: aClass [
	"Convert the comment in the supplied class from pillar to lepiter.
	Note that only superficial checking is done to determine if the comment is already in lepiter format"
	<return: #String>
	| lepiterComment |

	(self isAlreadyLepiter: aClass comment) ifTrue: 
		[ self halt: 'Already converted?' ].
	lepiterComment := LePillarClassCommentConverter convert: aClass dryRun: dryRun.
	convertedClasses add: aClass.
	^ lepiterComment
]

{ #category : #accessing }
LePillarClassCommentConverterVisitor >> dryRun [
	^ dryRun
]

{ #category : #accessing }
LePillarClassCommentConverterVisitor >> dryRun: anObject [
	dryRun := anObject
]

{ #category : #initialization }
LePillarClassCommentConverterVisitor >> initialize [ 

	super initialize.
	convertedClasses := OrderedCollection new.
	classFilterBlock := [ :cls | self error: 'No filter block set' ].
	dryRun := true.
]

{ #category : #testing }
LePillarClassCommentConverterVisitor >> isAlreadyLepiter: pillarComment [
	"Answer a boolean answering true if the supplied string looks like a lepiter class comment"

	^ 'gtpage\:|gtclass\:|gtmethod\:' asRegexIgnoringCase search: pillarComment
]

{ #category : #running }
LePillarClassCommentConverterVisitor >> run [ 

	"EpMonitor disableDuring:
		[" self classesToConvert do: [ :cls |
			self convert: cls ].
		self saveConvertedClasses "]".
]

{ #category : #private }
LePillarClassCommentConverterVisitor >> saveConvertedClasses [
	"Write the converted classes out to a file"

	(DateAndTime now asIso8601, ' LePillarClassCommentConverterVisitor.txt') writeStreamDo: [ :stream |
		convertedClasses do: [ :each |
			stream 
				<< each name;
				lf ] ].
]

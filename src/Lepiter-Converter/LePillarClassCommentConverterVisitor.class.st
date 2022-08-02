Class {
	#name : #LePillarClassCommentConverterVisitor,
	#superclass : #Object,
	#instVars : [
		'classFilterBlock',
		'dryRun',
		'convertedClasses',
		'ignoredClasses'
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

{ #category : #convenience }
LePillarClassCommentConverterVisitor >> classFilterBlockRepositoryNamed: aString [
	"Set the class filter block to select classes where the associated Iceberg repository name begins with the supplied string"

	self classFilterBlock: [ :cls | 
		((IceRepository registeredRepositoryIncludingPackage: cls package)
			ifNil: [ '' ]
			ifNotNil: [ :package | package name ]) = aString ]
]

{ #category : #private }
LePillarClassCommentConverterVisitor >> classesToConvert [
	"Answer the collection of classes that should be converted"
	<return: #Array>
	| selected |

	selected := SystemNavigation default allClassesAndTraits select: classFilterBlock.
	self assert: selected size equals: selected asSet size.
	^ selected.
]

{ #category : #corrections }
LePillarClassCommentConverterVisitor >> classesWithExampleShowEquals [
	"Lots of class comments appear to include the example key 'expandedPreview', when it should be 'previewExpanded'.
	Correct all of those with simple string replacement.
	WARNING: this doesn't really work since ${class:Abc|show=#selectorFor:}$ is valid, and this changes those instances incorrectly"
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

	aClass isMeta ifTrue: [ ^ self ].
	(ignoredClasses includes: aClass) ifTrue: [ ^ self ].
	aClass hasComment ifFalse: [ ^ self ].
	(self isAlreadyLepiter: aClass comment) ifTrue: 
		[ ^ self "halt: 'Already converted?'" ].
	(self isPillar: aClass comment) ifFalse: 
		[ ^ self ].
	lepiterComment := LePillarClassCommentConverter convert: aClass dryRun: dryRun.
	convertedClasses at: aClass put: lepiterComment.
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
LePillarClassCommentConverterVisitor >> ignoredClassesCollection [
	"Answer a list of classes that shouldn't be convertd.
	These are generally classes that cause the pillar parser to go into infinite recursion"

	^ { 
		SpartaCanvas.
		SpartaFontBuilder.
		SpartaTransformationBuilder.
		DPProcessSingleFileStream.
		DPProcessCSVByRow.
	 }
]

{ #category : #initialization }
LePillarClassCommentConverterVisitor >> initialize [ 

	super initialize.
	convertedClasses := Dictionary new.
	classFilterBlock := [ :cls | self error: 'No filter block set' ].
	dryRun := true.
	ignoredClasses := self ignoredClassesCollection.
]

{ #category : #testing }
LePillarClassCommentConverterVisitor >> isAlreadyLepiter: pillarComment [
	"Answer a boolean answering true if the supplied string looks like a lepiter class comment"

	('gtpage\:|gtclass\:|gtmethod\:' asRegexIgnoringCase search: pillarComment) ifTrue: [ ^ true ].

	^ pillarComment lines 
		detect: [ :each | each trimLeft beginsWith: '#' ]
		ifFound: [ :x | true ]
		ifNone: [ false ]
]

{ #category : #testing }
LePillarClassCommentConverterVisitor >> isPillar: pillarComment [
	"Answer a boolean answering true if the supplied string looks like a Pillar class comment"

	('\$\{' asRegexIgnoringCase search: pillarComment) ifTrue: [ ^ true ].

	^ pillarComment lines 
		detect: [ :each | each trimLeft beginsWith: '!' ]
		ifFound: [ :x | true ]
		ifNone: [ false ]
]

{ #category : #running }
LePillarClassCommentConverterVisitor >> run [ 

	self classesToConvert do: [ :cls |
		self convert: cls ].
	dryRun ifFalse: [ self saveConvertedClasses ].
]

{ #category : #private }
LePillarClassCommentConverterVisitor >> saveConvertedClasses [
	"Write the converted classes out to a file"

	(DateAndTime now asIso8601, ' LePillarClassCommentConverterVisitor.txt') asFileReference writeStreamDo: [ :stream |
		convertedClasses associationsDo: [ :each |
			stream 
				<< each key name;
				lf ] ].
]

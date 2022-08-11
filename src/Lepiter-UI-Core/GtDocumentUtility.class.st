Class {
	#name : #GtDocumentUtility,
	#superclass : #Object,
	#traits : 'TLepiterConstants',
	#classTraits : 'TLepiterConstants classTrait',
	#category : #'Lepiter-UI-Core-Utility'
}

{ #category : #'pillar - parameter values' }
GtDocumentUtility class >> booleanValueOf: aString in: aDictionary emptyValue: emptyBooleanOrBlock defaultValue: defaultBooleanOrBlock [
	^ self 
		valueOf: aString
		in: aDictionary
		value: [ :aValue | (self convertToBoolean: aValue) ifNil: emptyBooleanOrBlock ]
		emptyValue: emptyBooleanOrBlock
		defaultValue: defaultBooleanOrBlock
]

{ #category : #'pillar - parameter values' }
GtDocumentUtility class >> classDefinitionsFromArray: aCollection [ 
	<return: #Array of: #RGClassDefinition>
	self 
		assert: [ aCollection notNil ]
		description: [ 'Class definitions has to be a collection' ].
	^ Array streamContents: [ :aStream |
			aCollection do: [ :eachClassName | 
				| aClassDef |
				aClassDef := GtSystemUtility classDefinitionFromString: eachClassName asString.
				aStream nextPut: aClassDef.
		] ].
]

{ #category : #accessing }
GtDocumentUtility class >> constants [
	^ LepiterConstants
]

{ #category : #'pillar - parameter values' }
GtDocumentUtility class >> convertToBoolean: aStringOrBoolean [ 
	<return: #Boolean or: nil>
	| aValue |
	aStringOrBoolean = true ifTrue: [ ^ aStringOrBoolean ].
	aStringOrBoolean = false ifTrue: [ ^ aStringOrBoolean ].
	aValue := aStringOrBoolean asString asLowercase trimBoth.
	aValue = 'true' ifTrue: [ ^ true ].
	aValue = 'false' ifTrue: [ ^ false ].
	^ nil
]

{ #category : #'text styling - nearby cursor' }
GtDocumentUtility class >> cursorNeabyInText: aBlRope forNode: aNode [
	aBlRope
		clearAttributes: aNode start
		to: aNode stop
		if: [ :eachAttribute | eachAttribute = GtHideAttribute uniqueInstance ]
]

{ #category : #'text styling - nearby cursor' }
GtDocumentUtility class >> cursorNearbyStartDistanceInText: aBlRope forNode: aNode [
	| aPosition aSeparatorPosition |
	aPosition := (aNode start - self constants cursorNearbyDistance) max: 1.
	aSeparatorPosition := aBlRope finder 
		reversed; 
		startAtPosition: aPosition; 
		pattern: [ :eachBlRope :eachIndex | 
			(eachBlRope at: eachIndex) isSeparator ];
		search.
	^ aSeparatorPosition isZero 
		ifTrue: [ aPosition ]
		ifFalse: [ aSeparatorPosition ]
]

{ #category : #'text styling - nearby cursor' }
GtDocumentUtility class >> cursorNearbyStopDistanceInText: aBlRope forNode: aNode [
	| aPosition aSeparatorPosition |
	aPosition := (aNode stop + self constants cursorNearbyDistance) min: aBlRope size.
	aSeparatorPosition := aBlRope finder 
		startAtPosition: aPosition; 
		pattern: [ :eachBlRope :eachIndex | 
			(eachBlRope at: eachIndex) isSeparator ];
		search.
	^ aSeparatorPosition isZero 
		ifTrue: [ aPosition ]
		ifFalse: [ aSeparatorPosition - 1 ]
]

{ #category : #'text styling - hide attribute' }
GtDocumentUtility class >> hideAllButLinkInText: aBlRope forAnnotation: aNode [
	"Return true if hiding action happens"
	<return: #Boolean>
	| aLinkNode |
	aLinkNode := self linkNodeForAnnotation: aNode.
	aLinkNode == aNode ifTrue: [ ^ false ].
	self hideMarkupsInText: aBlRope forAnnotation: aNode exceptOfChild: aLinkNode.
	^ true
]

{ #category : #'text styling - hide attribute' }
GtDocumentUtility class >> hideMarkupsInText: aBlRope forAnnotation: aNode exceptOfChild: aChildNode [
	self hideMarkupsInText: aBlRope start: aNode start stop: aChildNode start - 1.
	self hideMarkupsInText: aBlRope start: aChildNode stop + 1 stop: aNode stop
]

{ #category : #'text styling - hide attribute' }
GtDocumentUtility class >> hideMarkupsInText: aBlRope start: aStartIndex stop: aStopIndex [
	(aBlRope 
		from: aStartIndex
		to: aStopIndex)
			attribute: GtHideAttribute uniqueInstance.
]

{ #category : #'pillar - parameter values' }
GtDocumentUtility class >> icebergFileReferenceFrom: aString [
	<return: #FileReference>
	| aFile |
	aFile := aString asFileReference.
	aFile := aFile exists ifTrue: [ ^ aFile ].
	aFile := GtFileUtility
		fileReferenceOfFileName: aString
		relativeTo: self constants icebergRepositoriesLocation.
	aFile := aFile exists ifTrue: [ ^ aFile ].
	aFile := GtFileUtility
		fileReferenceOfFileName: aString
		relativeTo: self constants localGtDirectory.
	^ aFile
]

{ #category : #'text styling' }
GtDocumentUtility class >> linkColor: aBoolean [
	"aBoolean = true means that a link is valid.
	aBoolean = false means that a link is invalid."
	^ aBoolean 
		ifTrue: [ self constants linkColor ]
		ifFalse: [ self constants linkWithErrorColor ].
]

{ #category : #'text styling' }
GtDocumentUtility class >> linkNodeForAnnotation: aNode [
	^ self
		parameterValueNodeNamed: aNode referenceParameterName
		forAnnotation: aNode
]

{ #category : #'text styling - hide attribute' }
GtDocumentUtility class >> mayHideAllButLinkInText: aBlRope forAnnotation: aNode [
	"Return true if hiding action happens"
	<return: #Boolean>
	| aLinkNode |
	(self shouldHideMarkupsInText: aBlRope forNode: aNode) ifFalse: [ ^ false ].
	aLinkNode := self linkNodeForAnnotation: aNode.
	aLinkNode == aNode ifTrue: [ ^ false ].
	self hideMarkupsInText: aBlRope forAnnotation: aNode exceptOfChild: aLinkNode.
	^ true
]

{ #category : #'text styling - hide attribute' }
GtDocumentUtility class >> mayHideMarkupsInText: aBlRope forAnnotation: aNode exceptOfChild: aChildNode [
	"Return true if hiding action happens"
	<return: #Boolean>
	(self shouldHideMarkupsInText: aBlRope forNode: aNode) ifFalse: [ ^ false ].
	self hideMarkupsInText: aBlRope forAnnotation: aNode exceptOfChild: aChildNode.
	^ true
]

{ #category : #'text styling - hide attribute' }
GtDocumentUtility class >> mayHideMarkupsInText: aBlRope start: aStartIndex stop: aStopIndex forNode: aNode [
	"Return true if hiding action happens"
	<return: #Boolean>
	(self shouldHideMarkupsInText: aBlRope forNode: aNode) ifFalse: [ ^ false ].
	self hideMarkupsInText: aBlRope start: aStartIndex stop: aStopIndex.
	^ true
]

{ #category : #'pillar - parameter values' }
GtDocumentUtility class >> methodDefinitionsFromArray: aCollection [ 
	<return: #Array of: #RGMethodDefinition>
	| aStep anIndex |
	self 
		assert: [ aCollection notNil ]
		description: [ 'Method definitions has to be a collection' ].
	aStep := 3.
	anIndex := 1.
	^ Array streamContents: [ :aStream |
		[ anIndex + aStep - 1 <= aCollection size ] whileTrue: [ 
			| aClass aSplitter aSelector aMethodDef |
			aClass := aCollection at: anIndex.
			aSplitter := aCollection at: anIndex + 1.
			aSelector := aCollection at: anIndex + 2.
			aMethodDef := GtSystemUtility methodDefinitionFromString: aClass asString, aSplitter asString, '#', aSelector asString.
			aStream nextPut: aMethodDef.
			anIndex := anIndex + aStep.
		] ].
]

{ #category : #'pillar - parameter values' }
GtDocumentUtility class >> packageDefinitionsFromArray: aCollection [ 
	<return: #Array of: #RGPackage>
	self 
		assert: [ aCollection notNil ]
		description: [ 'Package definitions has to be a collection' ].
	^ Array streamContents: [ :aStream |
			aCollection do: [ :eachPackageName | 
				| aClassDef |
				aClassDef := GtSystemUtility packageDefinitionFromString: eachPackageName asString.
				aStream nextPut: aClassDef.
		] ].
]

{ #category : #'text styling' }
GtDocumentUtility class >> parameterValueNodeNamed: aParameterName forAnnotation: anAnnotation [
	"Return annotation's parameter AST node if exists.
	Return the given annotation otherwise"
	<return: #PRParameter or: #PRAbstractAnnotation>
	^ anAnnotation children first children
		detect: [ :eachParameter | 
			eachParameter key = aParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | aParameter valueNode ]
		ifNone: [ anAnnotation ].
]

{ #category : #'text styling - hide attribute' }
GtDocumentUtility class >> shouldHideMarkupsInText: aBlRope forNode: aNode [
	"Return true if hiding action should happen"
	<return: #Boolean>
	| aStartPosition aStopPosition |
	aStartPosition := self cursorNearbyStartDistanceInText: aBlRope forNode: aNode.
	aStopPosition := self cursorNearbyStopDistanceInText: aBlRope forNode: aNode.
	^ aNode gtDocument editor cursors
		detect: [ :eachCursor | aStartPosition <= eachCursor position and: [ eachCursor position <= aStopPosition ] ]
		ifFound: [ :aCursor | false ]
		ifNone: [ true ]
]

{ #category : #'text styling' }
GtDocumentUtility class >> shouldOpenReference: anEvent [
	^ anEvent modifiers isShift not
]

{ #category : #'text styling' }
GtDocumentUtility class >> styleLinkInText: aBlRope forAnnotationNode: aNode [
	| aNodeToStyle |
	aNodeToStyle := self linkNodeForAnnotation: aNode.
	self styleLinkInText: aBlRope forNode: aNode withLinkAt: aNodeToStyle
]

{ #category : #'text styling' }
GtDocumentUtility class >> styleLinkInText: aBlRope forNode: aNode [
	self styleLinkInText: aBlRope forNode: aNode withLinkAt: aNode
]

{ #category : #'text styling' }
GtDocumentUtility class >> styleLinkInText: aBlRope forNode: aNode start: aStartIndex stop: aStopIndex [
	| aLinkColor theAttributes |
	aLinkColor := self linkColor: aNode doesReferenceExist.
	theAttributes := Array
		with: (BlTextForegroundAttribute new paint: aLinkColor).
	aNode doesReferenceExist
		ifTrue: [ theAttributes := theAttributes
				,
					{(BrTextHoverStylableAttribute new
						attribute: (BlTextDecorationAttribute new underline color: aLinkColor)).
					(BrTextClickAttribute new
						action:
							[ :aText :aTarget :aTextEditor :anEvent | aNode browseReferenceFrom: anEvent ])} ].
	(aBlRope from: aStartIndex to: (aStartIndex max: aStopIndex))
		attributes: theAttributes
]

{ #category : #'text styling' }
GtDocumentUtility class >> styleLinkInText: aBlRope forNode: aNode withLinkAt: aLinkNode [
	self styleLinkInText: aBlRope forNode: aNode start: aLinkNode start stop: aLinkNode stop
]

{ #category : #'text styling' }
GtDocumentUtility class >> stylePreviewInText: aBlRope forNode: aNode [
	aNode isPreviewDefined ifFalse: [ ^ self ].
	(aBlRope from: aNode start to: aNode stop) attributes: aNode previewAttributes
]

{ #category : #'text styling' }
GtDocumentUtility class >> subtleMarkupsInText: aBlRope start: aStartIndex stop: aStopIndex [
	(aBlRope 
		from: aStartIndex
		to: aStopIndex)
			foreground: self constants subtleColor
]

{ #category : #'pillar - parameter values' }
GtDocumentUtility class >> valueOf: aString in: aDictionary value: aValueBlock emptyValue: anEmptyBlock defaultValue: aDefaultBlock [
	^ aDictionary
		at: aString
		ifPresent: [ :aValue | 
			(aValue isNil or: [ aValue = '' ])
				ifTrue: [ anEmptyBlock cull: aValue ] 
				ifFalse: [ aValueBlock cull: aValue ] ]
		ifAbsent: [ aDefaultBlock value ]
]

{ #category : #accessing }
GtDocumentUtility >> constants [
	^ LepiterConstants
]

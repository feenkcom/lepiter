Class {
	#name : #GtEpiceaCurrentStateVisitor,
	#superclass : #EpOldStateVisitor,
	#instVars : [
		'theEnvironment',
		'showClassNameInMethodSource'
	],
	#category : #'Lepiter-Core-Epicea'
}

{ #category : #'instance creation' }
GtEpiceaCurrentStateVisitor class >> inEnvironment: anEnvironment [

	^ self basicNew 
		initializeWith: anEnvironment;
		yourself
]

{ #category : #private }
GtEpiceaCurrentStateVisitor >> behaviorNamed: aSymbol ifPresent: presentBlock [

	^ (theEnvironment classOrTraitNamed: aSymbol) 
		ifNil: [ self ]
		ifNotNil: presentBlock
]

{ #category : #initialization }
GtEpiceaCurrentStateVisitor >> initializeWith: anEnvironment [

	self initialize.
	theEnvironment := anEnvironment.
]

{ #category : #printing }
GtEpiceaCurrentStateVisitor >> printProtocol: aProtocol behaviorName: aBehaviorName sourceCode: aSourceCode [
	^ String
		streamContents: [ :stream | 
			stream
				nextPutAll: '"protocol: ';
				nextPutAll: aProtocol printString;
				nextPut: $";
				cr;
				cr.
			self showClassNameInMethodSource
				ifTrue: [ stream
						nextPutAll: aBehaviorName;
						nextPutAll: ' >> ' ].
			stream nextPutAll: aSourceCode ]
]

{ #category : #accessing }
GtEpiceaCurrentStateVisitor >> showClassNameInMethodSource [
	^ showClassNameInMethodSource ifNil: [ true ]
]

{ #category : #accessing }
GtEpiceaCurrentStateVisitor >> showClassNameInMethodSource: aBoolean [
	showClassNameInMethodSource := aBoolean
]

{ #category : #visitor }
GtEpiceaCurrentStateVisitor >> stringForBehavior: aClassOrTrait [
	^ theEnvironment
		at: aClassOrTrait name
		ifPresent: [ :existingBehavior | self stringForExistingBehavior: existingBehavior ]
		ifAbsent: [ '' ]
]

{ #category : #visitor }
GtEpiceaCurrentStateVisitor >> stringForExistingBehavior: aClassOrTrait [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: aClassOrTrait definitionString;
			  nextPut: $.;
			  cr;
			  cr;
			  nextPutAll: aClassOrTrait classSide definitionString ]
]

{ #category : #visitor }
GtEpiceaCurrentStateVisitor >> visitBehaviorChange: aChange [
	^ self stringForBehavior: aChange behaviorAffected
]

{ #category : #visitor }
GtEpiceaCurrentStateVisitor >> visitBehaviorCommentChange: aEpBehaviorCommentChange [
	self
		behaviorNamed: aEpBehaviorCommentChange behaviorAffectedName
		ifPresent: [ :aClass | ^ aClass comment asString ].

	^ ''
]

{ #category : #visitor }
GtEpiceaCurrentStateVisitor >> visitMethodChange: aChange [
	"Addition and Modification come here"
	self 
		behaviorNamed: aChange behaviorAffectedName
		ifPresent: [ :behavior | 
			^ behavior 
				compiledMethodAt: aChange methodAffectedSelector
				ifPresent: [ :method |
					self 
						printProtocol: method protocol
						behaviorName: behavior name
						sourceCode: method sourceCode ]
				ifAbsent: [ '' ] ].
	^ '' "If class is not present"
]

{ #category : #visiting }
GtEpiceaCurrentStateVisitor >> visitMethodModification: aMethodModification [
	^ self visitMethodChange: aMethodModification
]

{ #category : #visiting }
GtEpiceaCurrentStateVisitor >> visitMethodRemoval: aMethodRemoval [
	^ self visitMethodChange: aMethodRemoval
]

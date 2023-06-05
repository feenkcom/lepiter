Class {
	#name : #LeSpecificationBuilder,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'specifications',
		'pragmaName',
		'allPragmas',
		'object'
	],
	#category : #'Lepiter-Export-Specification - Support'
}

{ #category : #'api - building' }
LeSpecificationBuilder >> collectPragmas [
	allPragmas := Pragma
			allNamed: pragmaName
			from: from
			to: to
]

{ #category : #'private - building' }
LeSpecificationBuilder >> collectSpecificationFromPragma: aPragma [ 

	| aSpecification |
	aSpecification := object perform: aPragma methodSelector.
	aSpecification ifNil: [ ^ self ].
	
	specifications addSpecification: aSpecification.
]

{ #category : #'private - building' }
LeSpecificationBuilder >> collectSpecifications [
	allPragmas do: [ :aPragma | self collectSpecificationFromPragma: aPragma ]
]

{ #category : #'api - building' }
LeSpecificationBuilder >> find [
	self collectPragmas.
	self collectSpecifications.
]

{ #category : #accessing }
LeSpecificationBuilder >> from [
	"Return a subclass where the pragma search starts"
	^ from
]

{ #category : #accessing }
LeSpecificationBuilder >> from: aSubClass [
	"Set a subclass where the pragma search starts"

	from := aSubClass
]

{ #category : #initialization }
LeSpecificationBuilder >> initialize [
	super initialize.
	pragmaName := #leExportSpecification.
	to := Object.
	specifications := LeExportSpecifications new.
]

{ #category : #'api - initialization' }
LeSpecificationBuilder >> object: anObject [
	"Set an object for which specifications will be defined"

	object := anObject
]

{ #category : #accessing }
LeSpecificationBuilder >> pragmaName [
	^ pragmaName
]

{ #category : #accessing }
LeSpecificationBuilder >> pragmaName: anObject [
	pragmaName := anObject
]

{ #category : #accessing }
LeSpecificationBuilder >> specifications [
	<return: #LeExportSpecifications>
	^ specifications
]

{ #category : #'api - initialization' }
LeSpecificationBuilder >> start: anObject [
	"Set a subclass where the pragma search starts"

	self to: Object.
	self from: anObject class.
	self object: anObject.
]

{ #category : #'api - initialization' }
LeSpecificationBuilder >> to: aSuperClass [
	"Set a superclass where the pragma search stops"

	to := aSuperClass
]

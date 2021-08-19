Class {
	#name : 'LeExplicitLinks',
	#superclass : 'LeModel',
	#instVars : [
		'uid',
		'externalLinksByUuid'
	],
	#category : 'Lepiter-Core-Links'
}

{ #category : 'adding' }
LeExplicitLinks >> addAllLinks: aCollectionOfLinks [
	self assert: [ aCollectionOfLinks notNil ].
	
	aCollectionOfLinks do: [ :aLink |
		self addLink: aLink ]
]

{ #category : 'adding' }
LeExplicitLinks >> addLink: aLink [
	self assert: [ aLink notNil ].
	self assert: [ aLink linkUuid notNil ] description: 'Here links should have a unique id'.
	self assert: [ (self hasExplicitLinkUID: aLink linkUuid) not ].
	
	externalLinksByUuid at: aLink linkUuid put: aLink
]

{ #category : 'accessing' }
LeExplicitLinks >> anyOne [
	^ externalLinksByUuid anyOne
]

{ #category : 'enumerating' }
LeExplicitLinks >> anySatisfy: aBlock [ 
	^ externalLinksByUuid anySatisfy: aBlock 
]

{ #category : 'accessing' }
LeExplicitLinks >> at: aLinkUuid ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	self assert: [ aLinkUuid notNil ].
	
	^ externalLinksByUuid 
		at: aLinkUuid 
		ifPresent: aPresentBlock 
		ifAbsent: anAbsentBlock
]

{ #category : 'private-for tests' }
LeExplicitLinks >> clearUid [
	uid := nil
]

{ #category : 'mimic various enumerating' }
LeExplicitLinks >> collect: aBlock as: aClass [
	^ externalLinksByUuid collect: aBlock as: aClass
]

{ #category : 'copying' }
LeExplicitLinks >> copyForSavingOnlyWithAttachedLinks [
	^ self class new
		uid: self uid;
		items: (self items select: [ :anExplicitLink | 
			anExplicitLink isAttachedLink ])
]

{ #category : 'accessing' }
LeExplicitLinks >> count: aBlock [ 
	^ externalLinksByUuid count: aBlock 
]

{ #category : 'enumerating' }
LeExplicitLinks >> detect: aBlock [
	^ externalLinksByUuid detect: aBlock
]

{ #category : 'enumerating' }
LeExplicitLinks >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	^ externalLinksByUuid detect: aBlock ifFound: foundBlock ifNone: exceptionBlock
]

{ #category : 'enumerating' }
LeExplicitLinks >> do: aBlock [
	externalLinksByUuid do: aBlock
]

{ #category : 'accessing' }
LeExplicitLinks >> first [ 	
	externalLinksByUuid emptyCheck.
	externalLinksByUuid do: [ :each | ^ each ].
]

{ #category : 'gt-extensions' }
LeExplicitLinks >> gtViewExplicitLinksFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Explicit links';
		items: [ self items ];
		priority: 10;
		column: 'Type' text: [ :anExplicitLink | 
			anExplicitLink class ] weight: 0.5;
		column: 'Origin' text: [ :anExplicitLink | 
			anExplicitLink originReference description ];
		column: 'Target' text: [ :anExplicitLink | 
			anExplicitLink targetReference description ]
]

{ #category : 'testing' }
LeExplicitLinks >> hasExplicitLinkUID: aUUID [
	^ externalLinksByUuid includesKey: aUUID
	
]

{ #category : 'accessing' }
LeExplicitLinks >> ifEmpty: aBlock [
	^ externalLinksByUuid ifEmpty: aBlock
]

{ #category : 'initialization' }
LeExplicitLinks >> initialize [
	super initialize.
	externalLinksByUuid := OrderedDictionary new.
]

{ #category : 'testing' }
LeExplicitLinks >> isEmpty [
	^ externalLinksByUuid isEmpty
]

{ #category : 'testing' }
LeExplicitLinks >> isNotEmpty [
	^ externalLinksByUuid isNotEmpty
]

{ #category : 'accessing' }
LeExplicitLinks >> items [
	^ externalLinksByUuid 
		ifNil: [ #() ] 
		ifNotNil: [ externalLinksByUuid values ]
]

{ #category : 'accessing' }
LeExplicitLinks >> items: aCollection [
	"I am utility method for the JSON export"
	self addAllLinks: aCollection
]

{ #category : 'accessing' }
LeExplicitLinks >> linkWithUuid: anUuid [
	^ externalLinksByUuid at: anUuid
]

{ #category : 'testing' }
LeExplicitLinks >> notEmpty [
	^ externalLinksByUuid notEmpty
]

{ #category : 'printing' }
LeExplicitLinks >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: externalLinksByUuid size asString;
		nextPutAll: ')'
]

{ #category : 'removing' }
LeExplicitLinks >> remove: anExplicitLink ifAbsent: aBlock [
	^ externalLinksByUuid 
		removeKey: anExplicitLink linkUuid 
		ifAbsent: aBlock
]

{ #category : 'removing' }
LeExplicitLinks >> removeAll: aCollectionOfLinks [ 
	aCollectionOfLinks do: [ :anExplicitLink |
		externalLinksByUuid 
			removeKey: anExplicitLink linkUuid 
			ifAbsent: [  "ignore absent links" ] ]
]

{ #category : 'enumerating' }
LeExplicitLinks >> select: aBlock [ 
	^ self class new
		addAllLinks: (externalLinksByUuid select: aBlock)
]

{ #category : 'accessing' }
LeExplicitLinks >> size [ 	
	^ externalLinksByUuid size
]

{ #category : 'accessing' }
LeExplicitLinks >> title [ 	
	^ 'Explicit links -', self uid asString
]

{ #category : 'accessing' }
LeExplicitLinks >> uid [
	^ uid
]

{ #category : 'accessing' }
LeExplicitLinks >> uid: anUuid [
	self assert: [ anUuid notNil ].
	self assert: [ uid isNil ].
	
	uid := anUuid
]

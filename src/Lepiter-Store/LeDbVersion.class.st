"
LeDbVersion holds a Lepiter database schema version.

The major version number tends to change when the underlying representation changes, e.g.:

V1 = Roam JSON
V2 = STON 
V3 = Lepiter JSON V3

The minor version is changed whenever the on-disk representation of an item changes, e.g. page type.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	major:		<Integer>
	minor:		<Integer>


### Implementation Points

"
Class {
	#name : #LeDbVersion,
	#superclass : #Magnitude,
	#instVars : [
		'major',
		'minor'
	],
	#category : 'Lepiter-Store-LocalJSON-Store'
}

{ #category : #'instance creation' }
LeDbVersion class >> fromString: aString [ 

	^ self new fromString: aString
]

{ #category : #'instance creation' }
LeDbVersion class >> major: majorNumber minor: minorNumber [

	^ self new
		major: majorNumber;
		minor: minorNumber
]

{ #category : #testing }
LeDbVersion >> < aLeDbVersion [

	^ self major < aLeDbVersion major or:
		[ self major = aLeDbVersion major and:
			[ self minor < aLeDbVersion minor ] ]
]

{ #category : #comparing }
LeDbVersion >> = anObject [

	^ self class = anObject class and: [ 
		self major = anObject major and: [ 
		self minor = anObject minor ] ]
]

{ #category : #'instance creation' }
LeDbVersion >> fromString: aString [ 
	| re |

	re := 'V?(\d+)(\.(\d+))?' asRegex.
	(re matches: aString) ifFalse:
		[ self error: 'Unable to parse schema version' ].
	major := (re subexpression: 2) asNumber.
	minor := (re subexpression: 3) 
					ifNil: [ 0 ]
					ifNotNil: [ :minorString | minorString allButFirst asNumber ].
]

{ #category : #comparing }
LeDbVersion >> hash [ 

	^ major hash bitXor: minor hash
]

{ #category : #operations }
LeDbVersion >> incrementMinorVersionNumber [ 
	"Answer a new instance of the receiver with the minor version number incremented by 1"

	^ self class new
		major: major;
		minor: minor + 1;
		yourself.
]

{ #category : #accessing }
LeDbVersion >> major [
	^ major
]

{ #category : #accessing }
LeDbVersion >> major: anObject [
	major := anObject
]

{ #category : #accessing }
LeDbVersion >> minor [
	^ minor
]

{ #category : #accessing }
LeDbVersion >> minor: anObject [
	minor := anObject
]

{ #category : #printing }
LeDbVersion >> printOn: aStream [

	aStream
		print: major;
		nextPut: $.;
		print: minor
]

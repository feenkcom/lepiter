Class {
	#name : #LeUnknownParsedObject,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #'instance creation' }
LeUnknownParsedObject class >> forMap: aDictionary [
	^ self new 
		initializeForMap: aDictionary
]

{ #category : #views }
LeUnknownParsedObject >> gtViewMapFor: aView [
	<gtView>
	map ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Attributes Map';
		items: [ map associations ];
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]
]

{ #category : #initialization }
LeUnknownParsedObject >> initializeForMap: aDictionary [ 
	map := aDictionary
]

{ #category : #accessing }
LeUnknownParsedObject >> map [
	^ map
]

{ #category : #printing }
LeUnknownParsedObject >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		map 
			at:'__type' 
			ifPresent: [ :aTitle |
				aStream 
					nextPutAll:'__type: ';

					nextPutAll: aTitle ] 
			ifAbsent: [ '<missing type>' ] ]
]

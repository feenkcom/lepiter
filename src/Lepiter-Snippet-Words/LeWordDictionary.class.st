Class {
	#name : #LeWordDictionary,
	#superclass : #Object,
	#instVars : [
		'lock',
		'results',
		'requests',
		'currentRequest'
	],
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #api }
LeWordDictionary >> emptyRequests [
	lock critical: [ requests := OrderedCollection new ]
]

{ #category : #'initialize-release' }
LeWordDictionary >> initialize [
	super initialize.
	lock := Mutex new.
	results := Dictionary new.
	requests := OrderedCollection new
]

{ #category : #api }
LeWordDictionary >> lookup: aString [
	| result |
	result := lock critical: [ results at: aString ifAbsent: [  ] ].
	result isNil
		ifTrue:
			[ result := (LeWordClient sync)
				explanation: aString;
				response.
			lock critical: [ results at: aString put: result ] ].
	^ result
]

{ #category : #api }
LeWordDictionary >> lookup: aString do: aBlock [
	self processRequest: aString do: aBlock
]

{ #category : #private }
LeWordDictionary >> processNextRequest [
	| entry |
	lock critical: [ (currentRequest isNil and: [ requests notEmpty ]) ifTrue: [ entry := requests removeFirst ] ].
	entry ifNotNil: [ self processRequest: entry first do: entry last ]
]

{ #category : #private }
LeWordDictionary >> processRequest: aString do: aBlock [
	| result |
	lock
		critical:
			[ result := results at: aString ifAbsent: [  ].
			result
				ifNil:
					[ currentRequest notNil
						ifTrue:
							[ requests
								add:
									{aString.
										aBlock} ]
						ifFalse:
							[ (currentRequest := LeWordClient future)
								onResponse:
										[ :each | 
											lock
												critical:
													[ currentRequest := nil.
													results at: aString put: each.
													self processNextRequest ].
											aBlock cull: each cull: aString ];
								explanation: aString ] ] ].
	self processNextRequest.
	result ifNotNil: [ aBlock cull: result cull: aString ]
]

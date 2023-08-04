Class {
	#name : #LePageModifiedAfterFilter,
	#superclass : #LeFilter,
	#instVars : [
		'date',
		'dateString'
	],
	#category : #'Lepiter-Core-Database - Filters'
}

{ #category : #accessing }
LePageModifiedAfterFilter class >> filterDescriptorFor: aLeDatabase do: aBlock [
	| dates |
	dates := GtPrefixTree new.
	aLeDatabase pages
		do: [ :each | 
			each latestEditTime
				ifNotNil: [ :leTime | dates add: leTime time asDate printString ] ].
	aBlock
		value:
			(GtFilterDescriptor
				creator: [ :value | self new dateString: value ]
				named: 'Edited after'
				order: 12
				completion: (GtStringsCompletionStrategy new completions: dates)).
	aBlock
		value:
			(GtFilterDescriptor
				creator: [ :value | (self new dateString: value) not ]
				named: 'Edited before'
				order: 12
				completion: (GtStringsCompletionStrategy new completions: dates))
]

{ #category : #accessing }
LePageModifiedAfterFilter >> date [
	^ date
		ifNil: [ date := [ DateAndTime fromString: dateString ]
				on: Error
				do: [ :ex | ex return: DateAndTime now ] ]
]

{ #category : #accessing }
LePageModifiedAfterFilter >> dateString [
	^ dateString
]

{ #category : #accessing }
LePageModifiedAfterFilter >> dateString: aString [
	dateString := aString.
	date := nil
]

{ #category : #testing }
LePageModifiedAfterFilter >> matches: aLeContent [
	^ aLeContent editOrCreateTime
		ifNil: [ false ]
		ifNotNil: [ :leTime | leTime time >= self date ]
]

{ #category : #printing }
LePageModifiedAfterFilter >> printOn: aStream [
	aStream
		nextPutAll: 'Modified After ';
		nextPutAll: self dateString
]

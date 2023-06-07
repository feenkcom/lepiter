Class {
	#name : #LeExportGroupedLog,
	#superclass : #Object,
	#instVars : [
		'type',
		'children'
	],
	#category : #'Lepiter-Export-Log - Support'
}

{ #category : #'instance creation' }
LeExportGroupedLog class >> log: aLog groupedBy: aBlock [
	| aDictionary |
	aDictionary := aLog asArray groupedBy: aBlock.
	
	^ Array streamContents: [ :aStream | 
		aDictionary keysAndValuesDo: [ :aType :aLogItems | 
			| aChildren anInstance |
			aChildren := aLogItems collect: [ :each | 
				LeExportGroupedLogChild new 
					logItem: each ].
			
			anInstance := self new 
				type: aType;
				children: aChildren.
				
			aStream nextPut: anInstance
	] ]
]

{ #category : #accessing }
LeExportGroupedLog >> children [
	^ children
]

{ #category : #accessing }
LeExportGroupedLog >> children: anObject [
	children := anObject
]

{ #category : #accessing }
LeExportGroupedLog >> description [
	^ String
		streamContents: [ :aStream | 
			aStream
				print: children size;
				nextPutAll: (' log item' asPluralBasedOn: children size) ]
]

{ #category : #'gt - extensions' }
LeExportGroupedLog >> gtLogItemsFor: aView [
	<gtView>
	children ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Log';
		priority: 10;
		items: [ children reversed ];
		column: 'Index'
			text: [ :_ :anIndex | children size - anIndex + 1 ]
			width: 40;
		column: 'Name' text: #label;
		column: 'Description'
			text: #description
			weight: 3
]

{ #category : #accessing }
LeExportGroupedLog >> label [
	^ self name
]

{ #category : #accessing }
LeExportGroupedLog >> name [
	^ self type asString
]

{ #category : #accessing }
LeExportGroupedLog >> object [
	^ self
]

{ #category : #accessing }
LeExportGroupedLog >> type [
	^ type
]

{ #category : #accessing }
LeExportGroupedLog >> type: anObject [
	type := anObject
]

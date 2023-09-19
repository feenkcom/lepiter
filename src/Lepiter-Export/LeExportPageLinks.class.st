Class {
	#name : #LeExportPageLinks,
	#superclass : #Object,
	#instVars : [
		'links',
		'sortedLinks'
	],
	#category : #'Lepiter-Export-Page Links - Model'
}

{ #category : #'instance creation' }
LeExportPageLinks class >> withAll: aCollection [
	^ self new initializeLinks: aCollection asArray
]

{ #category : #enumerating }
LeExportPageLinks >> do: aBlock [
	self links do: aBlock
]

{ #category : #accessing }
LeExportPageLinks >> gtLinksFor: aView [
	<gtView>
	self links ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Sorted links';
		priority: 10;
		items: [ self sortedLinks ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Page Title' text: #pageTitle;
		column: 'File Name' text: #fileNameWithExtension
]

{ #category : #initialization }
LeExportPageLinks >> initializeLinks: anArray [
	links := anArray asArray.
	sortedLinks := nil.
]

{ #category : #enumerating }
LeExportPageLinks >> linkForPage: aPage ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self links
		detect: [ :eachLink | eachLink page = aPage ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #enumerating }
LeExportPageLinks >> linkTitled: aPageTitle ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self links
		detect: [ :eachLink | eachLink pageTitle = aPageTitle ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
LeExportPageLinks >> links [
	^ links
]

{ #category : #printing }
LeExportPageLinks >> printOn: aStream [
	super printOn: aStream.

	links ifNil: [ ^ self ].

	aStream
		space;
		nextPut: $[;
		print: links size;
		nextPutAll: (' item' asPluralBasedOn: links size);
		nextPut: $]
]

{ #category : #accessing }
LeExportPageLinks >> sortedLinks [
	^ sortedLinks ifNil: [ sortedLinks := self links 
			sorted: [ :a :b | 
				a isMainPage asBit > b isMainPage asBit
					or: [ a isMainPage = b isMainPage and: [ a pageTitle < b pageTitle ] ] ] ]
]

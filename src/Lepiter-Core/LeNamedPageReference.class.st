Class {
	#name : #LeNamedPageReference,
	#superclass : #Object,
	#instVars : [
		'databaseName',
		'pageTitle'
	],
	#category : #'Lepiter-Core-Utility'
}

{ #category : #'instance creation' }
LeNamedPageReference class >> databaseName: aDatabaseName pageTitle: aPageTitle [

	^ self new setDatabaseName: aDatabaseName pageTitle: aPageTitle

]

{ #category : #comparing }
LeNamedPageReference >> = anObject [

	^ self class = anObject class and: [
		databaseName = anObject databaseName and: [
			pageTitle = anObject pageTitle ] ]

]

{ #category : #accessing }
LeNamedPageReference >> databaseName [

	^ databaseName

]

{ #category : #accessing }
LeNamedPageReference >> defaultKnowledgeBase [

	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase

]

{ #category : #'gt - extensions' }
LeNamedPageReference >> gtLiveFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Reference';
		priority: 10;
		items: [ Array
			with: 'Database' -> databaseName
			with: 'Page' -> pageTitle
			with: 'Found' -> (self hasPage ifTrue: [ 'yes' ] ifFalse: [ 'no, not in the default knowledge base' ]) ];
		column: 'Attribute' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		actionUpdateButton

]

{ #category : #testing }
LeNamedPageReference >> hasPage [

	^ self pageIfFound: [ :aPage | true ] ifNone: [ false ]

]

{ #category : #comparing }
LeNamedPageReference >> hash [

	^ databaseName hash bitXor: pageTitle hash

]

{ #category : #accessing }
LeNamedPageReference >> knowledgeBaseFor: anElement [

	^ anElement space
		ifNil: [ self defaultKnowledgeBase ]
		ifNotNil: [ :aSpace | aSpace knowledgeBaseIfNone: [ self defaultKnowledgeBase ] ]

]

{ #category : #accessing }
LeNamedPageReference >> pageFor: anElement ifFound: aFoundBlock ifNone: aNoneBlock [

	^ self
		pageIn: (self knowledgeBaseFor: anElement)
		ifFound: aFoundBlock
		ifNone: aNoneBlock

]

{ #category : #accessing }
LeNamedPageReference >> pageIfFound: aFoundBlock ifNone: aNoneBlock [

	^ self
		pageIn: self defaultKnowledgeBase
		ifFound: aFoundBlock
		ifNone: aNoneBlock

]

{ #category : #accessing }
LeNamedPageReference >> pageIn: aLogicalDatabase ifFound: aFoundBlock ifNone: aNoneBlock [

	^ (aLogicalDatabase databases
		detect: [ :each | each databaseName = databaseName ]
		ifNone: [ nil ])
			ifNil: aNoneBlock
			ifNotNil: [ :aDatabase |
				aDatabase
					pageNamed: pageTitle
					ifPresent: aFoundBlock
					ifAbsent: aNoneBlock ]

]

{ #category : #accessing }
LeNamedPageReference >> pageTitle [

	^ pageTitle

]

{ #category : #printing }
LeNamedPageReference >> printOn: aStream [

	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: 'page ';
			print: pageTitle;
			nextPutAll: ' in ';
			print: databaseName ]

]

{ #category : #initialization }
LeNamedPageReference >> setDatabaseName: aDatabaseName pageTitle: aPageTitle [

	databaseName := aDatabaseName.
	pageTitle := aPageTitle

]

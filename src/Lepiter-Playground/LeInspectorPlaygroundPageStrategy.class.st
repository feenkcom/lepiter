Class {
	#name : #LeInspectorPlaygroundPageStrategy,
	#superclass : #Object,
	#category : #'Lepiter-Playground'
}

{ #category : #accessing }
LeInspectorPlaygroundPageStrategy >> createNewPageForObject: anObject [

	^ self subclassResponsibility
]

{ #category : #accessing }
LeInspectorPlaygroundPageStrategy >> ensurePlaygroundPageInDatabase: aDatabase forObject: anObject [
	^ aDatabase
		at: (self pageDatabaseKeyBasedOnObject: anObject)
		ifPresent: [ :aPage | aPage ]
		ifAbsent: [ | page |
			page := self createNewPageForObject: anObject.
			aDatabase addPage: page.
			page ]
		forPageType: self playgroundPageType
]

{ #category : #accessing }
LeInspectorPlaygroundPageStrategy >> pageDatabaseKeyBasedOnObject: anObject [ 

	^ self subclassResponsibility
]

{ #category : #accessing }
LeInspectorPlaygroundPageStrategy >> playgroundPageType [

	^ self subclassResponsibility
]

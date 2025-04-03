Class {
	#name : #LeInspectorPlaygroundPageStrategy,
	#superclass : #Object,
	#category : #'Lepiter-Playground'
}

{ #category : #accessing }
LeInspectorPlaygroundPageStrategy >> configureExistingPage: aPage forObject: anObject [

	^ self subclassResponsibility
]

{ #category : #accessing }
LeInspectorPlaygroundPageStrategy >> createNewPageForObject: anObject [

	^ self subclassResponsibility
]

{ #category : #accessing }
LeInspectorPlaygroundPageStrategy >> ensurePlaygroundPageInDatabase: aDatabase forObject: anObject [
	^ aDatabase
		at: (self pageDatabaseKeyBasedOnObject: anObject)
		ifPresent: [ :aPage | 
			self configureExistingPage: aPage forObject: anObject.
			aPage ]
		ifAbsent: [ 
			| newPage |
			newPage := self createNewPageForObject: anObject.
			aDatabase addPage: newPage.
			newPage ]
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

"
I am an abstract class.
I provide basic {{gtMethod:LeDatabaseElement>>#database|label=#selector}} accessors.
See my {{gtClass:LeDatabaseElement|expanded|show=#gtSubclassesFor:}} for concrete implementations:

"
Class {
	#name : #LeDatabaseElement,
	#superclass : #LeContentElement,
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #'api - accessing' }
LeDatabaseElement >> database [
	<return: #LeDatabase>

	^ self content
]

{ #category : #'api - accessing' }
LeDatabaseElement >> databaseViewModel [
	^ self contentUIModel
]

{ #category : #'api - accessing' }
LeDatabaseElement >> databaseViewModel: aDatabaseUIModel [
	self contentUIModel: aDatabaseUIModel
]

{ #category : #testing }
LeDatabaseElement >> hasDatabase [
	<return: #Boolean>

	^ self hasContent
]

{ #category : #'api - accessing' }
LeDatabaseElement >> pages [
	<return: #Collection of: #LePage>
	^ self database pages
]

{ #category : #'api - accessing' }
LeDatabaseElement >> pagesByDate [
	<return: #Collection of: #LePage>
	^ self database pagesByDate
]

{ #category : #accessing }
LeDatabaseElement >> pagesByDateToShow [
	^ self database pagesByDateToShow
]

{ #category : #'api - accessing' }
LeDatabaseElement >> tableOfContents [
	^ self database tableOfContents
]

{ #category : #'api - accessing' }
LeDatabaseElement >> tableOfContentsDo: aBlock [
	self tableOfContents ifNotNil: aBlock
]

Class {
	#name : #LeRestPage,
	#superclass : #Object,
	#instVars : [
		'page',
		'node'
	],
	#category : #'Lepiter-Utilities-ToC'
}

{ #category : #'api - enumerating' }
LeRestPage >> allChildrenDepthFirstDo: aBlock [
	"There are no children to enumerate"
]

{ #category : #converting }
LeRestPage >> asContentUIModel [
	<return: #LeContentViewModel>

	^ LePageViewModel new page: self
]

{ #category : #'private - accessing' }
LeRestPage >> childrenSizeString [
	^ self node
		ifNotNil: [ :aNode | aNode children size asString ] 
		ifNil: [ '?' ]
]

{ #category : #accessing }
LeRestPage >> database [
	"Requiered ${method:LePageElement>>#unsubscribeFromContent}$"
	^ self page database
]

{ #category : #accessing }
LeRestPage >> editEmail [
	^ nil
]

{ #category : #accessing }
LeRestPage >> editOrCreateEmail [
	<return: #LeEmail>

	^ self editEmail
]

{ #category : #accessing }
LeRestPage >> latestEditTime [
	^ nil
]

{ #category : #accessing }
LeRestPage >> node [
	^ node
]

{ #category : #accessing }
LeRestPage >> node: anObject [
	node := anObject
]

{ #category : #accessing }
LeRestPage >> page [
	^ page
]

{ #category : #accessing }
LeRestPage >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeRestPage >> title [
	^ self childrenSizeString, ' Unclassified Pages'
]

{ #category : #'announcer - subscription' }
LeRestPage >> weak [
	"Required by ${method:LePageTitleAndEditInfoElement>>#subscribeToContent}$"
	^ self page weak
]

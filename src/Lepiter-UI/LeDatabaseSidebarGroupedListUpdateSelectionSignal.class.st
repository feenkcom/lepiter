Class {
	#name : #LeDatabaseSidebarGroupedListUpdateSelectionSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'page',
		'groupDomainObject',
		'navigationModel',
		'groupedItems'
	],
	#category : #'Lepiter-UI-Beacon'
}

{ #category : #accessing }
LeDatabaseSidebarGroupedListUpdateSelectionSignal >> groupDomainObject [
	^ groupDomainObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListUpdateSelectionSignal >> groupDomainObject: anObject [
	groupDomainObject := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListUpdateSelectionSignal >> groupedItems [
	^ groupedItems
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListUpdateSelectionSignal >> groupedItems: anObject [
	groupedItems := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListUpdateSelectionSignal >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListUpdateSelectionSignal >> navigationModel: anObject [
	navigationModel := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListUpdateSelectionSignal >> page [
	^ page
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListUpdateSelectionSignal >> page: anObject [
	page := anObject
]

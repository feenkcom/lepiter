Class {
	#name : #LeDatabaseSidebarGroupedListScrolledToIndexSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'page',
		'pageIndex',
		'groupDomainObject',
		'navigationModel',
		'groupedItems'
	],
	#category : #'Lepiter-UI-Beacon'
}

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> groupDomainObject [
	^ groupDomainObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> groupDomainObject: anObject [
	groupDomainObject := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> groupedItems [
	^ groupedItems
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> groupedItems: anObject [
	groupedItems := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> navigationModel: anObject [
	navigationModel := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> page [
	^ page
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> pageIndex [
	^ pageIndex
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListScrolledToIndexSignal >> pageIndex: anObject [
	pageIndex := anObject
]

Class {
	#name : #LeDatabaseSidebarScrollToPageData,
	#superclass : #Object,
	#instVars : [
		'page',
		'pageIndex',
		'groupDomainObject',
		'navigationModel'
	],
	#category : #'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #accessing }
LeDatabaseSidebarScrollToPageData >> groupDomainObject [
	^ groupDomainObject
]

{ #category : #accessing }
LeDatabaseSidebarScrollToPageData >> groupDomainObject: anObject [
	groupDomainObject := anObject
]

{ #category : #accessing }
LeDatabaseSidebarScrollToPageData >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarScrollToPageData >> navigationModel: anObject [
	navigationModel := anObject
]

{ #category : #accessing }
LeDatabaseSidebarScrollToPageData >> page [
	^ page
]

{ #category : #accessing }
LeDatabaseSidebarScrollToPageData >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeDatabaseSidebarScrollToPageData >> pageIndex [
	^ pageIndex
]

{ #category : #accessing }
LeDatabaseSidebarScrollToPageData >> pageIndex: anObject [
	pageIndex := anObject
]

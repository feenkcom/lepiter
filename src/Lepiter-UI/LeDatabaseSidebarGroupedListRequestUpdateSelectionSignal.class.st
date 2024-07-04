Class {
	#name : #LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'navigationModel',
		'groupedItems'
	],
	#category : #'Lepiter-UI-Beacon'
}

{ #category : #accessing }
LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal >> groupedItems [
	^ groupedItems
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal >> groupedItems: anObject [
	groupedItems := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal >> navigationModel: anObject [
	navigationModel := anObject
]

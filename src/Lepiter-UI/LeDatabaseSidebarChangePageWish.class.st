"
I inform the page tool that a selection in {{gtClass:LeDatabaseSidebarElement}} was changed and a user wants to see another {{gtClass:LePage}}. 

I should not be used for selection outside of that context. For selections in views of the sidebar element, {{gtClass:LeUIPageSelectionRequest}} should be used instead.
"
Class {
	#name : #LeDatabaseSidebarChangePageWish,
	#superclass : #BrWish,
	#instVars : [
		'pageUIModel'
	],
	#category : #'Lepiter-UI-Basic - Events'
}

{ #category : #accessing }
LeDatabaseSidebarChangePageWish >> pageUIModel [
	^ pageUIModel
]

{ #category : #accessing }
LeDatabaseSidebarChangePageWish >> pageUIModel: anObject [
	pageUIModel := anObject
]

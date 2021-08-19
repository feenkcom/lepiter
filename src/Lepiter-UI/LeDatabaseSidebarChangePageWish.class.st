"
I inform that a selection in {{gtClass:LeDatabasePageListElement}} was changed and a user wants to see another {{gtClass:LePage}}. 

I am used by {{gtClass:LeDatabasePageListElement}} and by {{gtClass:LePageToolElement}}.


"
Class {
	#name : 'LeDatabaseSidebarChangePageWish',
	#superclass : 'BrWish',
	#instVars : [
		'pageUIModel'
	],
	#category : 'Lepiter-UI-Basic - Events'
}

{ #category : 'accessing' }
LeDatabaseSidebarChangePageWish >> pageUIModel [
	^ pageUIModel
]

{ #category : 'accessing' }
LeDatabaseSidebarChangePageWish >> pageUIModel: anObject [
	pageUIModel := anObject
]

"
I inform that a selection in ${class:LeDatabasePageListElement}$ was changed and a user wants to see another ${class:LePage}$. 

I am used by ${class:LeDatabasePageListElement}$ and by ${class:LePageToolElement}$.

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

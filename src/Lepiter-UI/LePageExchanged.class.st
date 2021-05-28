"
I am fired when a ${class:LePageElement}$ changes its ${method:LePageElement>>#page|label=#selector}$.
I am fired in certain situations when a ${class:LePageElement}$ can change its ${class:LePage}$ and needs to inform its  ${class:LePageElement}$ parents. For example, when a page ${method:LePage>>#removeSelf|label=is removed}$ by clicking on a remove button in ${class:LePageToolContentElement}$, its parent ${class:LePageToolElement}$ needs to be informed too. See ${method:LePageElement>>#selectNewPageIn:ifDisplaying:|expanded=true}$. 
"
Class {
	#name : #LePageExchanged,
	#superclass : #BlEvent,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-UI-Basic - Events'
}

{ #category : #initialization }
LePageExchanged >> initialize [
	super initialize.
	page := LePage null.
]

{ #category : #accessing }
LePageExchanged >> page [
	^ page
]

{ #category : #accessing }
LePageExchanged >> page: anObject [
	page := anObject
]

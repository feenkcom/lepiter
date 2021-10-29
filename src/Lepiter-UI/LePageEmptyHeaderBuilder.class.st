Class {
	#name : #LePageEmptyHeaderBuilder,
	#superclass : #LePageHeaderBuilder,
	#category : 'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageEmptyHeaderBuilder >> build [
	self removeAllItems.
]

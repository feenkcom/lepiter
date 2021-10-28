Class {
	#name : #LeIncomingReferencesTool,
	#superclass : #LePhlowTool,
	#instVars : [
		'appliedFilter'
	],
	#category : 'Lepiter-UI-Phlow Tools'
}

{ #category : #'instance creation' }
LeIncomingReferencesTool class >> appliedFilter: aLePageReferencesFilter [
	^ self new
		appliedFilter: aLePageReferencesFilter;
		yourself
]

{ #category : #accessing }
LeIncomingReferencesTool >> appliedFilter [
	^ appliedFilter
]

{ #category : #accessing }
LeIncomingReferencesTool >> appliedFilter: anObject [
	appliedFilter := anObject
]

{ #category : #'api - converting' }
LeIncomingReferencesTool >> asElementDo: aBlock [
	| element |
	element := LeDatabaseFilteredCardElement new.
	element userData
		at: #leReferencedPages
		put:
			(self appliedFilter database
				pageNamed: self appliedFilter filter title).
	element
		hMatchParent;
		vFitContent;
		appliedFilter: self appliedFilter.
	^ aBlock
		value:
			(element asScrollableElement
				margin: (BlInsets all: 10);
				yourself)
]

{ #category : #'api - accessing' }
LeIncomingReferencesTool >> object [
	^ self appliedFilter
]

{ #category : #'api - accessing' }
LeIncomingReferencesTool >> title [
	^ 'Filter'
]

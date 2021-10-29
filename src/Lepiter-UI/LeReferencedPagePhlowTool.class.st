Class {
	#name : #LeReferencedPagePhlowTool,
	#superclass : #LePagePhlowTool,
	#instVars : [
		'referencedPage'
	],
	#category : 'Lepiter-UI-Phlow Tools'
}

{ #category : #accessing }
LeReferencedPagePhlowTool >> asElementDo: aOneArgBlock [
	^ super
		asElementDo: [ :element | 
			element userData at: #leReferencedPage put: referencedPage.
			aOneArgBlock value: element ]
]

{ #category : #accessing }
LeReferencedPagePhlowTool >> referencedPage [
	^ referencedPage
]

{ #category : #accessing }
LeReferencedPagePhlowTool >> referencedPage: aLePage [
	referencedPage := aLePage
]

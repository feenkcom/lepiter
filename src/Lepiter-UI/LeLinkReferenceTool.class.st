Class {
	#name : #LeLinkReferenceTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'linkReferenceViewModel'
	],
	#category : 'Lepiter-UI-! Link Reference'
}

{ #category : #'api - converting' }
LeLinkReferenceTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	| anElement |
	anElement := LeLinkReferenceElement new
		linkReferenceViewModel: self linkReferenceViewModel.
	^ aOneArgBlock cull: anElement.
]

{ #category : #'api - accessing' }
LeLinkReferenceTool >> icon [
	"Return a tool icon"
	<return: #BlElement>
	^ BrGlamorousVectorIcons refresh 
]

{ #category : #accessing }
LeLinkReferenceTool >> linkReferenceViewModel [
	<return: #LeLinkReferenceViewModel>
	^ linkReferenceViewModel
]

{ #category : #accessing }
LeLinkReferenceTool >> linkReferenceViewModel: aLeLinkReferenceViewModel [
	linkReferenceViewModel := aLeLinkReferenceViewModel
]

{ #category : #'api - accessing' }
LeLinkReferenceTool >> name [
	"Return a tool name"
	<return: #String or: #BlText>
	^ 'reference'
]

{ #category : #'private - accessing' }
LeLinkReferenceTool >> tabLook [
	^ BrGlamorousTabSwitcherWithIconAptitude
]

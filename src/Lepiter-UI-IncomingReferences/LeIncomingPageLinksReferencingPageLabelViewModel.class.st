Class {
	#name : #LeIncomingPageLinksReferencingPageLabelViewModel,
	#superclass : #LeDynamicSnippetViewModel,
	#traits : 'TLeWithIncomingPageLinksGroupedByPageModel',
	#classTraits : 'TLeWithIncomingPageLinksGroupedByPageModel classTrait',
	#instVars : [
		'uid',
		'marginTop'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #converting }
LeIncomingPageLinksReferencingPageLabelViewModel >> asLepiterPagePhlowTool [
	^ self referencingPage asLepiterPagePhlowTool
]

{ #category : #accessing }
LeIncomingPageLinksReferencingPageLabelViewModel >> displayLabel [
	<return: #String>

	^ self referencingPage title
]

{ #category : #initialization }
LeIncomingPageLinksReferencingPageLabelViewModel >> initialize [
	super initialize.
	
	marginTop := 15
]

{ #category : #'api - accessing' }
LeIncomingPageLinksReferencingPageLabelViewModel >> latestEditDateAndTime [

	^ self latestEditTime time
]

{ #category : #'api - accessing' }
LeIncomingPageLinksReferencingPageLabelViewModel >> latestEditTime [ 

	^ incomingPageLinksGroupedByPageModel latestEditTime
]

{ #category : #accessing }
LeIncomingPageLinksReferencingPageLabelViewModel >> marginTop [
	^ marginTop
]

{ #category : #accessing }
LeIncomingPageLinksReferencingPageLabelViewModel >> marginTop: anObject [
	marginTop := anObject
]

{ #category : #'api - incoming page links grouped by page model' }
LeIncomingPageLinksReferencingPageLabelViewModel >> onIncomingPageLinksGroupedByPageModelChanged [
	"Is sent when a new incomingPageLinksGroupedByPage model is assigned to the view model"
	
	
]

{ #category : #'api - accessing' }
LeIncomingPageLinksReferencingPageLabelViewModel >> snippetElementClass [
	^ LeIncomingPageLinksReferencingPageLabelElement
]

{ #category : #'api - accessing' }
LeIncomingPageLinksReferencingPageLabelViewModel >> uid [
	"We generate a new uid to uniquely identity this snupper view model"
	<return: #LeUID>

	^ uid ifNil: [ uid := self referencedPage database newUID ]
]

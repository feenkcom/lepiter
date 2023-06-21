Class {
	#name : #LePagePhlowTool,
	#superclass : #LePhlowTool,
	#instVars : [
		'page',
		'shouldFocusFirstSnippet',
		'externalSnippetContext'
	],
	#category : #'Lepiter-UI-Phlow Tools'
}

{ #category : #'api - instance creation' }
LePagePhlowTool class >> page: aPage [ 
	^ self new page: aPage
]

{ #category : #'api - converting' }
LePagePhlowTool >> asElementDo: aOneArgBlock [

	| aPageViewModel anElement |
	aPageViewModel := self page
		 asContentUIModel
		 shouldFocusFirstSnippet: self shouldFocusFirstSnippet.
	
	externalSnippetContext ifNotNil: [
		aPageViewModel externalSnippetContext: externalSnippetContext ].

	anElement := LePageToolElement new
		             pageViewModel: aPageViewModel;
		             matchParent.
	anElement selectionTransformation: [ :aNode | 
		aNode value asPhlowTool ].
	^ aOneArgBlock cull: anElement
]

{ #category : #'private - converting' }
LePagePhlowTool >> asTabElement [
	| anElement |
	anElement := super asTabElement.
	anElement
		when: LeDatabaseSidebarChangePageWish
		do: [ :aWish | 
			aWish currentTarget
				fireEvent: (GtPhlowToolObjectChangeWish new object: aWish pageUIModel pageModel) ].
	^ anElement
]

{ #category : #accessing }
LePagePhlowTool >> externalSnippetContext: anExternalSnippetContext [
	externalSnippetContext := anExternalSnippetContext
]

{ #category : #'api - accessing' }
LePagePhlowTool >> object [
	^ self page
]

{ #category : #'api - accessing' }
LePagePhlowTool >> page [
	<return: #LePage>
	^ page
]

{ #category : #'api - accessing' }
LePagePhlowTool >> page: aPage [
	page := aPage
]

{ #category : #'api - accessing' }
LePagePhlowTool >> shouldFocusFirstSnippet [
	^ shouldFocusFirstSnippet ifNil: [ true ]
]

{ #category : #'api - accessing' }
LePagePhlowTool >> shouldFocusFirstSnippet: aBoolean [
	shouldFocusFirstSnippet := aBoolean
]

{ #category : #'api - accessing' }
LePagePhlowTool >> title [
	^ self page title
]

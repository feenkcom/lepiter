Class {
	#name : #LePagesTool,
	#superclass : #LePhlowTool,
	#instVars : [
		'pages'
	],
	#category : 'Lepiter-UI-Phlow Tools'
}

{ #category : #'api - instance creation' }
LePagesTool class >> collection: anArray [
	^ self pages: (LePages new items: anArray)
]

{ #category : #'api - instance creation' }
LePagesTool class >> pages: anArray [
	^ self new pages: anArray 
]

{ #category : #'api - converting' }
LePagesTool >> asElementDo: aOneArgBlock [
	| anElement |
	anElement := self pages asToolElement.
	anElement childrenSelectionTransformation: [ :aNode |
		aNode value asLepiterPagePhlowTool ].
	^ aOneArgBlock cull: anElement
]

{ #category : #'api - accessing' }
LePagesTool >> object [
	^ self pages
]

{ #category : #'api - accessing' }
LePagesTool >> pages [
	<return: #LePages>
	^ pages
]

{ #category : #'api - accessing' }
LePagesTool >> pages: aLePages [
	pages := aLePages
]

{ #category : #'api - accessing' }
LePagesTool >> title [
	^ self pages size asString, ' pages'
]

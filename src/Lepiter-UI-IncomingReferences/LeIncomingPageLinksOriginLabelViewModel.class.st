Class {
	#name : #LeIncomingPageLinksOriginLabelViewModel,
	#superclass : #LeDynamicSnippetViewModel,
	#traits : 'TLeWithIncomingPageLinksGroupedByOriginModel',
	#classTraits : 'TLeWithIncomingPageLinksGroupedByOriginModel classTrait',
	#instVars : [
		'uid'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #accessing }
LeIncomingPageLinksOriginLabelViewModel >> displayLabel [
	<return: #String>

	^ self incomingPageLinksGroupedByOriginModel origin gtDisplayText
]

{ #category : #'api - incoming page links grouped by origin model' }
LeIncomingPageLinksOriginLabelViewModel >> onIncomingPageLinksGroupedByOriginModelChanged [
	"Is sent when a new incomingPageLinksGroupedByOrigin model is assigned to the view model"
]

{ #category : #'api - accessing' }
LeIncomingPageLinksOriginLabelViewModel >> snippetElementClass [
	^ LeIncomingPageLinksOriginLabelElement
]

{ #category : #'api - accessing' }
LeIncomingPageLinksOriginLabelViewModel >> uid [
	"We generate a new uid to uniquely identity this snupper view model"
	<return: #LeUID>

	^ uid ifNil: [ uid := self referencedPage database newUID ]
]

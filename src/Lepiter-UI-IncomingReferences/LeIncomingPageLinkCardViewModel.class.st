Class {
	#name : #LeIncomingPageLinkCardViewModel,
	#superclass : #LeDynamicSnippetViewModel,
	#traits : 'TLeWithIncomingPageLinkModel',
	#classTraits : 'TLeWithIncomingPageLinkModel classTrait',
	#instVars : [
		'uid'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #converting }
LeIncomingPageLinkCardViewModel >> asIncomingLinkPreviewElement [
	^ self incomingPageLinkModel originReference asIncomingLinkPreviewElement
]

{ #category : #'api - incoming page link model' }
LeIncomingPageLinkCardViewModel >> onIncomingPageLinkModelChanged [
	"Is sent when a new incomingPageLink model is assigned to the view model"
	
	
]

{ #category : #'api - accessing' }
LeIncomingPageLinkCardViewModel >> snippetElementClass [
	^ LeIncomingPageLinkCardElement
]

{ #category : #'api - accessing' }
LeIncomingPageLinkCardViewModel >> uid [
	"Each snippet view model displayed in the snippets element should have a uid.
	By default we take the uid of the content, however, custom snippet view models are free to override it"
	<return: #LeUID>

	^ uid ifNil: [ uid := self referencedPage database newUID ]
]

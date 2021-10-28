Class {
	#name : #LeLinkReferencePreviewViewModel,
	#superclass : #LeDynamicSnippetViewModel,
	#instVars : [
		'linkReferenceViewModel',
		'uid'
	],
	#category : 'Lepiter-UI-! Link Reference'
}

{ #category : #'api - accessing' }
LeLinkReferencePreviewViewModel >> database [
	<return: #LeDatabase>
	^ self linkReferenceViewModel database
]

{ #category : #'api - accessing' }
LeLinkReferencePreviewViewModel >> linkReference [
	<return: #LeLinkReference>
	^ self linkReferenceViewModel linkReference
]

{ #category : #'api - instance creation' }
LeLinkReferencePreviewViewModel >> linkReferenceElement [
	| aStencilBuilder |
	aStencilBuilder := self linkReferenceViewModel linkReferenceStencil.
	
	^ aStencilBuilder
		linkReference: self linkReference;
		page: self page;
		database: self database;
		asElement
]

{ #category : #'api - accessing' }
LeLinkReferencePreviewViewModel >> linkReferenceViewModel [
	^ linkReferenceViewModel
]

{ #category : #'api - accessing' }
LeLinkReferencePreviewViewModel >> linkReferenceViewModel: anObject [
	linkReferenceViewModel := anObject
]

{ #category : #'api - accessing' }
LeLinkReferencePreviewViewModel >> page [
	<return: #LePage>
	^ self linkReferenceViewModel page
]

{ #category : #accessing }
LeLinkReferencePreviewViewModel >> snippetElementClass [
	^ LeLinkReferencePreviewElement
]

{ #category : #accessing }
LeLinkReferencePreviewViewModel >> uid [
	"Each snippet view model displayed in the snippets element should have a uid.
	By default we take the uid of the content, however, custom snippet view models are free to override it"
	<return: #LeUID>

	^ uid ifNil: [ uid := self database newUID ]
]

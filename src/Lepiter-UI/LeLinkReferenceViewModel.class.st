Class {
	#name : #LeLinkReferenceViewModel,
	#superclass : #Object,
	#instVars : [
		'linkReference',
		'linkReferenceStencilBuilder',
		'databaseViewModel',
		'pageViewModel',
		'previewViewModel'
	],
	#category : 'Lepiter-UI-! Link Reference'
}

{ #category : #'private - create' }
LeLinkReferenceViewModel >> createPageAndExplicitLink [
	"Find or create page that describes the link reference"
	<return: #LePage>
	| aNewPage aLink aReference |

	aNewPage := LePage unnamedPage.
	self database addPage: aNewPage.
	aNewPage snippetBuilder string: ''; add.
	
	self 
		assert: [ aNewPage uid isNotNil ] 
		description: [ 'Page UID must be non-nil' ].
	
	aReference := self linkReference copy.
	aLink := LeAttachedLink new.
	aLink originReference: aReference.
	aLink targetReference: (LeLinkPageUidReference forPageUid: aNewPage uid).

	self database addExplicitLink: aLink.
	
	^ aNewPage
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> database [
	<return: #LeDatabase>
	^ self databaseViewModel database
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> databaseViewModel [
	<return: #LeAbstractDatabaseViewModel>
	^ databaseViewModel
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> databaseViewModel: aLeAbstractDatabaseViewModel [
	databaseViewModel := aLeAbstractDatabaseViewModel
]

{ #category : #'private - create' }
LeLinkReferenceViewModel >> findOrCreatePage [
	"Find or create page that describes the link reference"
	<return: #LePage>
	| allLinks |
	
	"Find outgoing page links"
	allLinks := self database explicitLinks select: [ :eachLink | 
		(eachLink originReference matches: self linkReference) and: [ 
			eachLink targetReference isPageReference ] ].
	
	allLinks isNotEmpty
		ifTrue: [ ^ allLinks first targetReference page ].

	^ self createPageAndExplicitLink.
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> linkReference [
	<return: #LeLinkReference>
	^ linkReference
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> linkReference: aLeLinkReference [
	linkReference := aLeLinkReference
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> linkReferenceStencil [
	<return: #LeLinkReferenceStencilBuilder>
	^ linkReferenceStencilBuilder ifNil: [ linkReferenceStencilBuilder := LeLinkReferenceStencilBuilder new ]
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> linkReferenceStencil: aStencilBuilder [
	"A builder that creates a ${class:BlElemnt}$, representing the link reference"
	
	linkReferenceStencilBuilder := aStencilBuilder asStencilBuilder: LeLinkReferenceStencilBuilder.
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> page [
	<return: #LePage>
	^ self pageViewModel pageModel
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> pageViewModel [
	<return: #LePageViewModel>
	^ pageViewModel ifNil: [ pageViewModel := self databaseViewModel pageUIModelFor: self findOrCreatePage ]
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> pageViewModel: aLePageViewModel [
	pageViewModel := aLePageViewModel
]

{ #category : #'api - accessing' }
LeLinkReferenceViewModel >> previewViewModel [
	^ previewViewModel ifNil: [ previewViewModel := LeLinkReferencePreviewViewModel new
			linkReferenceViewModel: self ]
]

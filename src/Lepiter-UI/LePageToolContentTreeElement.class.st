"
I display a {{gtClass:LePage}} complete tool:
{{gtExample:LeUIExamples>>#pageToolContentElement_Hierarchy|previewExpanded}}

My header (tittle and toolbar) is configurable using {{gtClass:LePageHeaderBuilder}}.

"
Class {
	#name : #LePageToolContentTreeElement,
	#superclass : #LePageToolContentElement,
	#traits : 'TLePageToolContentTreeElement + TLeWithFontSize + TBlAssertUIProcess',
	#classTraits : 'TLePageToolContentTreeElement classTrait + TLeWithFontSize classTrait + TBlAssertUIProcess classTrait',
	#instVars : [
		'footerToolbarElement'
	],
	#classInstVars : [
		'incomingLinksViewModelClass'
	],
	#category : #'Lepiter-UI-! Tool - Page'
}

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> defaultIncomingLinksViewModelClass [
	^ LeIncomingLinksCardsViewModel
]

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> incomingLinksViewModelClass [
	^ incomingLinksViewModelClass ifNil: [ self defaultIncomingLinksViewModelClass ]
]

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> incomingLinksViewModelClass: aSubclassOfLeIncomingLinksCollectionViewModel [
	incomingLinksViewModelClass := aSubclassOfLeIncomingLinksCollectionViewModel
]

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> showIncomingReferencesAsCards [
	self incomingLinksViewModelClass: LeIncomingLinksCardsViewModel
]

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> showIncomingReferencesInlined [
	self incomingLinksViewModelClass: LeIncomingLinksInlinedViewModel
]

{ #category : #initialization }
LePageToolContentTreeElement >> initialize [
	super initialize.
	self initializeFontSizeShortcuts.
	self initializeElementUpdater.
	
	treeElement := self createTreeElement.
	self addChild: treeElement as: #snippetsTree.
	"it will be initialized when #page is assigned"
	snippetsViewModel := nil.

	footerToolbarElement := LePageFooterToolbarElement new.
	self addChild: footerToolbarElement as: #footer.

	self addAptitude: (BrLayoutResizerAptitude new
		hInherit: self headerElement;
		vAnyToFitContent: self headerElement;
		inherit: treeElement)
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> onPageDatabaseChanged [
	updater requestUpdate.
	footerToolbarElement updateContent.
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> onPageModelReplaced [
	snippetsViewModel content: self pageViewModel pageModel.
	updater requestUpdate.
	
	footerToolbarElement pageModel: self pageViewModel pageModel.
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> onPageViewModelChanged [
	| pageSnippetsTreeViewModel pageIncomingLinksViewModel |
	super onPageViewModelChanged.

	self pageViewModel ensurePageHasAtLeastOneSnippet.

	pageSnippetsTreeViewModel := LeSnippetsTreeViewModel new
		sharedSnippetContext: self pageViewModel sharedSnippetContext.

	pageIncomingLinksViewModel := self class incomingLinksViewModelClass new.

	snippetsViewModel := LeCompositeContentCollectionViewModel new
		addContentCollectionViewModel: pageSnippetsTreeViewModel;
		addContentCollectionViewModel: pageIncomingLinksViewModel;
		content: self pageViewModel pageModel.

	self primitiveUpdateTree.
	
	footerToolbarElement pageModel: self pageViewModel pageModel.

	self pageViewModel shouldFocusFirstSnippet
		ifTrue: [ pageSnippetsTreeViewModel focusFirstSnippet ]
]

{ #category : #'api - accessing' }
LePageToolContentTreeElement >> rootItemsSelector: aRootItemsSelector [
]

{ #category : #'api - accessing' }
LePageToolContentTreeElement >> selectionTransformation: aBlock [
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> subscribeToPageViewModel [
	super subscribeToPageViewModel.

	self pageViewModel weak
		when: LePageViewModelSnippetsChanged send: #onSnippetsChanged: to: self;
		when: LePageViewModelDatabaseChanged send: #onPageDatabaseChanged to: self;
		when: LePageViewModelPageReplaced send: #onPageModelReplaced to: self.
		
	snippetsViewModel weak
		when: LeSnippetCollectionScrollToChanged send: #onContentTreeScrollTo to: self
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> unsubscribeFromPageViewModel [
	super unsubscribeFromPageViewModel.
	
	self pageViewModel unsubscribe: self
]

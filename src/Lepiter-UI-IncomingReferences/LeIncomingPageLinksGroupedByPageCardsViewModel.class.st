Class {
	#name : #LeIncomingPageLinksGroupedByPageCardsViewModel,
	#superclass : #LeDynamicSnippetViewModel,
	#traits : 'TLeWithIncomingPageLinksGroupedByPageModel',
	#classTraits : 'TLeWithIncomingPageLinksGroupedByPageModel classTrait',
	#instVars : [
		'uid',
		'linkViewModels'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #converting }
LeIncomingPageLinksGroupedByPageCardsViewModel >> asLepiterReferencedPagePhlowTool [
	^ self referencingPage asLepiterReferencedPagePhlowTool: self referencedPage
]

{ #category : #'api - accessing' }
LeIncomingPageLinksGroupedByPageCardsViewModel >> incomingPageLinkViewModels [
	^ linkViewModels
]

{ #category : #initialization }
LeIncomingPageLinksGroupedByPageCardsViewModel >> initialize [
	super initialize.
	
	linkViewModels := #()
]

{ #category : #'api - accessing' }
LeIncomingPageLinksGroupedByPageCardsViewModel >> latestEditDateAndTime [

	^ self latestEditTime time
]

{ #category : #'api - accessing' }
LeIncomingPageLinksGroupedByPageCardsViewModel >> latestEditTime [ 

	^ incomingPageLinksGroupedByPageModel latestEditTime
]

{ #category : #'api - incoming page links grouped by page model' }
LeIncomingPageLinksGroupedByPageCardsViewModel >> onIncomingPageLinksGroupedByPageModelChanged [
	"Is sent when a new incomingPageLinksGroupedByPage model is assigned to the view model"
	
	linkViewModels := self incomingPageLinksGroupedByPageModel links collect: [ :eachIncomingPageLink | 
		LeIncomingPageLinkCardViewModel new
			incomingPageLinkModel: eachIncomingPageLink ]
]

{ #category : #'api - accessing' }
LeIncomingPageLinksGroupedByPageCardsViewModel >> snippetElementClass [
	^ LeIncomingPageLinksGroupCardsElement
]

{ #category : #'private - hooks' }
LeIncomingPageLinksGroupedByPageCardsViewModel >> topReferencedSnippets [
	<return: #Collection of: #LeSnippet>
	| snippets |

	snippets := self incomingPageLinksGroupModel collect: [ :each | each link originReference content ].
	^ snippets
		reject: [ :child | snippets anySatisfy: [ :block | child hasParent: block ] ]
]

{ #category : #'api - accessing' }
LeIncomingPageLinksGroupedByPageCardsViewModel >> uid [
	"Each snippet view model displayed in the snippets element should have a uid.
	By default we take the uid of the content, however, custom snippet view models are free to override it"
	<return: #LeUID>

	^ uid ifNil: [ uid := self referencedPage database newUID ]
]

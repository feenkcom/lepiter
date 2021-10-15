"
LeTableOfContentsVisitor takes a LePage and produces a {{gtClass:name=LeTableOfContentsNode}} representing the ToC for the supplied page.

Public API and Key Messages

- tocForPage:

"
Class {
	#name : #LeTableOfContentsVisitor,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : 'Lepiter-Utilities-ToC'
}

{ #category : #'instance creation' }
LeTableOfContentsVisitor class >> tocForPage: aLePage [
	"Answer the table of Contents based on the supplied page"
	<return: #Collection of: #LeTableOfContentsNode>

	^ self new tocForPage: aLePage
]

{ #category : #initialization }
LeTableOfContentsVisitor >> initialize [

	super initialize.
	stack := Stack new.
]

{ #category : #'instance creation' }
LeTableOfContentsVisitor >> tocForPage: aLePage [
	"Construct the ToC tree for the supplied page."
	<return: #Collection of: #LeTableOfContentsNode>
	| tocNode unclassifiedPages |

	tocNode := LeTableOfContentsNode new page: aLePage.
	stack push: tocNode.
	self visitChildrenOf: aLePage.
	stack pop.
	
	unclassifiedPages := (LeTableOfContentsRestNode new 
		page: aLePage;
		rootNode: tocNode).
		
	^ unclassifiedPages children
		ifEmpty: [ Array with: tocNode ]
		ifNotEmpty: [ Array 
			with: tocNode
			with: unclassifiedPages ]
]

{ #category : #private }
LeTableOfContentsVisitor >> visitChild: aLeContent [
	| relavantLinks sortedLinks |

	relavantLinks := aLeContent isPage 
		ifTrue: [ aLeContent allOutgoingTextualLinks ]
		ifFalse: [ aLeContent outgoingTextualLinks  ].

	sortedLinks := relavantLinks items sorted: [ :a :b | 
		a node startPosition < b node startPosition ].
	
	sortedLinks do: [ :link |
		(link isTextualPageLink and: [ 
			link isExistingPage ]) ifTrue:
				[ stack top addChild: (LeTableOfContentsNode new link: link) ] ].
]

{ #category : #visiting }
LeTableOfContentsVisitor >> visitChildrenOf: aLeContent [
	| stackTopHasChildren |

	aLeContent children do: [ :child |
		self visitChild: child.
		stackTopHasChildren := stack top children isNotEmpty.
		stackTopHasChildren ifTrue: 
			[ stack push: stack top children last ].
		self visitChildrenOf: child.
		stackTopHasChildren ifTrue: [ stack pop ] ].
]

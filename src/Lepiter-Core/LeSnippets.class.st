Class {
	#name : #LeSnippets,
	#superclass : #LeCollection,
	#category : #'Lepiter-Core-Model'
}

{ #category : #visiting }
LeSnippets >> acceptVisitor: aVisitor [

	^ aVisitor visitSnippets: self
]

{ #category : #'api - editing' }
LeSnippets >> addSnippet: newLeSnippet after: aLeSnippet [
	"Add the new snippet after the existing snippet. Answer the new snippet"

	items add: newLeSnippet after: aLeSnippet.
	^ newLeSnippet
]

{ #category : #'api - editing' }
LeSnippets >> addSnippet: newLeSnippet before: aLeSnippet [
	"Add the new snippet before the existing block. Answer the new snippet"

	items add: newLeSnippet before: aLeSnippet.
	^ newLeSnippet
]

{ #category : #'api - editing' }
LeSnippets >> addSnippet: newLeSnippet beforeIndex: anInteger [
	"Add the new snippet at the supplied index. Answer the new snippet"

	items add: newLeSnippet beforeIndex: anInteger.
	^ newLeSnippet
]

{ #category : #'gt-extensions' }
LeSnippets >> gtSnippetsFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Snippets';
		priority: 10;
		items: [ self ];
		children: [ :eachPage | eachPage children ];
		expandUpTo: 5;
		column: 'Type' text: [ :aSnippet | aSnippet class ] width: 200;
		column: 'Content'
			text: [ :aSnippet | aSnippet contentAsString truncateTo: 200 ]
			width: 200;
		column: 'Edit Time' text: #editOrCreateTime;
		column: 'Author' text: #editOrCreateEmail;
		actionUpdateButton
]

{ #category : #testing }
LeSnippets >> includesSnippetUid: aLeUID [
	"Answer a boolean indicating whether the supplied uid is present"

	^ items detect: [ :each | each includesSnippetUid: aLeUID ] 
		ifFound: [ true ] 
		ifNone: [ false ]
]

{ #category : #'api - editing' }
LeSnippets >> indentSnippet: aLeSnippet [
	"Indent the supplied snippet, i.e. make it a child of the previous snippet.
	If it is the first snippet at the current level, do nothing.
	Answer the new parent, or nil if no change."
	| index newParent targetSnippet |

	index := items indexOf: aLeSnippet.
	index < 1 ifTrue: [ self error: 'Couldn''t find snippet: ', aLeSnippet asString ].
	index = 1 ifTrue: [ ^ nil ].
	targetSnippet := items at: index.
	targetSnippet detachFromParent.
	newParent := items at: index - 1.
	newParent attachChildSnippet: targetSnippet.
	items removeAt: index.
	^ newParent.
]

{ #category : #testing }
LeSnippets >> isChildAtFirstPositionFor: aLeSnippet [
	"Check if the given snippet is at first position.
	Throw an error if the snippet is not found."
	| index |

	index := items indexOf: aLeSnippet.
	index < 1 ifTrue: [ 
		self error: 'Couldn''t find snippet: ', aLeSnippet asString ].
	
	^ index = 1 
]

{ #category : #testing }
LeSnippets >> isChildAtLastPositionFor: aLeSnippet [
	"Check if the given snippet is at last position.
	Throw an error if the snippet is not found."
	| index |

	index := items indexOf: aLeSnippet.
	index < 1 ifTrue: [ 
		self error: 'Couldn''t find snippet: ', aLeSnippet asString ].
	
	^ index = items size
]

{ #category : #'api - editing' }
LeSnippets >> mergeSnippet: mergeLeSnippet after: afterLeSnippet [
	"Merge the supplied snippet with the after afterLeSnippet.
	Answer the merged snippet"
	| snippetIndex nextSnippet |

	snippetIndex := items indexOf: afterLeSnippet.
	self
		assert: [ snippetIndex < items size ]
		description: 'Can''t merge the last snippet with a following snippet'.
	nextSnippet := items at: snippetIndex + 1.
	nextSnippet appendText: mergeLeSnippet text.
	^ nextSnippet.
]

{ #category : #'api - editing' }
LeSnippets >> moveDownSnippet: aLeSnippet [
	"Try to move the supplied snippet down one item.
	Answer a boolean indicating the change was made."
	| index |

	index := items indexOf: aLeSnippet.
	index < 1 ifTrue: [ self error: 'Couldn''t find snippet: ', aLeSnippet asString ].
	index = items size ifTrue: [ ^ false ].
	items at: index put: (items at: index+1).
	items at: index+1 put: aLeSnippet.
	^ true
]

{ #category : #accessing }
LeSnippets >> moveSnippet: aLeSnippet above: parentSnippet [
	"Move aLeSnippet to the snippet above its current parent (parentSnippet).
	Answer the new parent if the move was made, or nil if it wasn't."
	| index newParent |

	index := items indexOf: parentSnippet.
	index < 1 ifTrue: [ self error: 'Can''t find: ', parentSnippet asString ].
	index = 1 ifTrue: [ ^ nil ].
	parentSnippet detachChildSnippet: aLeSnippet.
	newParent := items at: index - 1.
	newParent attachChildSnippet: aLeSnippet.
	^ newParent.
]

{ #category : #'api - editing' }
LeSnippets >> moveSnippet: aLeSnippet below: parentSnippet [
	"Move aLeSnippet to the snippet below its current parent (parentSnippet).
	Answer the new parent if the move was made, or nil if it wasn't."
	| index newParent |

	index := items indexOf: parentSnippet.
	index < 1 ifTrue: [ self error: 'Can''t find: ', parentSnippet asString ].
	index = items size ifTrue: [ ^ nil ].
	parentSnippet detachChildSnippet: aLeSnippet.
	newParent := items at: index + 1.
	newParent attachFirstChildSnippet: aLeSnippet.
	^ newParent
]

{ #category : #'api - editing' }
LeSnippets >> moveUpSnippet: aLeSnippet [
	"Try to move the supplied snippet up one item.
	Answer a boolean indicating the change was made."
	| index |

	index := items indexOf: aLeSnippet.
	index < 1 ifTrue: [ self error: 'Couldn''t find snippet: ', aLeSnippet asString ].
	index = 1 ifTrue: [ ^ false ].
	items at: index put: (items at: index-1).
	items at: index-1 put: aLeSnippet.
	^ true
]

{ #category : #printing }
LeSnippets >> printOn: aStream [
	aStream 
		print: self size;
		nextPutAll: ' snippets'
]

{ #category : #removing }
LeSnippets >> removeSnippet: aLeSnippet [
	"Remove the supplied block from the receiver"

	items remove: aLeSnippet.
	aLeSnippet detachFromParent
]

{ #category : #accessing }
LeSnippets >> swapSnippetAtIndex: aIndex withSnippetWithUid: anotherUid [
	self items
		swap: aIndex 
		with: (self items 
			detectIndex: [ :aSnippet | aSnippet uid = anotherUid ] ) 
]

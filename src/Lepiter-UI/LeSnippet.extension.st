Extension { #name : #LeSnippet }

{ #category : #'*Lepiter-UI' }
LeSnippet >> asContentUIModel [
	<return: #LeSnippetViewModel>

	^ self shouldNotImplement
]

{ #category : #'*Lepiter-UI' }
LeSnippet >> asLepiterPagePhlowTool [
	| composite |
	composite := GtPhlowCompositeTool new.

	self page
		ifNotNil: [ composite addTool: (LeSnippetInPagePhlowTool snippet: self) ].

	^ composite addTool: (GtPhlowTool default object: self)
]

{ #category : #'*Lepiter-UI' }
LeSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ self subclassResponsibility
]

{ #category : #'*Lepiter-UI' }
LeSnippet >> gtLiveFor: aView [
	<gtView>
	self class isAbstract
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self asSnippetViewModel ];
		view: #gtLiveFor:
]

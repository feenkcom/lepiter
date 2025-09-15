Extension { #name : #LeContent }

{ #category : #'*Lepiter-UI' }
LeContent >> asContentUIModel [
	<return: #LeContentViewModel>

	^ self subclassResponsibility
]

{ #category : #'*Lepiter-UI' }
LeContent >> asLepiterPagePhlowTool [
	<return: #LePhlowTool>
	^ self subclassResponsibility
]

{ #category : #'*Lepiter-UI' }
LeContent >> asPhlowTool [
	<return: #LePhlowTool>

	^ self subclassResponsibility
]

{ #category : #'*Lepiter-UI' }
LeContent >> asPreviewElement [
	"I return a ${class:BlElement}$ that is used for content previews, e.g., text editor expanding preview links.
	See ${method:LeBlockStylerVisitor>>#newExpandedElement:}$"
	<return: #LeContentElement>
	^ self subclassResponsibility
]

{ #category : #'*Lepiter-UI' }
LeContent >> asToolElement [
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #'*Lepiter-UI' }
LeContent >> gtLiveFor: aView [
	<gtView>
	self class isAbstract
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self asContentUIModel ];
		view: #gtLiveFor:
]

{ #category : #'*Lepiter-UI' }
LeContent >> gtStoreStringFor: aView [
	<gtView>
	^ aView explicit
		title: 'Store on';
		priority: 120;
		stencil: [ (GtPharoSnippetCoder new
				forSource: self storeString;
				format;
				subscribeToSystem;
				asExpandedOnlyElement) vFitContentLimited ];
		actionButtonIcon: BrGlamorousVectorIcons playinspect
			tooltip: 'Do it and go'
			action: [ :button | 
				button phlow
					spawnObject: (Smalltalk compiler evaluate: (String streamContents: [ :s | self storeOn: s ])) ];
		actionUpdateButton
]

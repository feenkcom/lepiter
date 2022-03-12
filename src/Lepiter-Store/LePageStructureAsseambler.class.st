Class {
	#name : #LePageStructureAsseambler,
	#superclass : #Object,
	#instVars : [
		'targetPage',
		'reloaderContext',
		'snippetStructure'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #actions }
LePageStructureAsseambler >> addContentForStructure: aChildStructureNode intoContent: aParentContent [
	| snippetUid replacementSnippet |
	snippetUid := aChildStructureNode uid.

	replacementSnippet := self locateReferenceSnippetWithId: snippetUid.
	aChildStructureNode markAsAdded.
	
	aParentContent addSnippet: replacementSnippet.
	
	^ replacementSnippet
]

{ #category : #accessing }
LePageStructureAsseambler >> addedNodesCount [
	^ snippetStructure addedNodesCount
]

{ #category : #actions }
LePageStructureAsseambler >> clearDeletedSnippets [
	reloaderContext removedSnippets 
		reverseDo: [ :aRemovedSnippet |
			self targetPage attachChildSnippet: aRemovedSnippet.
			aRemovedSnippet removeSelf ]
]

{ #category : #accessing }
LePageStructureAsseambler >> detectParentChangeFor: aStructureNode inParent: aParentContent [
	| previousParentUid |
	
	previousParentUid := self previousParentIdForSnippetWithId: aStructureNode uid.
	previousParentUid = aParentContent uid ifFalse: [ 
		aStructureNode markAsMoved ].
]

{ #category : #actions }
LePageStructureAsseambler >> extractSnippetStructureFrom: aPage [
	| structureNode |
	structureNode := LePageStructureNode forContent: aPage.
	self 
		extractSnippetStructureFrom: aPage 
		to: structureNode.
	^ structureNode
]

{ #category : #actions }
LePageStructureAsseambler >> extractSnippetStructureFrom: aContent to: aStructureNode [
	aContent children do: [ :aChildSnippet |
		| childNode | 
		childNode := LePageStructureNode forContent: aChildSnippet.
		aStructureNode addChildNode: childNode.
		aChildSnippet hasChildren ifTrue: [
			self 
				extractSnippetStructureFrom: aChildSnippet 
				to: childNode ] ]
]

{ #category : #'gt - extensions' }
LePageStructureAsseambler >> gtViewStructureMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Structure Map' translated;
		priority: 20;
		painting: [ :mondrian |
			self paintStructureOn: mondrian ]
]

{ #category : #testing }
LePageStructureAsseambler >> isNewSnippetWithId: anUid [
	^ self reloaderContext isNewSnippetWithId: anUid
]

{ #category : #query }
LePageStructureAsseambler >> locateExistingSnippetWithId: anUid [
	^ self reloaderContext locateExistingSnippetWithId: anUid
]

{ #category : #query }
LePageStructureAsseambler >> locatePreviousParentForNode: aStructureNode [
	| parentUid |
	(self reloaderContext hasPreviousParentIdForSnippetWithId: aStructureNode uid)
		ifFalse: [ ^ nil ].
		
	parentUid := self previousParentIdForSnippetWithId: aStructureNode uid.
	snippetStructure withAllChildrenDo: [ :aNode |
		aNode uid = parentUid ifTrue: [ ^ aNode ] ].
	^ nil
]

{ #category : #query }
LePageStructureAsseambler >> locateReferenceSnippetWithId: anUid [
	^ self reloaderContext locateReferenceSnippetWithId: anUid
]

{ #category : #accessing }
LePageStructureAsseambler >> modifiedNodesCount [
	^ snippetStructure modifiedNodesCount
]

{ #category : #accessing }
LePageStructureAsseambler >> movedNodesCount [
	^ snippetStructure movedNodesCount
]

{ #category : #'gt - extensions' }
LePageStructureAsseambler >> paintStructureOn: aMondrian [
	snippetStructure paintStructureOn: aMondrian.
	
	aMondrian edges
		passive;
		fromNearestBounds;
		toNearestBounds;
		stencil: [ :x | 
			BlSigmoidElement new
				beAutomatic;
				border: ((BlBorder paint: (Color gray alpha: 0.5) width: 1) copyWithStyle: BlStrokeStyle dashed);
				toHead:
					(BlArrowheadSimpleArrow new
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 1)) ];
		connect: (snippetStructure movedNodes 
				collect: [ :aStructureNode | 
					aStructureNode -> (self locatePreviousParentForNode: aStructureNode) ])
			from: [ :assoc | assoc key ]
			to: [ :assoc | assoc value ].
]

{ #category : #query }
LePageStructureAsseambler >> previousParentIdForSnippetWithId: anUid [
	^ self reloaderContext previousParentIdForSnippetWithId: anUid
]

{ #category : #actions }
LePageStructureAsseambler >> rebuildContent: aTargetContent usingStructure: aSnippetStructure [
	
	aSnippetStructure childNodes do: [ :currentStructureNode |
		| snippetUid targetChildSnippet |
		snippetUid := currentStructureNode uid.
		targetChildSnippet := (self isNewSnippetWithId: snippetUid)
			ifTrue: [
				self 
					addContentForStructure: currentStructureNode
					intoContent: aTargetContent ]
			ifFalse: [ 
				self 
					reloadContentForStructure: currentStructureNode
					intoContent: aTargetContent ].
		
		self 
			rebuildContent: targetChildSnippet 
			usingStructure: currentStructureNode ]
]

{ #category : #api }
LePageStructureAsseambler >> rebuildStructureBasedOnPage: aReplacementPage [
	snippetStructure := self extractSnippetStructureFrom: aReplacementPage.
	reloaderContext := LePageReloaderContext 
		forPage: self targetPage
		basedOnPage: aReplacementPage.
	reloaderContext detachSnippets.
	
	self targetPage reloadAttributesFromContent: aReplacementPage.
	self 
		rebuildContent: self targetPage 
		usingStructure: snippetStructure.
	self clearDeletedSnippets.
]

{ #category : #actions }
LePageStructureAsseambler >> reloadContentForStructure: aStructureNode intoContent: aParentContent [
	| snippetUid existingSnippet replacementSnippet hasChanges |
	snippetUid := aStructureNode uid.
	existingSnippet := self locateExistingSnippetWithId: snippetUid.
	replacementSnippet := self locateReferenceSnippetWithId: snippetUid.
	
	self detectParentChangeFor: aStructureNode inParent: aParentContent.
	
	"We need to explicitly handle here the case of unknows snippets that get revolved."
	(existingSnippet isUnknownSnippet and: [ replacementSnippet isUnknownSnippet not ]) ifTrue: [
		aStructureNode markAsResolved.
		
		^ self 
			reloadUnknownSnippet: existingSnippet 
			fromSnippet: replacementSnippet 
			intoContent: aParentContent ].
	
	hasChanges := existingSnippet reloadAttributesFromContent: replacementSnippet.
	hasChanges ifTrue: [
		aStructureNode markAsModified ].
	
	aParentContent attachChildSnippet: existingSnippet.
	
	^ existingSnippet
]

{ #category : #actions }
LePageStructureAsseambler >> reloadUnknownSnippet: existingSnippet fromSnippet: replacementSnippet intoContent: aParentContent [
	
	"If the snippet was resolved we take the new snippet. 
	Here the identity of the snippet changes. 
	TODO: Handles the case of links or resources attached to the old snippet."
	
	aParentContent attachChildSnippet: existingSnippet.
	existingSnippet removeSelf.
	
	aParentContent addSnippet: replacementSnippet.
	
	^ replacementSnippet
]

{ #category : #accessing }
LePageStructureAsseambler >> reloaderContext [
	^ reloaderContext
]

{ #category : #accessing }
LePageStructureAsseambler >> resolvedNodesCount [
	^ snippetStructure resolvedNodesCount
]

{ #category : #accessing }
LePageStructureAsseambler >> targetPage [

	^ targetPage
]

{ #category : #accessing }
LePageStructureAsseambler >> targetPage: aPage [

	targetPage := aPage
]

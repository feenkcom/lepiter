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

{ #category : #accessing }
LePageStructureAsseambler >> addedBlocksCount [
	^ snippetStructure addedBlocksCount
]

{ #category : #actions }
LePageStructureAsseambler >> detectParentChangeFor: aStructureBlock inParent: aParentContent [
	| previousParentUid |
	(self isNewSnippetWithId: aStructureBlock uid) ifTrue: [ ^ self ].
	
	previousParentUid := self previousParentIdForSnippetWithId: aStructureBlock uid.
	previousParentUid = aParentContent uid ifFalse: [ 
		aStructureBlock markAsMoved ].
]

{ #category : #actions }
LePageStructureAsseambler >> extractSnippetStructureFrom: aPage [
	| snippetsStructure |
	snippetsStructure := LePageStructureBlock forContent: aPage.
	self 
		extractSnippetStructureFrom: aPage 
		to: snippetsStructure.
	^ snippetsStructure
]

{ #category : #actions }
LePageStructureAsseambler >> extractSnippetStructureFrom: aContent to: aStructureStructure [
	aContent children do: [ :aChildSnippet |
		| childStructure | 
		childStructure := LePageStructureBlock forContent: aChildSnippet.
		aStructureStructure addChildBlock: childStructure.
		aChildSnippet hasChildren ifTrue: [
			self 
				extractSnippetStructureFrom: aChildSnippet 
				to: childStructure ] ]
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
LePageStructureAsseambler >> modifiedBlocksCount [
	^ snippetStructure modifiedBlocksCount
]

{ #category : #accessing }
LePageStructureAsseambler >> movedBlocksCount [
	^ snippetStructure movedBlocksCount
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
		connect: (snippetStructure movedBlocks 
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
	
	aSnippetStructure blocks do: [ :currentStructureBlock |
		| snippetUid targetSnippet |
		snippetUid := currentStructureBlock uid.
		(self isNewSnippetWithId: snippetUid)
			ifTrue: [ 
				targetSnippet := self locateReferenceSnippetWithId: snippetUid.
				currentStructureBlock markAsAdded ]
			ifFalse: [ 
				targetSnippet := self reloadContentForStructureBlock: currentStructureBlock ].
		
		self detectParentChangeFor: currentStructureBlock inParent: aTargetContent.
		aTargetContent attachChildSnippet: targetSnippet.
		
		self 
			rebuildContent: targetSnippet 
			usingStructure: currentStructureBlock ]
]

{ #category : #api }
LePageStructureAsseambler >> rebuildStructureBasedOnPage: aReferencePage [
	snippetStructure := self extractSnippetStructureFrom: aReferencePage.
	reloaderContext := LePageReloaderContext 
		forPage: self targetPage
		basedOnPage: aReferencePage.
	reloaderContext detachSnippets.
	
	self targetPage reloadAttributesFromContent: aReferencePage.
	self 
		rebuildContent: self targetPage 
		usingStructure: snippetStructure.
]

{ #category : #actions }
LePageStructureAsseambler >> reloadContentForStructureBlock: aStructureBlock [
	| snippetUid targetSnippet referenceSnippet hasChanges |
	snippetUid := aStructureBlock uid.
	targetSnippet := self locateExistingSnippetWithId: snippetUid.
	referenceSnippet := self locateReferenceSnippetWithId: snippetUid.
	
	"We need to explicitly handle here the case of unknows snippets."
	targetSnippet isUnknownSnippet ifTrue: [
		^ self 
			reloadUnknownSnippet: targetSnippet 
			fromSnippet: referenceSnippet 
			forStructureBlock: aStructureBlock ].
	
	hasChanges := targetSnippet reloadAttributesFromContent: referenceSnippet.
	hasChanges ifTrue: [
		aStructureBlock markAsModified ].
	
	^ targetSnippet
]

{ #category : #actions }
LePageStructureAsseambler >> reloadUnknownSnippet: targetSnippet fromSnippet: referenceSnippet forStructureBlock: aStructureBlock [ 
	
	"It's still unknown, update the properties of the existing snippet."
	referenceSnippet isUnknownSnippet ifTrue: [
		| hasChanges |
		hasChanges := targetSnippet reloadAttributesFromContent: referenceSnippet.
		hasChanges ifTrue: [
			aStructureBlock markAsModified ].
		^ targetSnippet ].
	
	"If the snippet was resolved we take the new snippet. 
	Here the identity of the snippet changes. 
	TODO: Handles the case of links or resources attached to the old snippet."
	aStructureBlock markAsResolved.
	^ referenceSnippet
				
	
]

{ #category : #accessing }
LePageStructureAsseambler >> reloaderContext [
	^ reloaderContext
]

{ #category : #accessing }
LePageStructureAsseambler >> resolvedBlocksCount [
	^ snippetStructure resolvedBlocksCount
]

{ #category : #accessing }
LePageStructureAsseambler >> targetPage [

	^ targetPage
]

{ #category : #accessing }
LePageStructureAsseambler >> targetPage: aPage [

	targetPage := aPage
]

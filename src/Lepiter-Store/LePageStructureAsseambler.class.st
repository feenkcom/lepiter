"
The main entry point for reloading the structure of a target page based on a replacement page.

The current approach is to flatten structure of snippets of the target page and recreate it based on the replacement page.
"
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
	"We iterate the removed snippets in reverse order only to build a better tree of removed snippets.
	Since intially the list was obtained using a depth-first traversal, doing a reverse iteration means
	we can add the parent first and then children"
	reloaderContext removedSnippets 
		reverseDo: [ :aRemovedSnippet |
			"To delete the snippet we attach it back to the page and remove it.
			Currently we do not have a separate way to remove a detaches snippet.
			
			Attaching the snippet to the page is not the ideal solution.
			Ideally we should reattach all deleted snippets to thir original 
			parent and then remove them."
			self targetPage attachChildSnippet: aRemovedSnippet.
			aRemovedSnippet removeSelf.
			
			self ensureStructureNodeForRemovedSnippet: aRemovedSnippet ]
]

{ #category : #accessing }
LePageStructureAsseambler >> detectParentChangeFor: aStructureNode inParent: aParentContent [
	| previousParentUid |
	
	previousParentUid := self previousParentIdForSnippetWithId: aStructureNode uid.
	previousParentUid = aParentContent uid ifFalse: [ 
		aStructureNode markAsMoved ].
]

{ #category : #'gt - extensions' }
LePageStructureAsseambler >> ensureStructureNodeForRemovedSnippet: aSnippet [
	| parentNode |
	parentNode := self locatePreviousParentForSnippetWithUid: aSnippet uid.
	parentNode addChildNode: (LePageStructureNode forContent: aSnippet)
		markAsRemoved 
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
		title: 'Structure map' translated;
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
LePageStructureAsseambler >> locatePreviousParentForSnippetWithUid: aSnippetUid [
	| parentUid |
	(self reloaderContext hasPreviousParentIdForSnippetWithId: aSnippetUid)
		ifFalse: [ ^ nil ].
	
	parentUid := self previousParentIdForSnippetWithId: aSnippetUid.
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

{ #category : #accessing }
LePageStructureAsseambler >> operationsCount [
	^ self modifiedNodesCount 
		+ self movedNodesCount
		+ self addedNodesCount 
		+ self resolvedNodesCount
		+ self removedSnippetsCount
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
					aStructureNode -> (self locatePreviousParentForSnippetWithUid: aStructureNode uid) ])
			from: [ :assoc | assoc key ]
			to: [ :assoc | assoc value ].
]

{ #category : #query }
LePageStructureAsseambler >> previousParentIdForSnippetWithId: anUid [
	^ self reloaderContext previousParentIdForSnippetWithId: anUid
]

{ #category : #printing }
LePageStructureAsseambler >> printOn: aStream [
	super printOn: aStream.
	aStream 
		<< '(';
		<< self operationsCount asString;
		<< ' operations'.
	self targetPage ifNotNil: [ 
		aStream 
			<< ', ';
			<< self targetPage title ].
	aStream << ')'
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
	
	"If the unknows snippet was revolved we ""replace"" it with the new resolved snippet.
	The replaced is done for now by removing the existing snippet and adding the new one.
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
LePageStructureAsseambler >> removedSnippetsCount [
	"Here we count explicitly the number of removed snippets"
	^ reloaderContext removedSnippets size
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

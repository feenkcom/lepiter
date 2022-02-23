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

{ #category : #testing }
LePageStructureAsseambler >> isNewSnippetWithId: anUid [
	^ self reloaderContext isNewSnippetWithId: anUid
]

{ #category : #query }
LePageStructureAsseambler >> locateExistingSnippetWithId: anUid [
	^ self reloaderContext locateExistingSnippetWithId: anUid
]

{ #category : #query }
LePageStructureAsseambler >> locateReferenceSnippetWithId: anUid [
	^ self reloaderContext locateReferenceSnippetWithId: anUid
]

{ #category : #actions }
LePageStructureAsseambler >> rebuildContent: aTargetContent usingStructure: aSnippetStructure [
	
	aSnippetStructure blocks do: [ :aBlock |
		| snippetUid targetSnippet referenceSnippet changedStatus |
		snippetUid := aBlock uid.
		referenceSnippet := self locateReferenceSnippetWithId: snippetUid.
		(self isNewSnippetWithId: snippetUid)
			ifTrue: [ 
				targetSnippet := referenceSnippet.
				aBlock markAsAdded ]
			ifFalse: [ 
				targetSnippet := self locateExistingSnippetWithId: snippetUid.
				changedStatus := targetSnippet reloadAttributesFromContent: referenceSnippet.
				changedStatus ifTrue: [
					aBlock markAsModified ] ].
		
		aTargetContent attachChildSnippet: targetSnippet.
		self 
			rebuildContent: targetSnippet 
			usingStructure: aBlock ]
]

{ #category : #actions }
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

{ #category : #accessing }
LePageStructureAsseambler >> reloaderContext [
	^ reloaderContext
]

{ #category : #accessing }
LePageStructureAsseambler >> targetPage [

	^ targetPage
]

{ #category : #accessing }
LePageStructureAsseambler >> targetPage: aPage [

	targetPage := aPage
]

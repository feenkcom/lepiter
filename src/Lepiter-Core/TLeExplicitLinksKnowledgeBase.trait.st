Trait {
	#name : #TLeExplicitLinksKnowledgeBase,
	#instVars : [
		'explicitLinks',
		'contentLinksByOrigin'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> addExplicitLink: anExplicitLink [

	self assert: [ anExplicitLink notNil ].
	
	anExplicitLink onAboutToAddToDatabase: self.
	self basicAddExplicitLink: anExplicitLink.
	
	anExplicitLink onAddedToDatabase: self.
	self basicAddLinkToContentCache: anExplicitLink.
	
	self announce: (LeExplicitLinkAddedAnnouncement new 	
		explicitLinks: self explicitLinks;
		newExplicitLink: anExplicitLink).
]

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> addExplicitLinks: aCollectionOfExplicitLinks [
	self assert: [ aCollectionOfExplicitLinks notNil ].
	
	aCollectionOfExplicitLinks do: [ :eachLink | 
		self addExplicitLink: eachLink ]
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> announce: anAnnouncement [
	self explicitRequirement
]

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> basicAddExplicitLink: anExplicitLink [
	self assert: [ anExplicitLink notNil ].
	
	self ensureExplicitLinksStorageUid.
	self explicitLinks addLink: anExplicitLink.
]

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> basicAddLinkToContentCache: anExplicitLink [
	"Temporary fix to cache the links from a page.
	Works now as we do not have unresolved origin 
	references in links. "
	
	| originReference |
	self assert: [ anExplicitLink notNil  ].
	
	anExplicitLink isExplicitLink ifFalse: [ ^ self ].
	originReference := anExplicitLink originReference.
	(originReference isLeContentReference 
		and: [ originReference isResolved ]) ifTrue: [ 
			| contentLinks |
			contentLinks := contentLinksByOrigin 
				at: originReference content 
				ifAbsentPut: [ LeExplicitLinks new ].
			contentLinks addLink: anExplicitLink ] 
]

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> basicRemoveExplicitLinks: leExplicitLinksToRemove [
	self assert: [ leExplicitLinksToRemove notNil ].

	self explicitLinks removeAll: leExplicitLinksToRemove.
	^ leExplicitLinksToRemove
]

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> basicRemoveLinkFromContentCache: anExplicitLink [
	"Temporary fix to cache the links from a page.
	Works now as we do not have unresolved origin 
	references in links. "
	
	| originReference |
	self assert: [ anExplicitLink notNil  ].
	
	anExplicitLink isExplicitLink ifFalse: [ ^ self ].
	originReference := anExplicitLink originReference.
	(originReference isLeContentReference 
		and: [ originReference isResolved ]) ifTrue: [ 
			contentLinksByOrigin  
				at: originReference content 
				ifPresent: [ :currentExplicitLinks |
					currentExplicitLinks 
						remove: anExplicitLink 
						ifAbsent: [ "no action needed" ] ] ] 
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> cachedLinksForContent: aLeContent [
	^ contentLinksByOrigin 
		at: aLeContent ifAbsentPut: [ LeExplicitLinks new ]
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> ensureExplicitLinksStorage [
	explicitLinks ifNil: [ 
		explicitLinks := LeExplicitLinks new ].
	contentLinksByOrigin ifNil: [
		contentLinksByOrigin := OrderedDictionary new ].
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> ensureExplicitLinksStorageUid [
	self assert: [ self explicitLinks notNil ].
	self explicitLinks uid ifNil: [ 
		self explicitLinks uid: self newUniqueUuid ]
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> explicitLinkWithUuid: anUuid [
	^ explicitLinks linkWithUuid: anUuid
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> explicitLinkWithUuid: anUuid ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self explicitLinks 
		at: anUuid 
		ifPresent: aPresentBlock 
		ifAbsent: anAbsentBlock
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> explicitLinks [
	^ explicitLinks
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> explicitLinksCount [
	^ self explicitLinks size
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> gtViewExplicitLinksFor: aView [
	<gtView>
	explicitLinks ifNil: [ aView empty ].
	^ aView forward
		title: 'Explicit links';
		object: [ self explicitLinks ];
		view: #gtViewExplicitLinksFor:
]

{ #category : #testing }
TLeExplicitLinksKnowledgeBase >> hasExplicitLinkUID: aUUID [
	^ explicitLinks 
		ifNil: [ false ] 
		ifNotNil: [ explicitLinks hasExplicitLinkUID: aUUID ]
]

{ #category : #testing }
TLeExplicitLinksKnowledgeBase >> hasExplicitLinks [
	^ explicitLinks notNil and: [ explicitLinks notEmpty ]
]

{ #category : #testing }
TLeExplicitLinksKnowledgeBase >> hasExplicityAttachedLinks [
	^ self hasExplicitLinks and: [ 
		explicitLinks anySatisfy: [ :aLink | 
			aLink isAttachedLink ] ]
]

{ #category : #accessing }
TLeExplicitLinksKnowledgeBase >> newUniqueUuid [
	self explicitRequirement
]

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> removeExplicitLinks: leExplicitLinksToRemove [
	| removedLinks |

	self assert: [ leExplicitLinksToRemove notNil ].
	leExplicitLinksToRemove ifEmpty: [ ^ self ].
	
	leExplicitLinksToRemove do: [ :aLink | 
		self basicRemoveLinkFromContentCache: aLink. "Clear cache before unlinking."
		aLink unlinkReferences ].
	removedLinks := self basicRemoveExplicitLinks: leExplicitLinksToRemove.
	
	self announce: (LeExplicitLinksRemovedAnnouncement new 	
		explicitLinks: self explicitLinks;
		removedExplicitLinks: removedLinks)
]

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> removeExplicitOutgoingLinksForContent: aLeContent [
	| linksToRemove |
	linksToRemove := self explicitLinks 
		select: [ :anExplicitLink |
			anExplicitLink originReference isLeContentReference and: [ 
				anExplicitLink originReference content = aLeContent ] ].
	self removeExplicitLinks: linksToRemove
]

{ #category : #'adding / removing' }
TLeExplicitLinksKnowledgeBase >> removeIncomingExplicitLinksForContent: aLeContent [

	"Go through the links that point to this content, and clear the
	reference to this content object from the link. This does not
	remove the link, just makes sure the link is no longer resolved 
	(points to a concrete content object)."

	| incomingLinks |
	self assertNotReadOnly.

	incomingLinks := aLeContent incomingLinks.
	incomingLinks do: [ :anExplicitLink | 
		anExplicitLink targetReference clearContent ].
	incomingLinks removeAll
]

{ #category : #updating }
TLeExplicitLinksKnowledgeBase >> resolveUnresolvedPageLinks [
	"Resolve every unresolved page link whose target page can now be found, in creation order.
	Called through LeLogicalDatabase>>#resolveUnresolvedPageLinks after a database is added
	(#addDB:, #addDBs:, #playgroundDB:): links from the new database to pages of existing ones,
	and links from existing databases to pages of the new one, may now resolve.
	Many selected links still have no target, e.g. [[A missing page]] or a 
	{{gtPage:...|db=...}} link to a database that is not loaded. This is why each link is sent
	#resolveReferencesIfTargetIsFound and not #resolveReferences. The latter would also try
	the origin of such attached links on every database addition, and notify again
	for every missing origin snippet."
	
	| unresolvedLinks |
	unresolvedLinks := self explicitLinks select: 
					[:aLink |
					aLink targetReference isPageReference
						and: [aLink targetReference isResolved not]].
	unresolvedLinks do: [:aLink | aLink resolveReferencesIfTargetIsFound]
]

{ #category : #initialization }
TLeExplicitLinksKnowledgeBase >> setExplicitLinks: aCollectionOfLinks [
	"Set the receiver's explicit links.
	This is used for bulk loading, but there can already be textual links."
	self assert: [ aCollectionOfLinks notNil ].
	self assert: [ aCollectionOfLinks isKindOf: LeExplicitLinks ].
	self assert: [ aCollectionOfLinks uid notNil ].
	self assert: [ explicitLinks uid notNil ].
	self assert: [ explicitLinks uid = aCollectionOfLinks uid ].
	
	self hasExplicityAttachedLinks ifTrue: [ ^ self error: 'Links already attached to the database' ].
	explicitLinks addAllLinks: aCollectionOfLinks.
	aCollectionOfLinks do: [ :aLink |
		aLink onAddedToDatabase: self.
		self basicAddLinkToContentCache: aLink. ].
	LeReloadOptimization ifEnabled: [
		explicitLinks storageHash: aCollectionOfLinks storageHash ].
]

{ #category : #initialization }
TLeExplicitLinksKnowledgeBase >> setExplicitLinksContainer: newExplicitLinks [
	"Set the receiver's container for storing explicit links.
	This is used for bulk loading, so assumes the database is empty."
	self assert: [ newExplicitLinks notNil ].
	self assert: [ newExplicitLinks isKindOf: LeExplicitLinks ].
	self assert: [ newExplicitLinks uid notNil ].
	self assert: [ newExplicitLinks isEmpty ].
	self assert: [ explicitLinks isNil ].
	
	explicitLinks := newExplicitLinks
]

{ #category : #updating }
TLeExplicitLinksKnowledgeBase >> updateLocalUnresolvedReferencesForPage: aPage [
	"Resolve the unresolved page links that reference aPage, in creation order.
	Called for every database of the logical database when a page is added, renamed or changes type
	(#addPage:, #onPageTitleChanged:, #onPageTypeChanged:).
	The selection keeps only links whose title or uid and database match aPage, so the target lookup
	finds aPage and #resolveReferences can be used: the origin of an attached link is only tried
	for links to aPage. Exception: a title link matching a page that is not a named page
	(e.g. a daily note) is selected, but #pageNamed: does not find it."
	
	| unresolvedIncomingLinks |
	unresolvedIncomingLinks := self explicitLinks select: 
					[:aLink |
					| targetReference |
					targetReference := aLink targetReference.
					targetReference isPageReference and: 
							[targetReference isResolved not
								and: [targetReference isReferencingContent: aPage]]].
	unresolvedIncomingLinks do: [:aLink | aLink resolveReferences]
]

{ #category : #updating }
TLeExplicitLinksKnowledgeBase >> updateUnresolvedReferencesForPage: aPage [
	self parent 
		ifNil: [ self updateLocalUnresolvedReferencesForPage: aPage. ]
		ifNotNil: [ :aParentDatabase |
			aParentDatabase updateUnresolvedReferencesForPage: aPage  ]
]

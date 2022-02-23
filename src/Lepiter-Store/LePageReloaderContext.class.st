Class {
	#name : #LePageReloaderContext,
	#superclass : #Object,
	#instVars : [
		'targetPage',
		'referencePage',
		'targetSnippetsByUid',
		'referenceSnippetsByUid'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #'instance creation' }
LePageReloaderContext class >> forPage: aTargetPage basedOnPage: aReferencePage [
	^ self new
		targetPage: aTargetPage;
		referencePage: aReferencePage
]

{ #category : #actions }
LePageReloaderContext >> detachPageContent: aPage to: aDictionary [

	aPage withAllChildrenDepthFirstDo: [ :aContent |
		aContent children items copy do: [ :aChildSnippet |
			aContent detachChildSnippet: aChildSnippet.
			aDictionary at: aChildSnippet uid put: aChildSnippet ] ]
]

{ #category : #actions }
LePageReloaderContext >> detachSnippets [
	"I am distructive action that takes the detaches all snippets from the 
	target andf reference pages, adding them to the context."
	targetSnippetsByUid removeAll.
	referenceSnippetsByUid removeAll.
	
	self detachPageContent: targetPage to: targetSnippetsByUid.
	self detachPageContent: referencePage to: referenceSnippetsByUid.
	
]

{ #category : #'gt-extensions' }
LePageReloaderContext >> gtViewReferenceSnippetsFor: aView [
	<gtView>
	^ aView forward
		title: 'Reference Snippets';
		priority: 10;
		object: [ referenceSnippetsByUid ];
		view: #gtItemsFor:
]

{ #category : #'gt-extensions' }
LePageReloaderContext >> gtViewTargetSnippetsFor: aView [
	<gtView>
	^ aView forward
		title: 'Target Snippets';
		priority: 11;
		object: [ targetSnippetsByUid ];
		view: #gtItemsFor:
]

{ #category : #initialization }
LePageReloaderContext >> initialize [
	super initialize.
	targetSnippetsByUid := OrderedDictionary new.
	referenceSnippetsByUid := OrderedDictionary new.
]

{ #category : #testing }
LePageReloaderContext >> isNewSnippetWithId: anUid [
	^ (referenceSnippetsByUid includesKey: anUid) and: [
		(targetSnippetsByUid includesKey: anUid) not ]
]

{ #category : #query }
LePageReloaderContext >> locateExistingSnippetWithId: anUid [
	^ targetSnippetsByUid at: anUid
]

{ #category : #query }
LePageReloaderContext >> locateReferenceSnippetWithId: anUid [
	^ referenceSnippetsByUid at: anUid
]

{ #category : #accessing }
LePageReloaderContext >> referencePage [

	^ referencePage
]

{ #category : #accessing }
LePageReloaderContext >> referencePage: anObject [

	referencePage := anObject
]

{ #category : #accessing }
LePageReloaderContext >> targetPage [

	^ targetPage
]

{ #category : #accessing }
LePageReloaderContext >> targetPage: anObject [

	targetPage := anObject
]

"
Contains information about the target and replacements pages needed during the reload.
"
Class {
	#name : #LePageReloaderContext,
	#superclass : #Object,
	#instVars : [
		'targetPage',
		'referencePage',
		'targetSnippetParentUidByUid',
		'targetSnippetsByUid',
		'referenceSnippetsByUid'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #'instance creation' }
LePageReloaderContext class >> forPage: aTargetPage basedOnPage: aReplacementPage [
	^ self new
		targetPage: aTargetPage;
		referencePage: aReplacementPage
]

{ #category : #accessing }
LePageReloaderContext >> addedSnippets [
	^ self replacementSnippets reject: [ :aReplacementSnippet |
		targetSnippetsByUid includesKey: aReplacementSnippet uid ]
]

{ #category : #actions }
LePageReloaderContext >> detachPageContent: aPage to: aDictionary withParents: aParentsDictionary [

	aPage withAllChildrenPostorderDo: [ :aContent |
		aContent children items copy do: [ :aChildSnippet |
			aContent detachChildSnippet: aChildSnippet.
			aDictionary at: aChildSnippet uid put: aChildSnippet.
			aParentsDictionary ifNotNil: [ 
				aParentsDictionary at: aChildSnippet uid put: aContent uid ] ] ]
]

{ #category : #actions }
LePageReloaderContext >> detachSnippets [
	"I am distructive action that takes the detaches all snippets from the 
	target andf reference pages, adding them to the context."
	targetSnippetsByUid removeAll.
	targetSnippetParentUidByUid removeAll.
	referenceSnippetsByUid removeAll.
	
	self detachPageContent: targetPage to: targetSnippetsByUid withParents: targetSnippetParentUidByUid.
	self detachPageContent: referencePage to: referenceSnippetsByUid withParents: nil.
	
]

{ #category : #'gt-extensions' }
LePageReloaderContext >> gtViewAddedSnippetsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Added snippets';
		priority: 13;
		items: [ self addedSnippets ];
		column: 'Uid' text: [ :aSnippet | aSnippet uid ] width: 250;
		column: 'Snippet' text: [ :aSnippet | aSnippet gtDisplayString ]
]

{ #category : #'gt-extensions' }
LePageReloaderContext >> gtViewReferenceSnippetsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Replacement snippets';
		priority: 11;
		items: [ self replacementSnippets ];
		column: 'Uid' text: [ :aSnippet | aSnippet uid ] width: 250;
		column: 'Snippet' text: [ :aSnippet | aSnippet gtDisplayString ]
]

{ #category : #'gt-extensions' }
LePageReloaderContext >> gtViewRemovedSnippetsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Removed snippets';
		priority: 12;
		items: [ self removedSnippets ];
		column: 'Uid' text: [ :aSnippet | aSnippet uid ] width: 250;
		column: 'Snippet' text: [ :aSnippet | aSnippet gtDisplayString ]
]

{ #category : #'gt-extensions' }
LePageReloaderContext >> gtViewTargetSnippetsFor: aView [
	<gtView>
	 ^ aView columnedList
		title: 'Target snippets';
		priority: 10;
		items: [ self targetSnippets ];
		column: 'Uid' text: [ :aSnippet | aSnippet uid ] width: 250;
		column: 'Snippet' text: [ :aSnippet | aSnippet gtDisplayString ]
]

{ #category : #testing }
LePageReloaderContext >> hasPreviousParentIdForSnippetWithId: anUid [
	^ targetSnippetParentUidByUid includesKey: anUid
]

{ #category : #initialization }
LePageReloaderContext >> initialize [
	super initialize.
	targetSnippetsByUid := OrderedDictionary new.
	targetSnippetParentUidByUid := OrderedDictionary new.
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

{ #category : #query }
LePageReloaderContext >> previousParentIdForSnippetWithId: anUid [
	^ targetSnippetParentUidByUid at: anUid
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
LePageReloaderContext >> removedSnippets [
	^ self targetSnippets reject: [ :anExistingnippet |
		referenceSnippetsByUid includesKey: anExistingnippet uid ]
]

{ #category : #accessing }
LePageReloaderContext >> replacementSnippets [
	^ referenceSnippetsByUid values
]

{ #category : #accessing }
LePageReloaderContext >> targetPage [

	^ targetPage
]

{ #category : #accessing }
LePageReloaderContext >> targetPage: anObject [

	targetPage := anObject
]

{ #category : #accessing }
LePageReloaderContext >> targetSnippets [
	^ targetSnippetsByUid values
]

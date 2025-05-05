Class {
	#name : #LeUnlinkedReferenceMaintenanceExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Utilities-Examples'
}

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> addPageWithIncommingUnlinkedReference [
	"Unlinked reference maintenance only updates as snippets are added, so adding a page currently doesn't have its incoming references updated"
	<gtExample>
	<noTest>
	| database newPage |
	database := self linkedAndUnlinkedReferences.

	BlUseAsyncFeatures disableDuring: [
		newPage := database pageBuilder title: 'Block 1'; add ].

	self assert: newPage incomingUnlinked size equals: 1.

	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> removePageWithOutgoingUnlinkedReference [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo |
	database := self linkedAndUnlinkedReferences.

	pageOne := database pageNamed: 'Page1'.
	pageTwo := database pageNamed: 'Page2'.

	self assert: pageTwo incomingUnlinked size equals: 3.

	BlUseAsyncFeatures disableDuring: [ pageOne removeSelf ].

	self assert: pageTwo incomingUnlinked size equals: 2.

	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> removeUnlinkedReference [
	"Remove the first unlinked reference from #linkedAndUnlinkedReferences"

	<gtExample>
	<return: #LeDatabase>
	| database page1 snippet page2 found |
	database := self linkedAndUnlinkedReferences.
	page1 := database pageNamed: 'Page1'.
	page2 := database pageNamed: 'Page2'.
	snippet := page1 children first.

	self assert: page2 incomingUnlinked size equals: 3.
	self assert: page2 incomingUnlinked first origin equals: snippet.

	BlUseAsyncFeatures disableDuring: [ snippet removeSelf ].

	self assert: page2 incomingUnlinked size equals: 2.
	found := page2 incomingUnlinked
			detect: [ :each | each origin = snippet ]
			ifFound: [ true ]
			ifNone: [ false ].
	self deny: found.

	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> removesSnippetWithChildSnippetsWithOutgoingUnlinkedReference [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo newSnippet |
	database := self linkedAndUnlinkedReferences.

	pageOne := database pageNamed: 'Page1'.
	pageTwo := database pageNamed: 'Page2'.

	BlUseAsyncFeatures
		disableDuring: [ newSnippet := pageOne snippetBuilder
					string: 'New snippet';
					add.
			newSnippet snippetBuilder
				string: 'Unlinked reference to Page2';
				add ].

	self assert: pageTwo incomingUnlinked size equals: 4.

	BlUseAsyncFeatures disableDuring: [ newSnippet removeSelf ].

	self assert: pageTwo incomingUnlinked size equals: 3.

	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> removesSnippetWithOutgoingUnlinkedReference [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageOneSnippetOne pageTwo |
	database := self linkedAndUnlinkedReferences.

	pageOne := database pageNamed: 'Page1'.
	pageOneSnippetOne := pageOne children first.
	pageTwo := database pageNamed: 'Page2'.

	self assert: pageTwo incomingUnlinked size equals: 3.

	BlUseAsyncFeatures disableDuring: [ pageOneSnippetOne removeSelf ].

	self assert: pageTwo incomingUnlinked size equals: 2.

	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> renamePageWithIncommingUnlinkedReference [
	<gtExample>
	<noTest>
	| database pageTwo  |
	database := self linkedAndUnlinkedReferences.
	
	pageTwo := database pageNamed: 'Page2'.

	self assert: pageTwo incomingUnlinked size equals: 3.
	
	BlUseAsyncFeatures disableDuring: [ pageTwo renameTo: 'Page9' ].
	
	self assert: pageTwo incomingUnlinked size equals: 0.
	
	^ database
]

Class {
	#name : #LeContentSnippetChangeCollector,
	#superclass : #LeContentChangeSubscriber,
	#instVars : [
		'snippets'
	],
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #'gt - extensions' }
LeContentSnippetChangeCollector >> gtSnippetsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Snippets';
		priority: 10;
		items: [ self snippets ];
		children: [ :eachPage | eachPage children ];
		expandUpTo: 5;
		column: 'Type' text: [ :aSnippet | aSnippet class ] width: 200;
		column: 'Content'
			text: [ :aSnippet | aSnippet contentAsString truncateTo: 200 ]
			width: 200;
		column: 'Edit Time' text: #editOrCreateTime;
		column: 'Author' text: #editOrCreateEmail;
		actionUpdateButton
]

{ #category : #accessing }
LeContentSnippetChangeCollector >> onSnippetAdded: aSnippet [
	self snippets add: aSnippet
]

{ #category : #accessing }
LeContentSnippetChangeCollector >> onSnippetChanged: aSnippet [
	self snippets add: aSnippet
]

{ #category : #accessing }
LeContentSnippetChangeCollector >> onSnippetRemoved: aSnippet [
	self snippets add: aSnippet
]

{ #category : #accessing }
LeContentSnippetChangeCollector >> snippets [
	^ snippets ifNil: [
		snippets := OrderedCollection new ]
]

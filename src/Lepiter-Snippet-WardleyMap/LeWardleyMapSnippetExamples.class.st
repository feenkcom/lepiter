Class {
	#name : #LeWardleyMapSnippetExamples,
	#superclass : #Object,
	#instVars : [
		'theDatabase',
		'theSourcePage',
		'theTargetPage',
		'theSnippet'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #assertions }
LeWardleyMapSnippetExamples >> assertWadleyMapHasOneLinkFor: wardleyMap [
	| links |
	links := OrderedCollection new.
	
	wardleyMap nodes do: [ :aNode |
		theSnippet linkForNode: aNode ifFound: [ :aLink |
			links add: aLink ] ].
	self assert: links size equals: 1.
]

{ #category : #'examples - setup' }
LeWardleyMapSnippetExamples >> databaseWithSnippet [
	<gtExample>
	<return: #LeDatabase>
	theDatabase := LeContentExamples new basicDatabaseWithMonitor.
	theSourcePage := theDatabase pageBuilder
			title: 'Page One';
			add.
	theTargetPage := theDatabase pageBuilder
			title: 'Target Page';
			add.

	theSnippet := self snippetWithNodesAndEdges.

	theSourcePage addSnippet: theSnippet.

	self assert: theDatabase pageCount equals: 2.
	self assert: theDatabase snippetsCount equals: 1.

	^ theDatabase
]

{ #category : #'examples - setup' }
LeWardleyMapSnippetExamples >> emptySnippet [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	| snippet |
	snippet := LeWardleyMapSnippet new.
	snippet uid: (LeUID new uidString: 'vKpABbS2').

	self assert: snippet wardleyMap isNotNil.
	self assert: snippet wardleyMap nodes isEmpty.
	self assert: snippet wardleyMap edges isEmpty.

	^ snippet
]

{ #category : #'examples - setup' }
LeWardleyMapSnippetExamples >> emptySnippetHasNoLink [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	| snippet |
	snippet := LeWardleyMapSnippet new.

	self assert: snippet wardleyMap isNotNil.
	self assert: snippet wardleyMap nodes isEmpty.
	self assert: snippet wardleyMap edges isEmpty.

	^ snippet
]

{ #category : #example }
LeWardleyMapSnippetExamples >> removeNodeLink [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	| sourceNode link |
	self snippetWithNodeLink.

	sourceNode := theSnippet wardleyMap nodes first.

	theSnippet
		linkForNode: sourceNode
		ifFound: [ :aLink | theDatabase removeExplicitLinks: {aLink} ].

	theSnippet linkForNode: sourceNode ifFound: [ :aLink | link := aLink ].
	self assert: link isNil.

	self assert: theSnippet outgoingExplicitLinks size equals: 0.
	self assert: theTargetPage incomingLinks size equals: 0.
	self assert: theDatabase explicitLinksCount equals: 0.

	^ theSnippet
]

{ #category : #example }
LeWardleyMapSnippetExamples >> replaceSnippetWithNodeLink [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	| sourceNode link newPage |
	self snippetWithNodeLink.

	newPage := theDatabase pageBuilder
			title: 'New Page';
			add.

	sourceNode := theSnippet wardleyMap nodes first.
	theSnippet createLinkFromNode: sourceNode toPageNamed: 'New Page'.

	theSnippet linkForNode: sourceNode ifFound: [ :aLink | link := aLink ].
	self assert: link notNil.
	self assertWadleyMapHasOneLinkFor: theSnippet wardleyMap.

	self assert: theSnippet outgoingExplicitLinks size equals: 1.
	self assert: theTargetPage incomingLinks size equals: 0.
	self assert: newPage incomingLinks size equals: 1.
	self assert: theDatabase explicitLinksCount equals: 1.
	self assert: theDatabase explicitLinks first equals: link.

	^ theSnippet
]

{ #category : #example }
LeWardleyMapSnippetExamples >> snippetWithNodeLink [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	| sourceNode link |
	self databaseWithSnippet.

	sourceNode := theSnippet wardleyMap nodes first.
	theSnippet createLinkFromNode: sourceNode toPageNamed: 'Target Page'.

	theSnippet linkForNode: sourceNode ifFound: [ :aLink | link := aLink ].
	self assert: link notNil.
	self assertWadleyMapHasOneLinkFor: theSnippet wardleyMap.

	self assert: theSnippet outgoingExplicitLinks size equals: 1.
	self assert: theTargetPage incomingLinks size equals: 1.
	self assert: theDatabase explicitLinksCount equals: 1.
	self assert: theDatabase explicitLinks first equals: link.

	^ theSnippet
]

{ #category : #'examples - setup' }
LeWardleyMapSnippetExamples >> snippetWithNodesAndEdges [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	| snippet |
	snippet := self emptySnippet.
	snippet wardleyMap: GtWardleyMapModelExamples new newMapWithNodes.

	self assert: snippet wardleyMap isNotNil.
	self assert: snippet wardleyMap nodes isNotEmpty.
	self assert: snippet wardleyMap edges isNotEmpty.

	^ snippet
]

{ #category : #example }
LeWardleyMapSnippetExamples >> snippetWithNodesAndEdgesHasNoLinks [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	| links |
	self databaseWithSnippet.

	links := OrderedCollection new.

	theSnippet wardleyMap nodes
		do: [ :aNode | theSnippet linkForNode: aNode ifFound: [ :aLink | links add: aLink ] ].
	self assert: links isEmpty.

	^ theSnippet
]

{ #category : #'examples - setup' }
LeWardleyMapSnippetExamples >> snippetWithProposedModifications [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	| snippet |
	snippet := self emptySnippet.
	snippet
		wardleyMap: GtWardleyMapDecoratorExamples new mapWithProposedModifications.

	self assert: snippet wardleyMap isNotNil.
	self assert: snippet wardleyMap nodes isNotEmpty.
	self assert: snippet wardleyMap edges isNotEmpty.

	^ snippet
]

{ #category : #'examples - setup' }
LeWardleyMapSnippetExamples >> stopDatabaseMonitor [
	theDatabase ifNotNil: [ theDatabase stopMonitoring ]
]

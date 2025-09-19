Class {
	#name : #LeContentStructureTraversalExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #asserting }
LeContentStructureTraversalExamples >> assertOrder: aCollectionOfValues forSnippets: aCollectionOfSnippets [ 
	self assert: aCollectionOfSnippets size equals: 10.
	
	self 
		assert: (aCollectionOfSnippets asArray
			collect: [ :aSnippet |
				aSnippet string ])
		equals: aCollectionOfValues
]

{ #category : #accessing }
LeContentStructureTraversalExamples >> targetPage [
	<gtExample>
	<return: #LePage>
	^ (LePage named: 'Test')
		addSnippet: ((LeTextSnippet string: '1')
				addSnippet: ((LeTextSnippet string: '2')
						addSnippet: ((LeTextSnippet string: '4')
								addSnippet: (LeTextSnippet string: '8');
								yourself);
						addSnippet: (LeTextSnippet string: '5');
						yourself);
				addSnippet: ((LeTextSnippet string: '3')
						addSnippet: ((LeTextSnippet string: '6')
								addSnippet: (LeTextSnippet string: '9');
								addSnippet: (LeTextSnippet string: '10');
								yourself);
						addSnippet: (LeTextSnippet string: '7');
						yourself);
				yourself);
		yourself
]

{ #category : #examples }
LeContentStructureTraversalExamples >> testBreadthFirstTraversalOfPage [
	<gtExample>
	<return: #OrderedCollection>
	| snippets |
	snippets := self targetPage withAllChildrenBreadthFirst.
	self assert: snippets first isPage.
	self
		assertOrder: #('1' '2' '3' '4' '5' '6' '7' '8' '9' '10')
		forSnippets: snippets allButFirst.

	^ snippets
]

{ #category : #examples }
LeContentStructureTraversalExamples >> testDepthFirstTraversalOfPage [
	<gtExample>
	<return: #OrderedCollection>
	| snippets |
	snippets := self targetPage withAllChildrenDepthFirst.
	self assert: snippets first isPage.
	self
		assertOrder: #('1' '2' '4' '8' '5' '3' '6' '9' '10' '7')
		forSnippets: snippets allButFirst.

	^ snippets
]

{ #category : #examples }
LeContentStructureTraversalExamples >> testPostorderTraversalOfPage [
	<gtExample>
	<return: #OrderedCollection>
	| snippets |
	snippets := self targetPage withAllChildrenPostorder.
	self assert: snippets last isPage.
	self
		assertOrder: #('8' '4' '5' '2' '9' '10' '6' '7' '3' '1')
		forSnippets: snippets allButLast.

	^ snippets
]

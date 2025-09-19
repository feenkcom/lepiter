Class {
	#name : #LeWardleyMapSnippetWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #accessing }
LeWardleyMapSnippetWithScripterExamples >> snippetWithNodesAndEdges [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ LeWardleyMapSnippetExamples new snippetWithNodesAndEdges ]
			element: [ :aSnippet | 
				| aSnippetViewModel aSnippetElement |
				aSnippetViewModel := aSnippet asSnippetViewModel.
				aSnippetElement := aSnippetViewModel snippetView asElement.
				aSnippetElement snippetViewModel: aSnippetViewModel.
				aSnippetElement padding: (BlInsets all: 10).
				aSnippetElement ].

	^ aScripter
]

{ #category : #accessing }
LeWardleyMapSnippetWithScripterExamples >> snippetWithNodesAndEdges_NodeAAddProposition [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self snippetWithNodesAndEdges.

	aNodeName := 'Node A'.

	aScripter do
		label: 'Add Node A add-proposition';
		block: [ :aModel | 
			aScripter model wardleyMap
				nodeWithName: aNodeName
				ifFound: [ :theNode | theNode addWardleyMapDecoratorModel: GtWardleyMapAddProposition new ]
				ifNone: [ nil ] ];
		onModel;
		play.

	aScripter
		substeps: 'Assert Node A proposition elements'
		do: [ :aStep | 
			aStep assert
				label: 'Assert Node A proposition element exists';
				exists;
				// GtWardleyMapNodePropositionElement;
				@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
				play.

			aStep assert
				label: 'Assert Node A proposition accept button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapAddAcceptId;
				play.

			aStep assert
				label: 'Assert Node A proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapAddRejectId;
				play ].


	^ aScripter
]

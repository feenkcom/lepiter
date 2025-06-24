Extension { #name : #GtWardleyMapDecoratorExamples }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapDecoratorExamples >> mapElementWithLepiterPageAction [
	<gtExample>
	<return: #GtWardleyMapElement>
	| aMapViewModel anElement |
	aMapViewModel := self mapViewModelWithLepiterPageAction.
	anElement := GtWardleyMapElement new wardleyMapViewModel: aMapViewModel.

	^ anElement
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapDecoratorExamples >> mapViewModelWithLepiterPageAction [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aMap aMapViewModel |
	aMap := self mapWithLepiterPageAction.
	aMapViewModel := GtWardleyMapViewModel new wardleyMapModel: aMap.

	^ aMapViewModel
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapDecoratorExamples >> mapWithLepiterPageAction [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aMap aPageNameA aNodeA aLinkA aNodeB aLinkB aPageB aPageNameC aLinkC aNodeC aPageNameD aLinkD |
	aMap := GtWardleyMapModelExamples new newMapWithNodes.

	aNodeA := aMap
			nodeWithName: 'Node A'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	aNodeB := aMap
			nodeWithName: 'Node B'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	aNodeC := aMap
			nodeWithName: 'Node C'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].

	aPageNameA := 'Analyzing feature toggles from a Python project: the Open edX case study'.
	aLinkA := GtWardleyMapAction new pageNamed: aPageNameA.
	aNodeA addWardleyMapDecoratorModel: aLinkA.

	aPageB := LeDatabasesRegistry defaultLogicalDatabase
			pageNamed: 'GT in 7'' videos'.
	aLinkB := GtWardleyMapAction new page: aPageB.
	aNodeB addWardleyMapDecoratorModel: aLinkB.

	aPageNameC := 'Analyzing feature toggles from a Python project: missing page'.
	aLinkC := GtWardleyMapAction new pageNamed: aPageNameC.
	aNodeC addWardleyMapDecoratorModel: aLinkC.

	aPageNameD := 'Case studies of Moldable Development'.
	aLinkD := GtWardleyMapAction new pageNamed: aPageNameD.
	aLinkD label: (GtWardleyMapUtility buttonLabelFromString: aPageNameD).
	aMap addWardleyMapDecoratorModel: aLinkD.

	^ aMap
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapDecoratorExamples >> mapWithLepiterPageLink [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aMap aPageNameA aNodeA aLinkA aNodeB aLinkB aPageB aPageNameC aLinkC aNodeC |
	aMap := GtWardleyMapModelExamples new newMapWithNodes.

	aNodeA := aMap
			nodeWithName: 'Node A'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	aNodeB := aMap
			nodeWithName: 'Node B'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	aNodeC := aMap
			nodeWithName: 'Node C'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].

	aPageNameA := 'Analyzing feature toggles from a Python project: the Open edX case study'.
	aLinkA := GtWardleyMapLink new pageNamed: aPageNameA.
	aNodeA addWardleyMapDecoratorModel: aLinkA.

	aPageB := LeDatabasesRegistry defaultLogicalDatabase
			pageNamed: 'GT in 7'' videos'.
	aLinkB := GtWardleyMapLink new page: aPageB.
	aNodeB addWardleyMapDecoratorModel: aLinkB.

	aPageNameC := 'Analyzing feature toggles from a Python project: missing page'.
	aLinkC := GtWardleyMapLink new pageNamed: aPageNameC.
	aNodeC addWardleyMapDecoratorModel: aLinkC.

	^ aMap
]

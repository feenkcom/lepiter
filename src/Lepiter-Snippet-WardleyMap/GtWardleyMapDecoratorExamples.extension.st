Extension { #name : #GtWardleyMapDecoratorExamples }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapDecoratorExamples >> mapWithLepiterPageAction [
	<gtExample>
	| aMap aPageNameA aNodeA aLinkA aNodeB aLinkB aPageB aPageNameC aLinkC aNodeC |
	aMap := GtWardleyMapModelExamples new newMapWithNodes.

	aNodeA := aMap nodeWithName: 'Node A' ifFound: [ :theNode | theNode ] ifNone: [ nil ].
	aNodeB := aMap nodeWithName: 'Node B' ifFound: [ :theNode | theNode ] ifNone: [ nil ].
	aNodeC := aMap nodeWithName: 'Node C' ifFound: [ :theNode | theNode ] ifNone: [ nil ].
	
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

	^ aMap
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapDecoratorExamples >> mapWithLepiterPageLink [
	<gtExample>
	| aMap aPageNameA aNodeA aLinkA aNodeB aLinkB aPageB aPageNameC aLinkC aNodeC |
	aMap := GtWardleyMapModelExamples new newMapWithNodes.

	aNodeA := aMap nodeWithName: 'Node A' ifFound: [ :theNode | theNode ] ifNone: [ nil ].
	aNodeB := aMap nodeWithName: 'Node B' ifFound: [ :theNode | theNode ] ifNone: [ nil ].
	aNodeC := aMap nodeWithName: 'Node C' ifFound: [ :theNode | theNode ] ifNone: [ nil ].
	
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

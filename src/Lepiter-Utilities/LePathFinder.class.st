"
{{gtClass:LePathFinder}} finds the shortest path between two pages, or nil if there is no connection. 

Public API and Key Messages

- betweenPagesNamed:and:in:   Finds the shortest path between the two pages
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	currentNode:		<LePage>
	endPage:			<LePage>
	shortestPaths:	<Dictionary>
	startPage:		<LePage>
	visited:			<Set>


### Implementation Points

Uses Dijkstra's algorithm to find the path, see: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm

"
Class {
	#name : #LePathFinder,
	#superclass : #Object,
	#instVars : [
		'startPage',
		'endPage',
		'shortestPaths',
		'currentNode',
		'visited'
	],
	#category : 'Lepiter-Utilities-Model'
}

{ #category : #'api - search' }
LePathFinder >> betweenPage: firstPage and: secondPage [
	"Find the shortest path between the two pages"

	"shortestPaths is a Dictionary of node -> { previous node. weight. }"
	shortestPaths := Dictionary new.
	shortestPaths at: firstPage put: { nil. 0. }.
	currentNode := firstPage.
	visited := Set new.
	startPage := firstPage.
	endPage := secondPage.

	^ self findShortest.
]

{ #category : #'api - search' }
LePathFinder >> betweenPageNamed: startPageName and: endPageName in: aLeDatabase [
	| firstPage secondPage |

	firstPage := aLeDatabase pageNamed: startPageName.
	secondPage := aLeDatabase pageNamed: endPageName.
	^ self betweenPage: firstPage and: secondPage.
]

{ #category : #private }
LePathFinder >> findShortest [
	| destinations weightToCurrentNode currentShortestWeight nextDestinations path |

	[ currentNode = endPage ] whileFalse:
		[ visited add: currentNode.
		destinations := self linkedPagesFrom: currentNode.
		weightToCurrentNode := (shortestPaths at: currentNode) second.
		
		destinations do: [ :nextNode | | weight |
			weight := weightToCurrentNode + 1.
			(shortestPaths includesKey: nextNode) ifFalse: 
				[ shortestPaths at: nextNode put: { currentNode. weight. } ]
			ifTrue:
				[ currentShortestWeight := (shortestPaths at: nextNode) second.
				currentShortestWeight > weight ifTrue: 
					[ shortestPaths at: nextNode put: { currentNode. weight. } ] ] ].
		nextDestinations := OrderedCollection new.
		shortestPaths keys do: [ :key |
			(visited includes: key) ifFalse:
				[ nextDestinations add: key -> (shortestPaths at: key) ] ].
		nextDestinations ifEmpty: [ ^ nil ].
		currentNode := self lowestWeightDestinationIn: nextDestinations. ].

	path := OrderedCollection new.
	[ currentNode isNil ] whileFalse: [ | nextNode |
		path add: currentNode.
		nextNode := (shortestPaths at: currentNode) first.
		currentNode := nextNode. ].
	^ path reversed.
]

{ #category : #private }
LePathFinder >> linkedPagesFrom: aNode [
	| linkedPages |

	linkedPages := aNode allChildOutgoingTextualLinks collect: [ :each | each target ] as: Set.
	linkedPages addAll: (aNode incomingLinks collect: [ :each | each origin page ]).
	linkedPages remove: nil ifAbsent: [ ].
	^ linkedPages
]

{ #category : #private }
LePathFinder >> lowestWeightDestinationIn: nextDestinations [
	| destination weight |

	weight := SmallInteger maxVal.
	nextDestinations do: [ :each |
		each value second < weight ifTrue: 
			[ destination := each key.
			weight := each value second ] ].
	^ destination
]

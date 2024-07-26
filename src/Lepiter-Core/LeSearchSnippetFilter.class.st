Class {
	#name : #LeSearchSnippetFilter,
	#superclass : #GtSearchTypedEntitiesFilter,
	#category : #'Lepiter-Core-Filters'
}

{ #category : #accessing }
LeSearchSnippetFilter class >> resultType [
	^ LeAsyncSearchSnippetGroupStream
]

{ #category : #accessing }
LeSearchSnippetFilter >> defaultFilterScope [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
		inject: #() asAsyncStream
		into: [ :sum :each | 
			sum
				merge: (each pages asAsyncStream
						collect: [ :page | 
							AsyncDepthFirstTraversalStream new
								roots: page children asArray
								children: [ :snippet | snippet children asArray ] ]) flatten ]
]

{ #category : #accessing }
LeSearchSnippetFilter >> matches: anObject [
	^ anObject isKindOf: LeSnippet
]

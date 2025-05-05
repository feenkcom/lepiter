Class {
	#name : #LePageStructureAsseamblerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Examples'
}

{ #category : #assertions }
LePageStructureAsseamblerExamples >> assertStructure: structureDescription forContent: aLepiterContent [

	self assert: structureDescription size equals: aLepiterContent children size.
	structureDescription withIndexDo: [ :assoc :index |
		| currentSnippet textValue |
		currentSnippet := aLepiterContent children at: index.
		textValue := assoc value isAssociation 
			ifTrue: [ assoc value key ] 
			ifFalse: [ assoc value ].
		self assert: currentSnippet string equals: textValue.
		assoc value isAssociation ifTrue: [
			self 
				assertStructure: assoc value value
				forContent: currentSnippet  ] ]
]

{ #category : #accessing }
LePageStructureAsseamblerExamples >> pageUid [
	^ LeUID new 
		uid: (UUID fromString: '7da384ea-e510-4913-9694-12fc22c1b8bd')
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetAUid [
	^ LeUID new 
		uid: (UUID fromString: '509980c4-c780-45e1-ab5f-9ae86cd2d1cf')
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetBUid [
	^ LeUID new 
		uid: (UUID fromString: '37185769-595b-4f66-8daf-65e25e38a981')
]

{ #category : #'examples - snippets' }
LePageStructureAsseamblerExamples >> snippetBUnknown [
	<gtExample>
	<return: #LeUnknownSnippet>
	^ LeUnknownSnippet new
		jsonString: (STONJSON toString: {'B'});
		uid: self snippetBUid
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetCUid [
	^ LeUID new 
		uid: (UUID fromString: 'c475afc8-3b13-4e87-ac16-06056b32ab48')
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetDUid [
	^ LeUID new 
		uid: (UUID fromString: '358fe201-76c8-4046-8297-1dcc204fd4b0')
]

{ #category : #'examples - snippets' }
LePageStructureAsseamblerExamples >> snippetDUnknown [
	<gtExample>
	<return: #LeUnknownSnippet>
	^ LeUnknownSnippet new
		jsonString: (STONJSON toString: {'D'});
		uid: self snippetDUid
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetEUid [
	^ LeUID new 
		uid: (UUID fromString: '71a301df-84d9-4635-b40d-342e58b6aa6d')
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetFUid [
	^ LeUID new 
		uid: (UUID fromString: 'eb8044a9-1293-4c29-907d-ae8c99b40508')
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetGUid [
	^ LeUID new 
		uid: (UUID fromString: 'bd870096-190f-45ea-a2da-dc784b5dd745')
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetHUid [
	^ LeUID new 
		uid: (UUID fromString: 'af17c7a9-3874-42ab-8e46-5099b26f16a3')
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetIUid [
	^ LeUID new 
		uid: (UUID fromString: '2a443a61-6b12-44d2-bcd6-26959f6ac066')
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithComplexStructureModified [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage
		addSnippet: (self snippetA
				string: 'A-M';
				addSnippet: (self snippetC string: 'C-M');
				yourself).
	targetPage
		addSnippet: (self snippetB
				addSnippet: (self snippetE
						addSnippet: self snippetD;
						yourself);
				yourself).
	targetPage addSnippet: self snippetF.

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithComplexStructureOne [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage
		addSnippet: (self snippetA
				addSnippet: self snippetDUnknown;
				yourself).
	targetPage
		addSnippet: (self snippetBUnknown
				addSnippet: (self snippetG
						addSnippet: (self snippetC
								addSnippet: (self snippetH
										addSnippet: self snippetI;
										yourself);
								yourself);
						yourself);
				addSnippet: self snippetF;
				yourself).

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithFiveSnippetsModifiedNestedStructure [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage
		addSnippet: (self snippetA
				string: 'A-M';
				addSnippet: self snippetD;
				yourself).
	targetPage
		addSnippet: (self snippetB
				addSnippet: (self snippetC string: 'C-M');
				addSnippet: self snippetE;
				yourself).

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithFiveSnippetsNestedStructure [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage
		addSnippet: (self snippetA
				addSnippet: self snippetD;
				yourself).
	targetPage
		addSnippet: (self snippetB
				addSnippet: self snippetC;
				addSnippet: self snippetE;
				yourself).

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithFourFlatSnippetStructure [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage addSnippet: self snippetA.
	targetPage addSnippet: self snippetB.
	targetPage addSnippet: self snippetC.
	targetPage addSnippet: self snippetD.

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithFourSnipetsOneNested [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage addSnippet: self snippetA.
	targetPage
		addSnippet: (self snippetB
				addSnippet: self snippetC;
				yourself).
	targetPage addSnippet: self snippetD.

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithFourSnipetsOneNestedInNewParent [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage addSnippet: self snippetA.
	targetPage
		addSnippet: (self snippetE
				addSnippet: self snippetC;
				yourself).
	targetPage addSnippet: self snippetD.

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithTwoLevelNestigForFirstSnippet [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage
		addSnippet: (self snippetA
				addSnippet: (self snippetB
						addSnippet: self snippetC;
						yourself);
				yourself).
	targetPage
		addSnippet: (self snippetD
				addSnippet: self snippetE;
				yourself).

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithTwoLevelNestigForSecondSnippet [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage
		addSnippet: (self snippetA
				addSnippet: self snippetB;
				yourself).
	targetPage
		addSnippet: (self snippetD
				addSnippet: (self snippetE
						addSnippet: self snippetC;
						yourself);
				yourself).

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithTwoSnippetsAAndB [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage addSnippet: self snippetA.
	targetPage addSnippet: self snippetB.

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithTwoSnippetsAAndC [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage addSnippet: self snippetA.
	targetPage addSnippet: self snippetC.

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithTwoSnippetsAKnownAndBUnknown [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage addSnippet: self snippetA.
	targetPage addSnippet: self snippetBUnknown.

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithTwoSnippetsAKnownAndBUnknownModified [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage addSnippet: self snippetA.
	targetPage
		addSnippet: (self snippetBUnknown jsonString: (STONJSON toString: {'a' -> 1} asDictionary)).

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithTwoSnippetsAParentAndBChild [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage
		addSnippet: (self snippetA
				addSnippet: self snippetB;
				yourself).

	^ targetPage
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithTwoSnippetsBParentAndAChild [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.

	targetPage
		addSnippet: (self snippetB
				addSnippet: self snippetA;
				yourself).

	^ targetPage
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForAndBParentChildReversal [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithTwoSnippetsAParentAndBChild.
	modifiedPage := self targetPageWithTwoSnippetsBParentAndAChild.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self
		assertStructure: {#snippetA -> ('B' -> {#snippetD -> 'A'})}
		forContent: targetPage.

	self assert: asseambler modifiedNodesCount equals: 0.
	self assert: asseambler movedNodesCount equals: 2.
	self assert: asseambler addedNodesCount equals: 0.
	self assert: asseambler resolvedNodesCount equals: 0.
	self assert: asseambler removedSnippetsCount equals: 0.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForChildMovedBetweenChildrensSnippets [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithTwoLevelNestigForFirstSnippet.
	modifiedPage := self targetPageWithTwoLevelNestigForSecondSnippet.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self
		assertStructure: {#snippetA -> ('A' -> {#snippetB -> 'B'}).
				#snippetD -> ('D' -> {#snippetE -> ('E' -> {#snippetC -> 'C'})})}
		forContent: targetPage.

	self assert: asseambler modifiedNodesCount equals: 0.
	self assert: asseambler movedNodesCount equals: 1.
	self assert: asseambler addedNodesCount equals: 0.
	self assert: asseambler resolvedNodesCount equals: 0.
	self assert: asseambler removedSnippetsCount equals: 0.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForComplexStructureModification [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithComplexStructureOne.
	modifiedPage := self targetPageWithComplexStructureModified.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self
		assertStructure: {#snippetA -> ('A-M' -> {#snippetC -> 'C-M'}).
				#snippetB -> ('B' -> {#snippetE -> ('E' -> {#snippetD -> 'D'})}).
				#snippetF -> 'F'}
		forContent: targetPage.

	self assert: asseambler modifiedNodesCount equals: 2.
	self assert: asseambler movedNodesCount equals: 3.
	self assert: asseambler addedNodesCount equals: 1.
	self assert: asseambler resolvedNodesCount equals: 2.
	self assert: asseambler removedSnippetsCount equals: 3.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForMultipleSnippetsDeletion [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithFiveSnippetsNestedStructure.
	modifiedPage := self targetPageWithTwoSnippetsAAndC.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self
		assertStructure: {#snippetA -> 'A'.
				#snippetD -> 'C'}
		forContent: targetPage.

	self assert: asseambler modifiedNodesCount equals: 0.
	self assert: asseambler movedNodesCount equals: 1.
	self assert: asseambler addedNodesCount equals: 0.
	self assert: asseambler resolvedNodesCount equals: 0.
	self assert: asseambler removedSnippetsCount equals: 3.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForOneChangedUnknownSnippet [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithTwoSnippetsAKnownAndBUnknown.
	modifiedPage := self targetPageWithTwoSnippetsAKnownAndBUnknownModified.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self assert: targetPage children first isTextSnippet.
	self assert: targetPage children second isUnknownSnippet.
	self
		assert: targetPage children second jsonString
		equals: (STONJSON toString: {'a' -> 1} asDictionary).

	self assert: asseambler modifiedNodesCount equals: 1.
	self assert: asseambler movedNodesCount equals: 0.
	self assert: asseambler addedNodesCount equals: 0.
	self assert: asseambler resolvedNodesCount equals: 0.
	self assert: asseambler removedSnippetsCount equals: 0.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForOneResolvedAndMovedUnknownSnippet [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithTwoSnippetsAKnownAndBUnknown.
	modifiedPage := self targetPageWithTwoSnippetsAParentAndBChild.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self assert: targetPage children first isTextSnippet.
	self assert: targetPage children first children first isTextSnippet.

	self assert: asseambler modifiedNodesCount equals: 0.
	self assert: asseambler movedNodesCount equals: 1.
	self assert: asseambler addedNodesCount equals: 0.
	self assert: asseambler resolvedNodesCount equals: 1.
	self assert: asseambler removedSnippetsCount equals: 0.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForOneResolvedUnknownSnippet [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithTwoSnippetsAKnownAndBUnknown.
	modifiedPage := self targetPageWithTwoSnippetsAAndB.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self assert: targetPage children first isTextSnippet.
	self assert: targetPage children second isTextSnippet.
	self assert: targetPage children second string equals: 'B'.

	self assert: asseambler modifiedNodesCount equals: 0.
	self assert: asseambler movedNodesCount equals: 0.
	self assert: asseambler addedNodesCount equals: 0.
	self assert: asseambler resolvedNodesCount equals: 1.
	self assert: asseambler removedSnippetsCount equals: 0.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForSnippetNestedInExistingParent [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithFourFlatSnippetStructure.
	modifiedPage := self targetPageWithFourSnipetsOneNested.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self
		assertStructure: {#snippetA -> 'A'.
				#snippetB -> ('B' -> {#snippetC -> 'C'}).
				#snippetD -> 'D'}
		forContent: targetPage.

	self assert: asseambler modifiedNodesCount equals: 0.
	self assert: asseambler movedNodesCount equals: 1.
	self assert: asseambler addedNodesCount equals: 0.
	self assert: asseambler resolvedNodesCount equals: 0.
	self assert: asseambler removedSnippetsCount equals: 0.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForSnippetNestedInNewParent [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithFourFlatSnippetStructure.
	modifiedPage := self targetPageWithFourSnipetsOneNestedInNewParent.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self
		assertStructure: {#snippetA -> 'A'.
				#snippetB -> ('E' -> {#snippetC -> 'C'}).
				#snippetD -> 'D'}
		forContent: targetPage.

	self assert: asseambler modifiedNodesCount equals: 0.
	self assert: asseambler movedNodesCount equals: 1.
	self assert: asseambler addedNodesCount equals: 1.
	self assert: asseambler resolvedNodesCount equals: 0.
	self assert: asseambler removedSnippetsCount equals: 1.

	^ asseambler
]

{ #category : #'examples - changes' }
LePageStructureAsseamblerExamples >> updateStructureForTwoSnippetNestingAndChanges [
	<gtExample>
	<return: #LePageStructureAsseambler>
	| targetPage modifiedPage asseambler |
	targetPage := self targetPageWithFourFlatSnippetStructure.
	modifiedPage := self targetPageWithFiveSnippetsModifiedNestedStructure.

	asseambler := targetPage rebuildFromContent: modifiedPage.

	self
		assertStructure: {#snippetA -> ('A-M' -> {#snippetD -> 'D'}).
				#snippetB
					-> ('B'
							-> {#snippetC -> 'C-M'.
									#snippetE -> 'E'})}
		forContent: targetPage.

	self assert: asseambler modifiedNodesCount equals: 2.
	self assert: asseambler movedNodesCount equals: 2.
	self assert: asseambler addedNodesCount equals: 1.
	self assert: asseambler resolvedNodesCount equals: 0.
	self assert: asseambler removedSnippetsCount equals: 0.

	^ asseambler
]

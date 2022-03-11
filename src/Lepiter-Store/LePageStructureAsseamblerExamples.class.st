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

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> destinationPageWithOneChildNesting [
	<gtExample>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.
	
	targetPage addSnippet: self snippetA.
	targetPage addSnippet: (self snippetB
		addSnippet: self snippetC;
		yourself).
	targetPage addSnippet: self snippetD.
	
	^ targetPage
]

{ #category : #accessing }
LePageStructureAsseamblerExamples >> pageUid [
	^ LeUID new 
		uid: (UUID fromString: '7da384ea-e510-4913-9694-12fc22c1b8bd')
]

{ #category : #'examples - snippets' }
LePageStructureAsseamblerExamples >> snippetA [
	<gtExample>
	^ LeTextSnippet new
		string: 'A';
		uid: self snippetAUid
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetAUid [
	^ LeUID new 
		uid: (UUID fromString: '509980c4-c780-45e1-ab5f-9ae86cd2d1cf')
]

{ #category : #'examples - snippets' }
LePageStructureAsseamblerExamples >> snippetB [
	<gtExample>
	^ LeTextSnippet new
		string: 'B';
		uid: self snippetBUid
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetBUid [
	^ LeUID new 
		uid: (UUID fromString: '37185769-595b-4f66-8daf-65e25e38a981')
]

{ #category : #'examples - snippets' }
LePageStructureAsseamblerExamples >> snippetC [
	<gtExample>
	^ LeTextSnippet new
		string: 'C';
		uid: self snippetCUid
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetCUid [
	^ LeUID new 
		uid: (UUID fromString: 'c475afc8-3b13-4e87-ac16-06056b32ab48')
]

{ #category : #'examples - snippets' }
LePageStructureAsseamblerExamples >> snippetD [
	<gtExample>
	^ LeTextSnippet new
		string: 'D';
		uid: self snippetDUid
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetDUid [
	^ LeUID new 
		uid: (UUID fromString: '358fe201-76c8-4046-8297-1dcc204fd4b0')
]

{ #category : #'examples - snippets' }
LePageStructureAsseamblerExamples >> snippetE [
	<gtExample>
	^ LeTextSnippet new
		string: 'E';
		uid: self snippetEUid
]

{ #category : #'accessing - uid' }
LePageStructureAsseamblerExamples >> snippetEUid [
	^ LeUID new 
		uid: (UUID fromString: '71a301df-84d9-4635-b40d-342e58b6aa6d')
]

{ #category : #'examples - pages' }
LePageStructureAsseamblerExamples >> targetPageWithFlatSnippetStructure [
	<gtExample>
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
LePageStructureAsseamblerExamples >> targetPageWithNestedStructure [
	<gtExample>
	| targetPage |
	targetPage := LePage named: 'Target Page'.
	targetPage basicUid: self pageUid.
	
	targetPage addSnippet: (self snippetA
		string: 'A-M';
		addSnippet: self snippetD;
		yourself).
	targetPage addSnippet: (self snippetB
		addSnippet: (self snippetC
			string: 'C-M');
		addSnippet: self snippetE;
		yourself).
	
	^ targetPage
]

{ #category : #examples }
LePageStructureAsseamblerExamples >> updateStructureForOneSnippetNesting [
	<gtExample>
	| targetPage modifiedPage asseambler |
	
	targetPage := self targetPageWithFlatSnippetStructure.
	modifiedPage := self destinationPageWithOneChildNesting.
	
	asseambler := targetPage rebuildFromContent: modifiedPage. 
	
	self 
		assertStructure: { 
			#snippetA -> 'A'.
			#snippetB -> ('B' -> {
				#snippetC -> 'C'. 
				}).
			#snippetD -> 'D' } 
		forContent: targetPage.
	
	self assert: asseambler modifiedBlocksCount equals: 0.
	self assert: asseambler movedBlocksCount equals: 1.
	self assert: asseambler addedBlocksCount equals: 0.
	
	^ asseambler
]

{ #category : #examples }
LePageStructureAsseamblerExamples >> updateStructureForTwoSnippetNestingAndChanges [
	<gtExample>
	| targetPage modifiedPage asseambler |
	
	targetPage := self targetPageWithFlatSnippetStructure.
	modifiedPage := self targetPageWithNestedStructure .
	
	asseambler := targetPage rebuildFromContent: modifiedPage. 
	
	self 
		assertStructure: { 
			#snippetA -> ('A-M' -> {
				#snippetD -> 'D'. 
				}).
			#snippetB -> ('B' -> {
				#snippetC -> 'C-M'. 
				#snippetE -> 'E'.
				}) } 
		forContent: targetPage.
	
	self assert: asseambler modifiedBlocksCount equals: 2.
	self assert: asseambler movedBlocksCount equals: 2.
	self assert: asseambler addedBlocksCount equals: 1.
	
	^ asseambler
]

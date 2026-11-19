"
I show that a {{gtClass:LeCodeSnippet}} hears from its coder through a {{gtClass:LeCodeSnippetCoderNotifier}}, a direct and strong link, instead of a weak subscription on the coder's announcer.
Edits still update the snippet, its page history and its storage, renames still reach the other snippets of the page, other subscribers of the coder still receive the announcements, and code snippets create no FinalizationRegistry entries.
The snippet is notified first, under the same monitor and suppression as the subscribers of the announcer (see {{gtMethod:GtCoderAnnouncer>>#announce:afterNotifying:}}).
The garbage collection examples document the decision that a coder keeps its snippet (and so its page) alive.
"
Class {
	#name : #LeCodeSnippetCoderNotifierExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> assertSnippetIsNotifiedDirectly: aSnippet [
	self
		assert: aSnippet coder directNotifier class
		equals: LeCodeSnippetCoderNotifier.
	self assert: aSnippet coder directNotifier snippet == aSnippet.
	self assert: (self subscriptionsOf: aSnippet on: aSnippet coder) isEmpty
]

{ #category : #'examples - history' }
LeCodeSnippetCoderNotifierExamples >> changeFromEditCommandRecordsNoTrace [
	<gtExample>
	| aPage aSnippet someChanges |
	aPage := self pageWithPharoSnippet: 'a := 1'.
	aSnippet := aPage children first.
	someChanges := self textChangesBySelfOf: aSnippet.
	aSnippet updateFromCommandText: 'a := 2' asRopedText source: self.
	self assert: aSnippet code equals: 'a := 2'.
	self assert: someChanges size equals: 1.
	self assert: aPage editHistory undoActions size equals: 0.
	^ aPage
]

{ #category : #'examples - memory' }
LeCodeSnippetCoderNotifierExamples >> codeSnippetsCreateNoFinalizationRegistryEntries [
	<gtExample>
	| someSnippets |
	someSnippets := LeCodeSnippet allSubclasses
			flatCollect: [ :eachClass | (1 to: 10) collect: [ :each | eachClass new ] ].
	self assert: someSnippets size equals: LeCodeSnippet allSubclasses size * 10.
	self
		assert: (self finalizationRegistryEntriesWithKeysIn: someSnippets)
		equals: 0.
	^ someSnippets
]

{ #category : #'examples - notifier' }
LeCodeSnippetCoderNotifierExamples >> codeSnippetsOfAllKindsHearFromTheirCoders [
	<gtExample>
	| aPage |
	aPage := self pageInDatabase.
	LeCodeSnippet allSubclasses
		do: [ :eachClass | aPage addSnippet: eachClass new ].
	aPage children
		do: [ :eachSnippet | 
			| someChanges |
			someChanges := self textChangesBySelfOf: eachSnippet.
			self editCoderOf: eachSnippet to: 'x'.
			self assertSnippetIsNotifiedDirectly: eachSnippet.
			self assert: eachSnippet code equals: 'x'.
			self assert: someChanges size equals: 1 ].
	self assert: aPage children size equals: LeCodeSnippet allSubclasses size.
	self assert: aPage editHistory undoActions size equals: aPage children size.
	^ aPage
]

{ #category : #'examples - memory' }
LeCodeSnippetCoderNotifierExamples >> coderHeldElsewhereKeepsItsSnippetAndPageAlive [
	<gtExample>
	| aCoderHolder aWeakArray |
	aCoderHolder := OrderedCollection new.
	aWeakArray := self
			weaklyHeldPageWithPharoSnippetWhoseCoderIsHeldBy: aCoderHolder.
	3 timesRepeat: [ Smalltalk garbageCollect ].
	self assert: (aWeakArray noneSatisfy: [ :each | each isNil ]).
	self assert: aCoderHolder first directNotifier snippet == (aWeakArray at: 2).
	aCoderHolder removeAll.
	self
		assert: (self garbageCollectUntil: [ aWeakArray allSatisfy: [ :each | each isNil ] ]).
	^ aWeakArray
]

{ #category : #'examples - subscribers' }
LeCodeSnippetCoderNotifierExamples >> coderSubscribersStillReceiveSourceCodeChanged [
	<gtExample>
	| aSnippet aCoderViewModel someViewModelChanges someCoderChanges |
	aSnippet := LePharoSnippet code: 'a := 1'.
	aCoderViewModel := aSnippet coder asCoderViewModel.
	someViewModelChanges := OrderedCollection new.
	aCoderViewModel
		when: GtTextualCoderViewModelTextChanged
		do: [ :anAnnouncement | someViewModelChanges add: anAnnouncement ]
		for: self.
	someCoderChanges := self sourceCodeChangesOf: aSnippet coder.
	self editCoderOf: aSnippet to: 'a := 2'.
	self assert: someViewModelChanges size equals: 1.
	self assert: someCoderChanges size equals: 1.
	self assert: someCoderChanges first coder == aSnippet coder.
	self assert: someCoderChanges first newText asString equals: 'a := 2'.
	^ aSnippet
]

{ #category : #'examples - copies and storage' }
LeCodeSnippetCoderNotifierExamples >> deserializedSnippetsAreNotifiedDirectly [
	<gtExample>
	| aPage aLoadedPage |
	aPage := self pageInDatabase.
	LeCodeSnippet allSubclasses
		do: [ :eachClass | 
			aPage
				addSnippet: (eachClass new
						code: 'x';
						yourself) ].
	aLoadedPage := LeJsonV4 uniqueInstance
			deserialize: (LeJsonV4 uniqueInstance serialize: aPage) readStream.
	self assert: aLoadedPage children size equals: aPage children size.
	aLoadedPage children
		do: [ :each | 
			self assert: each code equals: 'x'.
			self assertSnippetIsNotifiedDirectly: each ].
	^ aLoadedPage
]

{ #category : #'examples - memory' }
LeCodeSnippetCoderNotifierExamples >> droppedPageWithCodeSnippetsIsGarbageCollected [
	<gtExample>
	| aWeakArray |
	aWeakArray := self weaklyHeldPageWithAllKindsOfCodeSnippets.
	self assert: aWeakArray size equals: LeCodeSnippet allSubclasses size + 2.
	self
		assert: (self garbageCollectUntil: [ aWeakArray allSatisfy: [ :each | each isNil ] ]).
	^ aWeakArray
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> editCoderOf: aSnippet to: aString [
	aSnippet coder
		currentSourceText: aString asRopedText
		with: (GtCoderUpdateStrategy new source: self)
]

{ #category : #'examples - history' }
LeCodeSnippetCoderNotifierExamples >> editCommandRecordsOneTrace [
	<gtExample>
	| aPage aSnippet |
	aPage := self pageWithPharoSnippet: 'a := 1'.
	aSnippet := aPage children first.
	(aSnippet commandBuilder editTextualSnippetCommand
		string: 'a := 2'
		withSource: self) execute.
	self assert: aSnippet code equals: 'a := 2'.
	self assert: aPage editHistory undoActions size equals: 1.
	^ aPage
]

{ #category : #'examples - history' }
LeCodeSnippetCoderNotifierExamples >> editThroughCoder [
	<gtExample>
	| aPage aSnippet someChanges |
	aPage := self pageWithPharoSnippet: 'a := 1'.
	aSnippet := aPage children first.
	someChanges := self textChangesBySelfOf: aSnippet.
	self editCoderOf: aSnippet to: 'a := 2'.
	self assert: aSnippet code equals: 'a := 2'.
	self assert: someChanges size equals: 1.
	self assert: aPage editHistory undoActions size equals: 1.
	self assert: aPage editHistory redoActions size equals: 0.
	^ aPage
]

{ #category : #'examples - subscribers' }
LeCodeSnippetCoderNotifierExamples >> errorWhileTheSnippetHearsReachesTheEditorAndTheSubscribers [
	<gtExample>
	| aSnippet someCoderChanges aMessageText |
	aSnippet := LePharoSnippet code: 'a := 1'.
	someCoderChanges := self sourceCodeChangesOf: aSnippet coder.
	aSnippet
		when: LeSnippetTextChanged
		do: [ :anAnnouncement | Error signal: 'Snippet failed' ]
		for: self.
	aMessageText := [ self editCoderOf: aSnippet to: 'a := 2'.
		'no error' ] on: Error do: [ :anError | anError return: anError messageText ].
	self assert: aMessageText equals: 'Snippet failed'.
	self assert: aSnippet code equals: 'a := 2'.
	self assert: someCoderChanges size equals: 1.
	^ aSnippet
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> finalizationRegistryEntriesWithKeysIn: aCollection [
	| someKeys |
	someKeys := IdentitySet withAll: aCollection.
	^ FinalizationRegistry default keys count: [ :each | someKeys includes: each ]
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> garbageCollectUntil: aBlock [
	| aDeadline |
	aDeadline := DateAndTime now + 40 seconds.
	[ Smalltalk garbageCollect.
	aBlock value or: [ DateAndTime now > aDeadline ] ] whileFalse.
	^ aBlock value
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> hasRenamePreview: aSnippet [
	aSnippet coder currentSourceText
		attributesDo: [ :someAttributes | 
			(someAttributes anySatisfy: [ :each | each class = GtRenamePreviewAttribute ])
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'examples - coders without snippet' }
LeCodeSnippetCoderNotifierExamples >> methodCoderHasNullNotifier [
	<gtExample>
	| aCoder someChanges |
	aCoder := GtPharoMethodCoder forMethod: Object >> #printString.
	self assert: aCoder directNotifier == GtTextualCoderNullNotifier uniqueInstance.
	someChanges := self sourceCodeChangesOf: aCoder.
	aCoder
		currentSourceText: 'printString ^ 1' asRopedText
		with: (GtCoderUpdateStrategy new source: self).
	self assert: someChanges size equals: 1.
	self assert: aCoder isModified.
	^ aCoder
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> monitoredDatabaseIn: aFolder [
	^ (LeLocalStoreLoad new
		storage: LeMockLocalJsonV4StorageWithFilesOrder new;
		localRoot: aFolder;
		yourself) loadAndMonitorFrom: aFolder saveDelay: Duration zero
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> pageInDatabase [
	| aPage |
	aPage := LePage named: 'Coder notifier'.
	LeDatabase new addPage: aPage.
	^ aPage
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> pageWithPharoSnippet: aString [
	| aPage |
	aPage := self pageInDatabase.
	aPage addSnippet: (LePharoSnippet code: aString).
	^ aPage
]

{ #category : #'examples - notifier' }
LeCodeSnippetCoderNotifierExamples >> pharoSnippetIsNotifiedDirectlyByItsCoder [
	<gtExample>
	| aSnippet |
	aSnippet := LePharoSnippet code: 'a := 1'.
	self assertSnippetIsNotifiedDirectly: aSnippet.
	^ aSnippet
]

{ #category : #'examples - history' }
LeCodeSnippetCoderNotifierExamples >> redoEditThroughCoder [
	<gtExample>
	| aPage |
	aPage := self undoEditThroughCoder.
	aPage editHistory redoCurrent.
	self assert: aPage children first code equals: 'a := 2'.
	self assert: aPage editHistory undoActions size equals: 1.
	self assert: aPage editHistory redoActions size equals: 0.
	^ aPage
]

{ #category : #'examples - copies and storage' }
LeCodeSnippetCoderNotifierExamples >> reloadedSnippetIsStillNotifiedAndSaved [
	<gtExample>
	| aFolder aDatabase anotherDatabase aSnippet |
	aFolder := FileSystem memory / 'storage'.
	aFolder ensureCreateDirectory.
	aDatabase := self monitoredDatabaseIn: aFolder.
	aDatabase
		addPage: ((LePage named: 'Target Page')
				addSnippet: (LePharoSnippet code: 'a := 1');
				yourself).
	aSnippet := (aDatabase pageNamed: 'Target Page') children first.
	anotherDatabase := self monitoredDatabaseIn: aFolder.
	self
		assertSnippetIsNotifiedDirectly: (anotherDatabase pageNamed: 'Target Page') children first.
	self
		editCoderOf: (anotherDatabase pageNamed: 'Target Page') children first
		to: 'a := 2'.
	anotherDatabase stopMonitoring.
	self assert: (self storedCodeOfFirstSnippetIn: aFolder) equals: 'a := 2'.
	aDatabase reload.
	self assert: (aDatabase pageNamed: 'Target Page') children first == aSnippet.
	self assert: aSnippet code equals: 'a := 2'.
	self assertSnippetIsNotifiedDirectly: aSnippet.
	self editCoderOf: aSnippet to: 'a := 3'.
	aDatabase stopMonitoring.
	self assert: (self storedCodeOfFirstSnippetIn: aFolder) equals: 'a := 3'.
	^ aDatabase
]

{ #category : #'examples - rename' }
LeCodeSnippetCoderNotifierExamples >> renameImplicitTemporaryAcrossSnippets [
	<gtExample>
	| aPage aDefiningSnippet aUsingSnippet anUnrelatedSnippet aCoderViewModel aNode anAction |
	aPage := self pageInDatabase.
	aDefiningSnippet := LePharoSnippet code: 'a := 1'.
	aUsingSnippet := LePharoSnippet code: 'a + 3'.
	anUnrelatedSnippet := LePharoSnippet code: 'b := 4'.
	aPage
		addSnippet: aDefiningSnippet;
		addSnippet: aUsingSnippet;
		addSnippet: anUnrelatedSnippet.
	aCoderViewModel := aUsingSnippet coder asCoderViewModel.
	aNode := self variableNamed: 'a' in: aUsingSnippet.
	anAction := aUsingSnippet coder
			renameTemporaryIn: aCoderViewModel
			node: aNode
			context: (GtCoderAddOnsBuildContext new
					documentId: aCoderViewModel documentId;
					astNode: aNode;
					sourceCoderViewModel: aCoderViewModel).
	self assert: (self hasRenamePreview: aDefiningSnippet).
	self assert: (self hasRenamePreview: anUnrelatedSnippet) not.
	anAction updateName: 'x' asRopedText.
	anAction accept.
	self assert: aDefiningSnippet code equals: 'x := 1'.
	self assert: aUsingSnippet code equals: 'x + 3'.
	self assert: anUnrelatedSnippet code equals: 'b := 4'.
	^ aPage
]

{ #category : #'examples - copies and storage' }
LeCodeSnippetCoderNotifierExamples >> snippetCopyIsNotifiedByItsOwnCoder [
	<gtExample>
	| aPage aSnippet aCommand aCopy |
	aPage := self pageWithPharoSnippet: 'a := 1'.
	aSnippet := aPage children first.
	aCommand := aSnippet insertChildOrSiblingSnippetCommandOfType: aSnippet class.
	aCommand appendSnippetState: aSnippet additionalStateForCopying.
	aCopy := aCommand execute insertedSnippet.
	self assert: aCopy ~~ aSnippet.
	self assert: aCopy coder ~~ aSnippet coder.
	self assertSnippetIsNotifiedDirectly: aCopy.
	self assertSnippetIsNotifiedDirectly: aSnippet.
	self editCoderOf: aCopy to: 'b := 2'.
	self assert: aCopy code equals: 'b := 2'.
	self assert: aSnippet code equals: 'a := 1'.
	^ aPage
]

{ #category : #'examples - subscribers' }
LeCodeSnippetCoderNotifierExamples >> snippetHearsBeforeCoderSubscribers [
	<gtExample>
	| aSnippet anOrder |
	aSnippet := LePharoSnippet code: 'a := 1'.
	anOrder := OrderedCollection new.
	aSnippet
		when: LeSnippetTextChanged
		do: [ :anAnnouncement | anOrder add: #snippet ]
		for: self.
	aSnippet coder announcer
		when: GtCoderSourceCodeChanged
		do: [ :anAnnouncement | anOrder add: #subscriber ]
		for: self.
	self editCoderOf: aSnippet to: 'a := 2'.
	self assert: anOrder asArray equals: #(#snippet #subscriber).
	^ aSnippet
]

{ #category : #'examples - subscribers' }
LeCodeSnippetCoderNotifierExamples >> snippetIsNotifiedUnderTheAnnouncerMonitor [
	"While the snippet hears about a change, another process that announces on the same coder must wait"

	<gtExample>
	| aSnippet hasOtherProcessAnnounced wasOtherProcessBlocked aSemaphore |
	aSnippet := LePharoSnippet code: 'a := 1'.
	hasOtherProcessAnnounced := false.
	aSemaphore := Semaphore new.
	aSnippet
		when: LeSnippetTextChanged
		do: [ :anAnnouncement | 
			[ aSnippet coder announcer announce: GtCoderSourceCodeChanged new.
			hasOtherProcessAnnounced := true.
			aSemaphore signal ] forkAt: Processor activePriority + 1.
			wasOtherProcessBlocked := hasOtherProcessAnnounced not ]
		for: self.
	self editCoderOf: aSnippet to: 'a := 2'.
	self assert: wasOtherProcessBlocked.
	self assert: (aSemaphore waitTimeoutSeconds: 5) not.
	self assert: hasOtherProcessAnnounced.
	^ aSnippet
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> sourceCodeChangesOf: aCoder [
	| someChanges |
	someChanges := OrderedCollection new.
	aCoder announcer
		when: GtCoderSourceCodeChanged
		do: [ :anAnnouncement | someChanges add: anAnnouncement ]
		for: self.
	^ someChanges
]

{ #category : #'examples - coders without snippet' }
LeCodeSnippetCoderNotifierExamples >> standaloneSnippetCoderHasNullNotifier [
	<gtExample>
	| aCoder someChanges |
	aCoder := GtPharoSnippetCoder forSource: '3 + 4'.
	self assert: aCoder directNotifier == GtTextualCoderNullNotifier uniqueInstance.
	someChanges := self sourceCodeChangesOf: aCoder.
	aCoder currentSourceString: '5'.
	self assert: someChanges size equals: 1.
	self assert: aCoder currentSourceString equals: '5'.
	^ aCoder
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> storedCodeOfFirstSnippetIn: aFolder [
	| aDatabase aCode |
	aDatabase := self monitoredDatabaseIn: aFolder.
	aCode := (aDatabase pageNamed: 'Target Page') children first code.
	aDatabase stopMonitoring.
	^ aCode
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> subscriptionsOf: anObject on: aCoder [
	^ Array
		streamContents: [ :aStream | 
			aCoder announcer subscriptions subscriptions
				do: [ :each | each subscriber == anObject ifTrue: [ aStream nextPut: each ] ] ]
]

{ #category : #'examples - subscribers' }
LeCodeSnippetCoderNotifierExamples >> suppressedSourceCodeChangeReachesNeitherSnippetNorSubscribers [
	<gtExample>
	| aPage aSnippet someTextChanges someCoderChanges |
	aPage := self pageWithPharoSnippet: 'a := 1'.
	aSnippet := aPage children first.
	someTextChanges := self textChangesBySelfOf: aSnippet.
	someCoderChanges := self sourceCodeChangesOf: aSnippet coder.
	aSnippet coder announcer
		suppress: {GtCoderSourceCodeChanged}
		during: [ self editCoderOf: aSnippet to: 'a := 2' ].
	self assert: aSnippet code equals: 'a := 2'.
	self assert: someTextChanges isEmpty.
	self assert: someCoderChanges isEmpty.
	self assert: aPage editHistory undoActions isEmpty.
	^ aPage
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> textChangesBySelfOf: aSnippet [
	| someChanges |
	someChanges := OrderedCollection new.
	aSnippet
		when: LeSnippetTextChanged
		do: [ :anAnnouncement | anAnnouncement source == self ifTrue: [ someChanges add: anAnnouncement ] ]
		for: self.
	^ someChanges
]

{ #category : #'examples - history' }
LeCodeSnippetCoderNotifierExamples >> undoEditThroughCoder [
	<gtExample>
	| aPage |
	aPage := self editThroughCoder.
	aPage editHistory undoCurrent.
	self assert: aPage children first code equals: 'a := 1'.
	self assert: aPage editHistory undoActions size equals: 0.
	self assert: aPage editHistory redoActions size equals: 1.
	^ aPage
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> variableNamed: aString in: aSnippet [
	aSnippet coder astSync
		allNodesDo: [ :each | 
			(each isVariable and: [ each variableName asString = aString ])
				ifTrue: [ ^ each ] ].
	^ self error: 'No variable named ' , aString
]

{ #category : #'examples - memory' }
LeCodeSnippetCoderNotifierExamples >> weakSubscriptionOfASnippetCreatesAFinalizationRegistryEntry [
	"Shows that #finalizationRegistryEntriesWithKeysIn: sees the entries that weak subscriptions create"

	<gtExample>
	| aSnippet |
	aSnippet := LePharoSnippet code: 'a := 1'.
	aSnippet coder weak
		when: GtCoderSourceCodeChanged
		send: #yourself
		to: aSnippet.
	self assert: (self finalizationRegistryEntriesWithKeysIn: {aSnippet}) equals: 1.
	^ aSnippet
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> weaklyHeldPageWithAllKindsOfCodeSnippets [
	| aPage |
	aPage := self pageInDatabase.
	LeCodeSnippet allSubclasses
		do: [ :eachClass | aPage addSnippet: eachClass new ].
	^ WeakArray
		withAll: {aPage.
				aPage database} , aPage children items asArray
]

{ #category : #support }
LeCodeSnippetCoderNotifierExamples >> weaklyHeldPageWithPharoSnippetWhoseCoderIsHeldBy: aCollection [
	| aPage |
	aPage := self pageWithPharoSnippet: 'a := 1'.
	aCollection add: aPage children first coder.
	^ WeakArray with: aPage with: aPage children first
]

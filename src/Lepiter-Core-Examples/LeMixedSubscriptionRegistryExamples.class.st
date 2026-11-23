"
I check the Lepiter models whose announcers use a {{gtClass:GtMixedSubscriptionRegistry}}: I create them while {{gtClass:LeUseMixedSubscriptionRegistryFlag}} is enabled, check that they deliver their announcements as before and need no global finalization entries for weak subscriptions, and that view models, pages and databases are collected while other subscribers of the same announcers stay alive.
I also check the flag itself, and that {{gtMethod:LeUseMixedSubscriptionRegistryFlag class>>#usePlainSubscriptionRegistriesIn:}} moves the announcers of a database back to plain registries without losing subscriptions.
"
Class {
	#name : #LeMixedSubscriptionRegistryExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples'
}

{ #category : #'examples - registry' }
LeMixedSubscriptionRegistryExamples >> databaseAnnouncerUsesMixedRegistry [
	<gtExample>
	| aDatabase |
	aDatabase := self newDatabase.
	self assert: aDatabase announcer subscriptions class
		equals: GtMixedSubscriptionRegistry.
	self
		assert: (aDatabase announcer subscriptions allWeakSubscriptions
				collect: [:each | each subscriber]) asSet
		equals: (Set with: aDatabase).
	^aDatabase
]

{ #category : #'examples - garbage collection' }
LeMixedSubscriptionRegistryExamples >> databaseIsCollectedWhileAWeakSubscriberLives [
	<gtExample>
	| aLongLivedSubscriber theSurvivors |
	aLongLivedSubscriber := OrderedCollection new.
	theSurvivors := self
				databaseWithPageObservedWeaklyBy: aLongLivedSubscriber.
	self
		assert: (self garbageCollectUntil: 
					[(theSurvivors at: 1) isNil and: [(theSurvivors at: 2) isNil]]).
	self assert: aLongLivedSubscriber isEmpty.
	^theSurvivors
]

{ #category : #'examples - switching to plain registries' }
LeMixedSubscriptionRegistryExamples >> databaseSwitchedToPlainRegistriesIsCollected [
	<gtExample>
	| aLongLivedSubscriber theSurvivors |
	aLongLivedSubscriber := OrderedCollection new.
	theSurvivors := self
				databaseWithPageObservedWeaklyBy: aLongLivedSubscriber.
	LeUseMixedSubscriptionRegistryFlag
		usePlainSubscriptionRegistriesIn: (theSurvivors at: 1).
	self assert: (self registryClassesOf: (theSurvivors at: 1)) asSet
		equals: (Set with: SubscriptionRegistry).
	self
		assert: (self garbageCollectUntil: 
					[(theSurvivors at: 1) isNil and: [(theSurvivors at: 2) isNil]]).
	self assert: aLongLivedSubscriber isEmpty.
	^theSurvivors
]

{ #category : #'examples - switching to plain registries' }
LeMixedSubscriptionRegistryExamples >> databaseSwitchedToPlainRegistriesKeepsItsSubscriptions [
	<gtExample>
	| aDatabase aPage aSnippet aMonitor theCountsBefore theTitles theTexts aStrongCollector |
	aDatabase := self newDatabase.
	aMonitor := self withMixedRegistries: [LeLocalStoreMonitor new].
	aDatabase monitor: aMonitor.
	aPage := self newPageNamed: 'Before'.
	aDatabase addPage: aPage.
	aSnippet := self newTextSnippet: 'before'.
	aPage addSnippet: aSnippet.
	theTitles := OrderedCollection new.
	theTexts := OrderedCollection new.
	aStrongCollector := OrderedCollection new.
	aDatabase weak when: LePageTitleChanged send: #add: to: theTitles.
	aPage weak when: LeSnippetTextChanged send: #add: to: theTexts.
	aSnippet when: LeSnippetTextChanged send: #add: to: aStrongCollector.
	self assert: (self registryClassesOf: aDatabase) asSet
		equals: (Set with: GtMixedSubscriptionRegistry).
	theCountsBefore := self subscriptionCountsOf: aDatabase.
	LeUseMixedSubscriptionRegistryFlag
		usePlainSubscriptionRegistriesIn: aDatabase.
	self assert: (self registryClassesOf: aDatabase) asSet
		equals: (Set with: SubscriptionRegistry).
	self assert: (self registryClassesOf: aDatabase) size equals: 4.
	self assert: (self subscriptionCountsOf: aDatabase) equals: theCountsBefore.
	aPage updateTitle: 'After'.
	aSnippet updateText: 'after' asRopedText.
	self assert: theTitles size equals: 1.
	self assert: theTexts size equals: 1.
	self assert: aStrongCollector size equals: 1.
	self assert: (aDatabase pageNamed: 'After' ifAbsent: [nil]) == aPage.
	^aDatabase
]

{ #category : #'private - scenarios' }
LeMixedSubscriptionRegistryExamples >> databaseWithPageObservedWeaklyBy: aLongLivedSubscriber [
	| aDatabase aPage |
	aDatabase := self newDatabase.
	aPage := self newPageNamed: 'A page of a short-lived database'.
	aPage addSnippet: (self newTextSnippet: 'a snippet').
	aDatabase addPage: aPage.
	aDatabase weak when: LePageTitleChanged send: #add: to: aLongLivedSubscriber.
	aPage weak when: LePageTitleChanged send: #add: to: aLongLivedSubscriber.
	^WeakArray with: aDatabase with: aPage
]

{ #category : #'examples - switching to plain registries' }
LeMixedSubscriptionRegistryExamples >> emptyLogicalDatabaseCanBeSwitched [
	<gtExample>
	| aLogicalDatabase theAnnouncers |
	aLogicalDatabase := self withMixedRegistries: [LeLogicalDatabase new].
	theAnnouncers := OrderedCollection new.
	aLogicalDatabase withAllAnnouncersDo: [:each | theAnnouncers add: each].
	self assert: theAnnouncers asArray
		equals: (Array with: aLogicalDatabase announcer).
	LeUseMixedSubscriptionRegistryFlag
		usePlainSubscriptionRegistriesIn: aLogicalDatabase.
	self assert: aLogicalDatabase announcer subscriptions class
		equals: SubscriptionRegistry.
	^aLogicalDatabase
]

{ #category : #'examples - flag' }
LeMixedSubscriptionRegistryExamples >> enabledDuringOnlyAffectsTheCurrentProcess [
	<gtExample>
	| aGate aDone aPageOfAnotherProcess aPageOfThisProcess anotherProcess |
	aGate := Semaphore new.
	aDone := Semaphore new.
	anotherProcess := 
			[aGate waitTimeoutMilliseconds: 5000.
			aPageOfAnotherProcess := LePage named: 'Created by another process'.
			aDone signal]
					forkAt: Processor activePriority.
	LeUseMixedSubscriptionRegistryFlag disabledDuring: 
			[LeUseMixedSubscriptionRegistryFlag enabledDuring: 
					[aPageOfThisProcess := LePage named: 'Created inside enabledDuring:'.
					aGate signal.
					self assert: (aDone waitTimeoutMilliseconds: 5000) not]].
	self assert: aPageOfThisProcess announcer subscriptions class
		equals: GtMixedSubscriptionRegistry.
	self assert: aPageOfAnotherProcess announcer subscriptions class
		equals: LeUseMixedSubscriptionRegistryFlag newAnnouncer subscriptions class.
	self assert: anotherProcess isTerminated.
	^aPageOfThisProcess
]

{ #category : #'examples - flag' }
LeMixedSubscriptionRegistryExamples >> flagIsDisabledByDefault [
	<gtExample>
	| aPage aDatabase |
	LeUseMixedSubscriptionRegistryFlag disabledDuring: 
			[aPage := LePage named: 'A page with a plain registry'.
			aDatabase := LeDatabase new].
	self assert: aPage announcer subscriptions class
		equals: SubscriptionRegistry.
	self assert: aDatabase announcer subscriptions class
		equals: SubscriptionRegistry.
	self
		assert: (aPage announcer subscriptions subscriptions
				collect: [:each | each class]) asSet
		equals: (Set with: WeakAnnouncementSubscription).
	^aPage
]

{ #category : #'examples - flag' }
LeMixedSubscriptionRegistryExamples >> flagIsReadWhenAModelIsCreated [
	<gtExample>
	| aMixedPage aPlainPage |
	aMixedPage := self newPageNamed: 'Created while the flag is enabled'.
	LeUseMixedSubscriptionRegistryFlag disabledDuring: 
			[aPlainPage := LePage named: 'Created while the flag is disabled'.
			self assert: aMixedPage announcer subscriptions class
				equals: GtMixedSubscriptionRegistry].
	self withMixedRegistries: 
			[self assert: aPlainPage announcer subscriptions class
				equals: SubscriptionRegistry].
	^aMixedPage
]

{ #category : #private }
LeMixedSubscriptionRegistryExamples >> garbageCollectUntil: aBlock [
	^GtMixedSubscriptionRegistryExamples new garbageCollectUntil: aBlock
]

{ #category : #private }
LeMixedSubscriptionRegistryExamples >> hasWeakSubscriberOfClass: aClass on: aLeModel [
	^aLeModel announcer subscriptions allWeakSubscriptions
		anySatisfy: [:each | each subscriber class == aClass]
]

{ #category : #'examples - switching to plain registries' }
LeMixedSubscriptionRegistryExamples >> logicalDatabaseSwitchedToPlainRegistries [
	<gtExample>
	| aLogicalDatabase aDatabase aPage theCountsBefore |
	aDatabase := self newDatabase.
	aPage := self newPageNamed: 'A page of a logical database'.
	aPage addSnippet: (self newTextSnippet: 'a snippet').
	aDatabase addPage: aPage.
	aLogicalDatabase := self withMixedRegistries: [LeLogicalDatabase new].
	aLogicalDatabase primaryDB: aDatabase.
	aLogicalDatabase playgroundDB: aDatabase.
	self assert: (self registryClassesOf: aLogicalDatabase) size equals: 4.
	theCountsBefore := self subscriptionCountsOf: aLogicalDatabase.
	LeUseMixedSubscriptionRegistryFlag
		usePlainSubscriptionRegistriesIn: aLogicalDatabase.
	self assert: (self registryClassesOf: aLogicalDatabase) asSet
		equals: (Set with: SubscriptionRegistry).
	self assert: (self subscriptionCountsOf: aLogicalDatabase)
		equals: theCountsBefore.
	^aLogicalDatabase
]

{ #category : #'private - models' }
LeMixedSubscriptionRegistryExamples >> newDatabase [
	^self withMixedRegistries: [LeDatabase new]
]

{ #category : #'private - models' }
LeMixedSubscriptionRegistryExamples >> newPageNamed: aString [
	^self withMixedRegistries: [LePage named: aString]
]

{ #category : #'private - models' }
LeMixedSubscriptionRegistryExamples >> newTextSnippet: aString [
	^self withMixedRegistries: [LeTextSnippet string: aString]
]

{ #category : #'examples - registry' }
LeMixedSubscriptionRegistryExamples >> pageAnnouncerUsesMixedRegistry [
	<gtExample>
	| aPage aRegistry |
	aPage := self newPageNamed: 'A page with a mixed registry'.
	aRegistry := aPage announcer subscriptions.
	self assert: aRegistry class equals: GtMixedSubscriptionRegistry.
	self assert: aRegistry allStrongSubscriptions isEmpty.
	self
		assert: (aRegistry allWeakSubscriptions
				collect: [:each | each subscriber class]) asSet
		equals: (Set with: LePage with: LePageEditHistory).
	self assert: aRegistry numberOfWeakSubscribers equals: 2.
	self assert: aRegistry hasLeakProneSubscriptionMix not.
	^aPage
]

{ #category : #'examples - registry' }
LeMixedSubscriptionRegistryExamples >> pageSubscriptionsNeedNoFinalizationEntries [
	<gtExample>
	| aPage |
	aPage := self pageAnnouncerUsesMixedRegistry.
	self
		assert: (FinalizationRegistry default ephemeronAtKey: aPage ifAbsent: [nil])
				isNil.
	self
		assert: (FinalizationRegistry default ephemeronAtKey: aPage editHistory
				ifAbsent: [nil]) isNil.
	^aPage
]

{ #category : #'examples - delivery' }
LeMixedSubscriptionRegistryExamples >> pageTitleChangeReachesDatabaseAndViewModel [
	<gtExample>
	| aDatabase aPage aViewModel theAnnouncements |
	aDatabase := self databaseAnnouncerUsesMixedRegistry.
	aPage := self newPageNamed: 'Before'.
	aDatabase addPage: aPage.
	aViewModel := (LePageViewModel new)
				pageModel: aPage;
				yourself.
	self assert: (self hasWeakSubscriberOfClass: LePageViewModel on: aPage).
	theAnnouncements := OrderedCollection new.
	aDatabase weak when: LePageTitleChanged send: #add: to: theAnnouncements.
	aPage updateTitle: 'After'.
	self assert: theAnnouncements size equals: 1.
	self assert: (aDatabase pageNamed: 'After' ifAbsent: [nil]) == aPage.
	self assert: (aDatabase pageNamed: 'Before' ifAbsent: [nil]) isNil.
	^aViewModel
]

{ #category : #'examples - garbage collection' }
LeMixedSubscriptionRegistryExamples >> pageViewModelIsCollectedWhilePageLives [
	<gtExample>
	| aPage theSurvivors |
	aPage := self newPageNamed: 'A page that outlives its view model'.
	theSurvivors := self pageViewModelOn: aPage.
	self assert: (self hasWeakSubscriberOfClass: LePageViewModel on: aPage).
	self assert: (self garbageCollectUntil: [(theSurvivors at: 1) isNil]).
	self assert: (self
				waitUntil: [(self hasWeakSubscriberOfClass: LePageViewModel on: aPage) not]).
	self assert: aPage announcer subscriptions numberOfWeakSubscribers
		equals: 2.
	^aPage
]

{ #category : #'private - scenarios' }
LeMixedSubscriptionRegistryExamples >> pageViewModelOn: aPage [
	^WeakArray with: ((LePageViewModel new)
				pageModel: aPage;
				yourself)
]

{ #category : #'examples - garbage collection' }
LeMixedSubscriptionRegistryExamples >> pageWithStrongSubscriberIsCollectedWhileAWeakSubscriberLives [
	<gtExample>
	| aLongLivedSubscriber theSurvivors |
	aLongLivedSubscriber := OrderedCollection new.
	theSurvivors := self
				pageWithStrongSubscriberObservedWeaklyBy: aLongLivedSubscriber.
	self
		assert: (self garbageCollectUntil: 
					[(theSurvivors at: 1) isNil and: [(theSurvivors at: 2) isNil]]).
	self assert: aLongLivedSubscriber isEmpty.
	^theSurvivors
]

{ #category : #'private - scenarios' }
LeMixedSubscriptionRegistryExamples >> pageWithStrongSubscriberObservedWeaklyBy: aLongLivedSubscriber [
	| aPage aCollector |
	aPage := self newPageNamed: 'A short-lived page'.
	aCollector := OrderedCollection new.
	aPage when: LePageTitleChanged send: #add: to: aCollector.
	aPage weak when: LePageTitleChanged send: #add: to: aLongLivedSubscriber.
	^WeakArray with: aPage with: aCollector
]

{ #category : #'private - models' }
LeMixedSubscriptionRegistryExamples >> registryClassesOf: aLepiterModel [
	| theClasses |
	theClasses := Bag new.
	aLepiterModel
		withAllAnnouncersDo: [:each | theClasses add: each subscriptions class].
	^theClasses
]

{ #category : #'examples - delivery' }
LeMixedSubscriptionRegistryExamples >> snippetChangeReachesPageAndDatabase [
	<gtExample>
	| aDatabase aPage aSnippet thePageAnnouncements theDatabaseAnnouncements |
	aDatabase := self newDatabase.
	aPage := self newPageNamed: 'A page'.
	aDatabase addPage: aPage.
	aSnippet := self newTextSnippet: 'before'.
	aPage addSnippet: aSnippet.
	thePageAnnouncements := OrderedCollection new.
	theDatabaseAnnouncements := OrderedCollection new.
	aPage weak when: LeSnippetTextChanged send: #add: to: thePageAnnouncements.
	aDatabase weak
		when: LeSnippetTextChanged
		send: #add:
		to: theDatabaseAnnouncements.
	aSnippet updateText: 'after' asRopedText.
	self assert: thePageAnnouncements size equals: 1.
	self assert: theDatabaseAnnouncements size equals: 1.
	self assert: aSnippet string equals: 'after'.
	^aPage
]

{ #category : #'private - models' }
LeMixedSubscriptionRegistryExamples >> subscriptionCountsOf: aLepiterModel [
	| theCounts |
	theCounts := OrderedCollection new.
	aLepiterModel
		withAllAnnouncersDo: [:each | theCounts add: each numberOfSubscriptions].
	^theCounts asArray
]

{ #category : #private }
LeMixedSubscriptionRegistryExamples >> waitUntil: aBlock [
	^GtMixedSubscriptionRegistryExamples new waitUntil: aBlock
]

{ #category : #'private - models' }
LeMixedSubscriptionRegistryExamples >> withMixedRegistries: aBlock [
	^LeUseMixedSubscriptionRegistryFlag enabledDuring: aBlock
]

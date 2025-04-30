Class {
	#name : #LeExampleUnnamedCustomPageTypeExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Custom Page Types'
}

{ #category : #example }
LeExampleUnnamedCustomPageTypeExamples >> databaseWithExampleCustomPage [
	<gtExample>
	| database |
	database := LeDatabaseWithLocalMonitorExamples new databaseWithMonitor.
	database monitor
		storage: (LeMockLocalJsonV4StorageWithMissingDeserializers new
				deserializersToRemove: {LeExampleUnnamedCustomPageType}).
	database addPage: LeExampleUnnamedCustomPageType samplePage.
	self assert: database pages size = 1.
	^ database
]

{ #category : #example }
LeExampleUnnamedCustomPageTypeExamples >> deregisterCustomPageTypeAndReloadPage [
	<gtExample>
	| database leJsonV4 reader |
	database := self reloadPage.
	leJsonV4 := database monitor storage leJsonV4.
	leJsonV4 disableDeserializers.
	reader := leJsonV4 newReader.
	self assert: (reader mappings keys includes: LeExampleUnnamedCustomPageType) not.
	database detachPageButKeepFile: database pages first.
	database monitor reload.
	self
		assert: (database pages first type isKindOf: LeUnknownUnnamedPageType)
		description: 'A page with a title and an unknown page type most be loaded into the database as a page with type `LeUnknownNamedPageType`'.
	^ database
]

{ #category : #example }
LeExampleUnnamedCustomPageTypeExamples >> modifyAndReloadPage [
	<gtExample>
	| database page pageJson |
	database := self reregisterCustomPageTypeAndReloadPage.
	page := database pages first.
	page type theAnswer: page type theAnswer + 1.
	page announceTreeChanged: page.
	database monitor reload.
	pageJson := NeoJSONReader
			fromString: (LeJsonV4 uniqueInstance serializePretty: page).
	self assert: (pageJson at: #pageType at: #theAnswer) = 43.
	^ database
]

{ #category : #example }
LeExampleUnnamedCustomPageTypeExamples >> reloadPage [
	<gtExample>
	| database |
	database := self databaseWithExampleCustomPage.
	database detachPageButKeepFile: database pages first.
	database monitor reload.
	self assert: (database pages first type isKindOf: LeExampleUnnamedCustomPageType).
	^ database
]

{ #category : #example }
LeExampleUnnamedCustomPageTypeExamples >> reregisterCustomPageTypeAndReloadPage [
	<gtExample>
	| database leJsonV4 reader |
	database := self deregisterCustomPageTypeAndReloadPage.
	leJsonV4 := database monitor storage leJsonV4.
	leJsonV4 enableDeserializers.
	reader := leJsonV4 newReader.
	self assert: (reader mappings keys includes: LeExampleUnnamedCustomPageType).
	database detachPageButKeepFile: database pages first.
	database monitor reload.
	self flag: #TODO. "Check page hash optimization. unknown page types should be excluded and tried to be reloaded."
	self
		assert: (database pages first type isKindOf: LeExampleUnnamedCustomPageType)
		description: 'If code that handles custom page types is loaded and database reloaded, page should get reloaded as the correct page type.'.
	^ database
]

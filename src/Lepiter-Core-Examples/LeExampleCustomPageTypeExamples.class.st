Class {
	#name : #LeExampleCustomPageTypeExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Custom Page Types'
}

{ #category : #example }
LeExampleCustomPageTypeExamples >> databaseWithExampleCustomPage [
	<gtExample>
	| database |
	database := LeDatabaseWithLocalMonitorExamples new databaseWithMonitor.
	database monitor
		storage: (LeMockLocalJsonV4StorageWithMissingDeserializers new
				deserializersToRemove: {LeExampleCustomPageType}).
	database addPage: LeExampleCustomPageType samplePage.
	self assert: database pages size = 1.
	^ database
]

{ #category : #example }
LeExampleCustomPageTypeExamples >> deregisterCustomPageTypeAndReloadPage [
	<gtExample>
	| database leJsonV4 reader |
	database := self reloadPage.
	leJsonV4 := database monitor storage leJsonV4.
	leJsonV4 disableDeserializers.
	reader := leJsonV4 newReader.
	self assert: (reader mappings keys includes: LeExampleCustomPageType) not.
	database detachPageButKeepFile: database pages first.
	database monitor reload.
	self
		assert: (database pages first type isKindOf: LeUnknownNamedPageType)
		description: 'A page with a title and an unknown page type most be loaded into the database as a page with type `LeUnknownNamedPageType`'.
	^ database
]

{ #category : #example }
LeExampleCustomPageTypeExamples >> reloadPage [
	<gtExample>
	| database |
	database := self databaseWithExampleCustomPage.
	database detachPageButKeepFile: database pages first.
	database monitor reload.
	self assert: (database pages first type isKindOf: LeExampleCustomPageType).
	^ database
]

{ #category : #example }
LeExampleCustomPageTypeExamples >> reregisterCustomPageTypeAndReloadPage [
	<gtExample>
	| database leJsonV4 reader |
	database := self deregisterCustomPageTypeAndReloadPage.
	leJsonV4 := database monitor storage leJsonV4.
	leJsonV4 enableDeserializers.
	reader := leJsonV4 newReader.
	self assert: (reader mappings keys includes: LeExampleCustomPageType).
	database detachPageButKeepFile: database pages first.
	database monitor reload.
	self flag: #TODO. "Check page hash optimization. unknown page types should be excluded and tried to be reloaded."
	self
		assert: (database pages first type isKindOf: LeExampleCustomPageType)
		description: 'If code that handles custom page types is loaded and database reloaded, page should get reloaded as the correct page type.'.
	^ database
]

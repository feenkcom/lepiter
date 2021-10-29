Class {
	#name : #LeAbstractDatabaseViewModel,
	#superclass : #LeContentViewModel,
	#instVars : [
		'pagesMap'
	],
	#category : 'Lepiter-UI-! UI - Database'
}

{ #category : #'api - accessing' }
LeAbstractDatabaseViewModel >> database [
	^ self content
]

{ #category : #'api - accessing' }
LeAbstractDatabaseViewModel >> database: aLeLogicalDatabase [
	self content: aLeLogicalDatabase
]

{ #category : #'gt-extension' }
LeAbstractDatabaseViewModel >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ 
			LeDatabaseFilteredTreeElement new 
				databaseViewModel: self;
				matchParent ]
]

{ #category : #initialization }
LeAbstractDatabaseViewModel >> initialize [
	super initialize.
	
	pagesMap := IdentityDictionary new
]

{ #category : #'api - accessing' }
LeAbstractDatabaseViewModel >> pageUIModelFor: aPage [
	^ pagesMap
		at: aPage
		ifAbsentPut: [ aPage asContentUIModel databaseViewModel: self ]
]

{ #category : #'api - accessing' }
LeAbstractDatabaseViewModel >> pageUIModelsFor: aCollectionOfPages [
	<return: #Collection of: #LePageViewModel>

	^ aCollectionOfPages collect: [ :eachPage | self pageUIModelFor: eachPage ]
]

{ #category : #'api - accessing' }
LeAbstractDatabaseViewModel >> registerPageViewModel: aPageViewModel [
	pagesMap at: aPageViewModel pageModel put: aPageViewModel
]

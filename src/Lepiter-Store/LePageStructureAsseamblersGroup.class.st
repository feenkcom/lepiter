Class {
	#name : #LePageStructureAsseamblersGroup,
	#superclass : #Object,
	#traits : 'TGtGroup',
	#classTraits : 'TGtGroup classTrait',
	#instVars : [
		'items'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #'instance creation' }
LePageStructureAsseamblersGroup class >> withAll: aCollection [
	^ self new 
		initializeWith: aCollection
]

{ #category : #adding }
LePageStructureAsseamblersGroup >> add: anAsseambler [
	self items add: anAsseambler
]

{ #category : #'gt - extensions' }
LePageStructureAsseamblersGroup >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Page reloads';
		items: [ self items ];
		column: 'Page' text: [ :asseambler | 
			asseambler targetPage ifNotNil: [ :aPage | aPage title ] ];
		column: 'Operations count' 
			text: [ :asseambler | asseambler operationsCount ]
			width: 150
]

{ #category : #initialization }
LePageStructureAsseamblersGroup >> initialize [
	super initialize.
	items := OrderedCollection new.
]

{ #category : #initialization }
LePageStructureAsseamblersGroup >> initializeWith: aCollection [
	items := aCollection
]

{ #category : #accessing }
LePageStructureAsseamblersGroup >> items [
	^ items
]

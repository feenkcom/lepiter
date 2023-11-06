Class {
	#name : #LePageStructureAssemblersGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'Lepiter-Store-Reload'
}

{ #category : #'gt - extensions' }
LePageStructureAssemblersGroup >> gtItemsFor: aView [
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
LePageStructureAssemblersGroup >> initializeWith: aCollection [
	items := aCollection
]

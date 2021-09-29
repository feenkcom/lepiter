Class {
	#name : 'LePageValidatorMissingReferencesGroup',
	#superclass : 'Object',
	#instVars : [
		'missingReferences'
	],
	#category : 'Lepiter-Validator-Model'
}

{ #category : 'adding' }
LePageValidatorMissingReferencesGroup >> addMissingReferences: aMissingReferencesResult [
	missingReferences add: aMissingReferencesResult
]

{ #category : 'enumerating' }
LePageValidatorMissingReferencesGroup >> collect: aBlock [
	^ missingReferences collect: aBlock
]

{ #category : 'accessing' }
LePageValidatorMissingReferencesGroup >> gtItemsFor: aView [
	<gtView>
	^ aView list
		title: 'Items';
		priority: 10;
		items: [ missingReferences ];
		itemText: [ :aResult | aResult targetPage gtDisplayString ];
		send: [ :aResult | aResult targetPage ]
]

{ #category : 'accessing' }
LePageValidatorMissingReferencesGroup >> gtViewReferencesFor: aView [
	<gtView>
	<gtView>
	^ aView list
		title: 'Missing references by page';
		priority: 20;
		items: [ missingReferences ];
		itemText: [ :aResult | aResult targetPage gtDisplayString ]
]

{ #category : 'initialization' }
LePageValidatorMissingReferencesGroup >> initialize [
	super initialize.
	missingReferences := OrderedCollection new.
]

{ #category : 'testing' }
LePageValidatorMissingReferencesGroup >> isEmpty [
	^ missingReferences isEmpty
]

{ #category : 'accessing' }
LePageValidatorMissingReferencesGroup >> size [
	^ missingReferences size
]

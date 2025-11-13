Class {
	#name : #LePages,
	#superclass : #LeCollection,
	#category : #'Lepiter-Core-Model'
}

{ #category : #visiting }
LePages >> acceptVisitor: aVisitor [

	^ aVisitor visitPages: self
]

{ #category : #'gt-extensions' }
LePages >> gtNamedPagesFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Named pages';
		withMultipleSelection;
		priority: 1;
		items: [ (items select: [ :each | each isNamedPage or: [ each isUnnamedPage ] ])
				sorted: [ :a :b | a latestEditTime > b latestEditTime ] ];
"		children: [ :eachPage | eachPage children ];
"		column: 'Content' text: #contentAsString;
		column: 'Edit Time' text: #latestEditTime
]

{ #category : #'gt-extensions' }
LePages >> gtPagesFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'All pages';
		priority: 10;
		items: [ items sorted: [:a :b | a latestEditTime > b latestEditTime ] ];
		children: [ :eachPage | eachPage children ];
		column: 'Content' text: #contentAsString;
		column: 'Type' text: [:each | each type class ] width: 200;
		column: 'Edit Time' text: [:each | each latestEditTime time printToSeconds ] width: 200
]

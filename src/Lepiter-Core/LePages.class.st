Class {
	#name : #LePages,
	#superclass : #LeCollection,
	#category : 'Lepiter-Core-Model'
}

{ #category : #visiting }
LePages >> acceptVisitor: aVisitor [

	^ aVisitor visitPages: self
]

{ #category : #'gt-extensions' }
LePages >> gtPagesFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Pages';
		priority: 10;
		items: [ self ];
		children: [ :eachPage | eachPage children ];
		expandUpTo: 5;
		column: 'Content' item: #contentAsString;
		column: 'Edit Time' item: #latestEditTime;
		column: 'Author' item: #editEmail
]

Class {
	#name : #LeAppliedFilter,
	#superclass : #Object,
	#instVars : [
		'database',
		'filter'
	],
	#category : 'Lepiter-UI-Database - Filters'
}

{ #category : #accessing }
LeAppliedFilter >> database [
	^ database
]

{ #category : #accessing }
LeAppliedFilter >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #accessing }
LeAppliedFilter >> filter [
	^ filter
]

{ #category : #accessing }
LeAppliedFilter >> filter: aLeFilter [
	filter := aLeFilter
]

{ #category : #'gt-extensions' }
LeAppliedFilter >> gtPagesView: aView [
	<gtView>
	^ aView explicit
		title: 'Pages';
		priority: 1;
		stencil: [ LeDatabaseFilteredCardElement new appliedFilter: self ]
]

{ #category : #accessing }
LeAppliedFilter >> pages [
	^ self database pages select: [ :each | self filter matches: each ]
]

{ #category : #accessing }
LeAppliedFilter >> printOn: aStream [
	super printOn: aStream.
	self filter ifNotNil: [
		aStream nextPutAll: ' ('.
		self filter printOn: aStream.
		aStream nextPutAll: ')' ].
]

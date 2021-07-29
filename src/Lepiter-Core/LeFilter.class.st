Class {
	#name : #LeFilter,
	#superclass : #Object,
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #accessing }
LeFilter class >> allFilterDescriptorsFor: aLeDatabase [
	| filters |
	filters := OrderedCollection new.
	self withAllSubclasses
		do: [ :each | 
			each
				filterDescriptorFor: aLeDatabase
				do: [ :filter | filters add: filter ] ].
	^ filters
		sort:
			[ :a :b | a order < b order or: [ a order = b order and: [ a name < b name ] ] ]
]

{ #category : #accessing }
LeFilter class >> filterDescriptorFor: aLeDatabase do: aBlock [
	
]

{ #category : #'logical operations' }
LeFilter >> & anotherFilter [
	^ LeAndFilter new
		left: self;
		right: anotherFilter;
		yourself
]

{ #category : #testing }
LeFilter >> matches: aLeContent [
	"Answer a boolean indicating if the supplied content (page) matches the receiver's criteria"

	^ self subclassResponsibility
]

{ #category : #'logical operations' }
LeFilter >> not [
	^ LeNotFilter new
		filter: self;
		yourself
]

{ #category : #'logical operations' }
LeFilter >> | anotherFilter [
	^ LeOrFilter new
		left: self;
		right: anotherFilter;
		yourself
]

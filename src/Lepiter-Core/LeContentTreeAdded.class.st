"
LeContentTreeAdded is used to announce that content has been added to a page.

The parent is the parent object of where the content has been added.  The index is where the content was added. 
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	index:		<Integer>
	parent:	<LeContent>


### Implementation Points

"
Class {
	#name : #LeContentTreeAdded,
	#superclass : #LeContentTreeChanged,
	#instVars : [
		'parent',
		'index'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeContentTreeAdded >> index [
	^ index
]

{ #category : #accessing }
LeContentTreeAdded >> index: anObject [
	index := anObject
]

{ #category : #accessing }
LeContentTreeAdded >> parent [
	^ parent
]

{ #category : #accessing }
LeContentTreeAdded >> parent: anObject [
	parent := anObject
]

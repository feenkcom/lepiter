Class {
	#name : #LeTextualSnippet,
	#superclass : #LeSnippet,
	#traits : 'TLeUnlinkedReferencesUpdate',
	#classTraits : 'TLeUnlinkedReferencesUpdate classTrait',
	#category : #'Lepiter-Core-Model'
}

{ #category : #visiting }
LeTextualSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitTextualSnippet: self
]

{ #category : #'private - notifications' }
LeTextualSnippet >> announceTextChangedBy: anObject [
	"Notify all dependents that the receiver's text has changed"

	self notifyAnnouncement: (LeSnippetTextChanged new
		source: anObject;
		snippet: self)
]

{ #category : #'api - editing' }
LeTextualSnippet >> appendText: aText [
	"Append the supplied text to the receiver, update metadata and notify dependents of the change"

	^ self appendText: aText source: self
]

{ #category : #'api - editing' }
LeTextualSnippet >> appendText: aText source: anObject [
	"Append the supplied text to the receiver, update metadata and notify dependents of the change"
	
	self subclassResponsibility
]

{ #category : #testing }
LeTextualSnippet >> hasText [
	<return: #Boolean>
	^ self text isNotNil and: [ self text isNotEmpty ]
]

{ #category : #'api - testing' }
LeTextualSnippet >> isEmpty [
	"Answer a boolean indicating whether the receiver is considered empty.
	For textual snippets, this is whether the snippet has no text and no children with text.
	Non-textual snippets will have different criteria."

	^ super isEmpty and: [ self hasText not ]
]

{ #category : #'api - testing' }
LeTextualSnippet >> isNotEmpty [
	"Answer a boolean indicating whether the receiver is considered empty.
	For textual snippets, this is whether the snippet has no text and no children with text.
	Non-textual snippets will have different criteria."

	^ super isNotEmpty or: [ self hasText ]
]

{ #category : #'private - exporting' }
LeTextualSnippet >> markdownOn: stream level: anInteger [
	"Write the receiver as an HTML string on the supplied stream.
	This is currently a simplistic implementation which doesn't handle line breaks within the block properly (they need to be indented)"

	(self hasText or: [ self hasChildren ])
		ifFalse: [ ^ self ].
	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		<< '- ';
		<< self contentAsString trimBoth.
	self
		childrenDo: [ :child | 
			stream cr.
			child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #'api - editing' }
LeTextualSnippet >> mergeAndRemoveSelfOrSnippet: aSnippet [
	"Merge the receiver block with the supplied block appending the text of the supplied block to my text.
	Remove one of the two blocks and merges the content of the other into the remaining one.
	Which block is remove depends on their content. Callers should assume either one of the two blocks can 
	be removed. Return the block into which the content was merged."

	"If the receiver is empty and has no children, simply remove the receiver, 
	as it is faster than removing aBlock."
	(self hasChildren not and: [ self hasText not]) ifTrue: [ 
		self removeSelf.
		^ aSnippet ].
	
	"Append aBlock's text to the end of the receiver and aBlock's children 
	to the end of the receiver's children"
	self appendText: aSnippet text.

	aSnippet transferChildrenTo: self.
	aSnippet removeSelf.

	self updateEditTimeAndEmail.

	^ self
]

{ #category : #'private - hooks' }
LeTextualSnippet >> onAddedToDatabase [ 
	super onAddedToDatabase.
	
	self updateUnlinkedReferences
]

{ #category : #'private - hooks' }
LeTextualSnippet >> onRemovedFromDatabase: aDatabase [
	super onRemovedFromDatabase: aDatabase.
	
	self removeUnlinkedReferencesFromDatabase: aDatabase.
]

{ #category : #'api - editing' }
LeTextualSnippet >> requestMergeWithSnippet: aSnippet [
	^ aSnippet class = self class 
		ifFalse: [ self ]
		ifTrue: [ self mergeAndRemoveSelfOrSnippet: aSnippet ]
]

{ #category : #accessing }
LeTextualSnippet >> text [
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'api - editing' }
LeTextualSnippet >> updateText: aText [
	^ self updateText: aText source: self
]

{ #category : #'api - editing' }
LeTextualSnippet >> updateText: aText source: anObject [
	"Change the text of the textual snippet to a given once. A source object represent an object that requested a text change"

	self subclassResponsibility
]

{ #category : #updating }
LeTextualSnippet >> updateUnlinkedReferences [
	"Update unlinked references the receiver may have to other pages.
	Subclasses that support unlinked references should call this when they are updated."

	LeUnlinkedReferenceMaintenance submitForBlock: self.
]

"
#Text snippet
I am a textual snippet.

I understand basic markdown and can be extended with new snippet types and annotations.

"
Class {
	#name : #LeTextualSnippet,
	#superclass : #LeSnippet,
	#traits : 'TLeUnlinkedReferencesUpdate',
	#classTraits : 'TLeUnlinkedReferencesUpdate classTrait',
	#category : #'Lepiter-Core-Model'
}

{ #category : #utils }
LeTextualSnippet class >> createTextAttributeWithValue: aSnippetText [
	^ LeTextualSnippetTextAttribute new
		text: aSnippetText 
]

{ #category : #testing }
LeTextualSnippet class >> isAbstract [
	^ self name = #LeTextualSnippet
]

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
LeTextualSnippet >> canMoveToAnotherDatabase [
	(self incomingLinks anySatisfy: [ :aLink | aLink isAttachedLink ])
		ifTrue: [ ^ false ].
	(self outgoingExplicitLinks anySatisfy: [ :aLink | aLink isAttachedLink ])
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #'private - testing' }
LeTextualSnippet >> hasContent [
	"Answer a boolean indicating whether the receiver is considered without content.
	For textual snippets, this is whether the snippet has no text.
	Non-textual snippets will have different criteria.
	
	See {{gtMethod:LeContent>>#hasContent}} for more details."

	^ self hasText
]

{ #category : #testing }
LeTextualSnippet >> hasText [
	<return: #Boolean>
	^ self text isNotNil and: [ self text isNotEmpty ]
]

{ #category : #'api - testing' }
LeTextualSnippet >> isTextualSnippet [

	^ true
]

{ #category : #'private - exporting' }
LeTextualSnippet >> markdownOn: stream level: anInteger [
	"Write the receiver as an HTML string on the supplied stream.
	This is currently a simplistic implementation which doesn't handle line breaks within the block properly (they need to be indented)"

	(self hasText or: [ self hasChildren ]) ifFalse: [ ^ self ].
	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		<< (anInteger > 0 ifTrue: [ '- ' ] ifFalse: [ '' ]);
		<< self contentAsString trimBoth.
	self
		childrenDo: [ :child | 
			stream cr.
			child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #'api - editing' }
LeTextualSnippet >> mergeAndRemoveSelfOrSnippet: aSnippet [
	"Merge the receiver snippet with the supplied snippet appending the text of the supplied snippet to my text. Remove one of the two snippets and merges the content of the other into the remaining one.
	Which snippet is remove depends on their content. Callers should assume either one of the two snippets can be removed. Return the snippet into which the content was merged."

	"If the receiver is empty and has no children, simply remove the receiver, as it is faster than removing aSnippet."
	(self hasChildren not and: [ self hasText not]) ifTrue: [ 
		self removeSelf.
		^ aSnippet ].
	
	"Append aSnippet's text to the end of the receiver and aSnippet's children 
	to the end of the receiver's children"
	
	self appendText: aSnippet text.
	aSnippet transferChildrenTo: self.
	aSnippet removeSelf.

	^ self
]

{ #category : #'api - command operations' }
LeTextualSnippet >> mergeAndRemoveSelfOrSnippetThroughCommandFor: aSnippet [
	"Merge the receiver snippet with the supplied snippet appending the text of the supplied snippet to my text. Remove one of the two snippets and merges the content of the other into the remaining one.
	Which snippet is remove depends on their content. Callers should assume either one of the two snippets can be removed. Return the snippet into which the content was merged."

	"If the receiver is empty and has no children, simply remove the receiver, as it is faster than removing aSnippet."
	
	(self hasChildren not and: [ self hasText not]) ifTrue: [ 
		self removeSelfThroughCommand.
		^ aSnippet ].
	
	"Append aSnippet's text to the end of the receiver and aSnippet's children 
	to the end of the receiver's children"
	
	self mergeSnippetThroughCommandWith: aSnippet.

	^ self
]

{ #category : #'api - command building' }
LeTextualSnippet >> mergeSnippetCommandWith: aNextSnippet [
	^ self commandBuilder 
		mergeSnippetCommandWith: aNextSnippet
]

{ #category : #'api - command operations' }
LeTextualSnippet >> mergeSnippetThroughCommandWith: aSnippet [
	^ (self mergeSnippetCommandWith: aSnippet) execute
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

{ #category : #'api - command building' }
LeTextualSnippet >> splitSnippetCommandAtPosition: aCursorPosition [
	^ self commandBuilder splitSnippetCommandAtPosition: aCursorPosition
]

{ #category : #accessing }
LeTextualSnippet >> string [
	<return: #String>
	
	^ self text asString
]

{ #category : #accessing }
LeTextualSnippet >> text [
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'api - editing' }
LeTextualSnippet >> updateString: aString [
	self 
		assert: [ aString isString ] 
		description: [ 'aBlock>>#updateString: aString parameter must be a string' ].
	
	self updateText: aString asRopedText
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

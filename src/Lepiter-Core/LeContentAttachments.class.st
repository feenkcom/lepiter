Class {
	#name : #LeContentAttachments,
	#superclass : #Object,
	#instVars : [
		'items',
		'content',
		'scope'
	],
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #'api - initialization' }
LeContentAttachments >> content: aLeContent [
	"Set a content for which attachments are collected."

	content := aLeContent
]

{ #category : #enumerating }
LeContentAttachments >> do: aBlock [
	^ self items do: aBlock
]

{ #category : #accessing }
LeContentAttachments >> gtAttachmentsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Attachments';
		priority: 10;
		items: [ self items ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Path'
			text: #name
			weight: 2;
		column: 'Description'
			text: [ :anAttachment | 
				'used by {1} {2}'
					format: {anAttachment snippets size.
							'snippet' asPluralBasedOn: anAttachment snippets size} ]
]

{ #category : #'gt - extensions' }
LeContentAttachments >> gtDetails [
	^ OrderedDictionary new
		at: 'Content' put: content;
		at: 'Collection scope' put: scope;
		yourself
]

{ #category : #'gt - extensions' }
LeContentAttachments >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 60;
		items: [ self gtDetails associations ];
		column: 'Name' text: #key;
		column: 'Value'
			text: #value
			weight: 3;
		send: #value
]

{ #category : #'gt - extensions' }
LeContentAttachments >> gtLiveFor: aView [
	^ self gtAttachmentsFor: aView
]

{ #category : #accessing }
LeContentAttachments >> items [
	^ items ifNil: [ #() ]
]

{ #category : #'api - initialization' }
LeContentAttachments >> items: attachments [
	items := attachments
]

{ #category : #printing }
LeContentAttachments >> printOn: aStream [
	super printOn: aStream.

	items ifNil: [ ^ self ].

	aStream
		space;
		nextPut: $[;
		print: self size;
		nextPutAll: (' attachment' asPluralBasedOn: self size);
		nextPut: $]
]

{ #category : #'api - enumerating' }
LeContentAttachments >> scope: aScope [
	"Set a scope which was used to collect attachments, 
	e.g., local attachments, all attachments."

	scope := aScope
]

{ #category : #accessing }
LeContentAttachments >> size [
	^ self items size
]

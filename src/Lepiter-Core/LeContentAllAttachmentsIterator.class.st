Class {
	#name : #LeContentAllAttachmentsIterator,
	#superclass : #Object,
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #accessing }
LeContentAllAttachmentsIterator >> content: aContent attachmentsInto: aSnippetAttachments [
	| aLocalIterator |
	aLocalIterator := LeContentLocalAttachmentsIterator new.
	aContent
		withAllChildrenBreadthFirstDo: [ :eachSnippet | aLocalIterator content: eachSnippet attachmentsInto: aSnippetAttachments ]
]

{ #category : #accessing }
LeContentAllAttachmentsIterator >> scope [
	^ LeContentAllIteratorScope default
]

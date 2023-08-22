Class {
	#name : #LeSnippetAllAttachmentsIterator,
	#superclass : #Object,
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #accessing }
LeSnippetAllAttachmentsIterator >> scope [
	^ LeSnippetAllIteratorScope default
]

{ #category : #accessing }
LeSnippetAllAttachmentsIterator >> snippet: aSnippet attachmentsInto: aSnippetAttachments [
	| aLocalIterator |
	aLocalIterator := LeSnippetLocalAttachmentsIterator new.
	aSnippet
		withAllChildrenBreadthFirstDo: [ :eachSnippet | aLocalIterator snippet: eachSnippet attachmentsInto: aSnippetAttachments ]
]

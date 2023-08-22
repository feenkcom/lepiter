Class {
	#name : #LeContentLocalAttachmentsIterator,
	#superclass : #Object,
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #'api - enumerating' }
LeContentLocalAttachmentsIterator >> content: aSnippet attachmentsInto: aSnippetAttachments [
	aSnippet attachmentNames
		do: [ :aName | aSnippetAttachments 
			addSnippet: aSnippet 
			attachmentNamed: aName ]
]

{ #category : #accessing }
LeContentLocalAttachmentsIterator >> scope [
	^ LeContentLocalIteratorScope default
]

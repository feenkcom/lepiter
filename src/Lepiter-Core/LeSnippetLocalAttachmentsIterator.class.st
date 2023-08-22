Class {
	#name : #LeSnippetLocalAttachmentsIterator,
	#superclass : #Object,
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #'api - enumerating' }
LeSnippetLocalAttachmentsIterator >> snippet: aSnippet attachmentsInto: aSnippetAttachments [
	aSnippet attachmentNames
		do: [ :aName | aSnippetAttachments 
			addSnippet: aSnippet 
			attachmentNamed: aName ]
]

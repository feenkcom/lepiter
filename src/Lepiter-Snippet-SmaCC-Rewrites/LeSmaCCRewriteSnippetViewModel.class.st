Class {
	#name : #LeSmaCCRewriteSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-View-Model'
}

{ #category : #'api - accessing' }
LeSmaCCRewriteSnippetViewModel >> snippetElementClass [
	^ LeSmaCCRewriteSnippetElement
]

{ #category : #accessing }
LeSmaCCRewriteSnippetViewModel >> snippetView [
	<return: #LeSnippetView>
	^ super snippetView needsContentDecorationBar: true
]

{ #category : #accessing }
LeSmaCCRewriteSnippetViewModel >> subscribeToSnippetModel [
	super subscribeToSnippetModel.
	self snippetModel weak
		when: LeSmaCCRewriteSnippetSearchChanged
			send: #announce:
			to: self;
		when: LeSmaCCRewriteSnippetReplaceChanged
			send: #announce:
			to: self;
		when: LeSmaCCRewriteSnippetScopeChanged
			send: #announce:
			to: self;
		when: LeSmaCCRewriteSnippetParserChanged
			send: #announce:
			to: self;
		when: LeSmaCCRewriteSnippetStartingStateChanged
			send: #announce:
			to: self
]

{ #category : #accessing }
LeSmaCCRewriteSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.
	self snippetModel unsubscribe: self
]

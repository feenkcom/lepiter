Class {
	#name : #LePharoRewriteSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : #'Lepiter-Snippet-Pharo-Rewrites-View-Model'
}

{ #category : #'api - accessing' }
LePharoRewriteSnippetViewModel >> snippetElementClass [
	^ LePharoRewriteSnippetElement
]

{ #category : #accessing }
LePharoRewriteSnippetViewModel >> snippetView [
	<return: #LeSnippetView>
	^ super snippetView needsContentDecorationBar: true
]

{ #category : #accessing }
LePharoRewriteSnippetViewModel >> subscribeToSnippetModel [
	super subscribeToSnippetModel.
	self snippetModel weak
		when: LePharoRewriteSnippetSearchChanged
			send: #announce:
			to: self;
		when: LePharoRewriteSnippetReplaceChanged
			send: #announce:
			to: self;
		when: LePharoRewriteSnippetScopeChanged
			send: #announce:
			to: self;
		when: LePharoRewriteSnippetIsMethodPatternChanged
			send: #announce:
			to: self
]

{ #category : #accessing }
LePharoRewriteSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.
	self snippetModel unsubscribe: self
]

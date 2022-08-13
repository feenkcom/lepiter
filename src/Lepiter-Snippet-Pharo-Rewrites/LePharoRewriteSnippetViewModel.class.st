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
